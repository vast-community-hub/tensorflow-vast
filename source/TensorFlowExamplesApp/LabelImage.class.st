"
This example shows how you can use a pre-trained TensorFlow network and use it to recognize objects in images.

Before using it, you have to copy the directory `examples` 
from the git root directory to your Smalltalk image working directory. 

3 important things are specified either from setters or from #initialize, which are:

  * graphFile: a TensorFlow GraphDef that contains the model definition and weights,
    default is 'examples\labelImage\inception_v3_2016_08_28_frozen.pb'.
  * imageFile: the image/photo file to be recognized, default is 'examples\labelImage\grace_hopper.jpg'.
  * labelsFile: results of the classification is an array of probabilities for each
    category, it need a file of labels for each category to map numbers to categories,
    default is 'examples\labelImage\labels.txt'.
	

Simplest example using mobilenet:
```
((LabelImage new
		imageSize: 224 @ 224;
		graphFile: 'examples\labelImage\mobilenet_v1_1.0_224_quant_frozen.pb';
		labelsFile: 'examples\labelImage\labels.txt';
		addImageFile: 'examples\labelImage\grace_hopper.jpg';
		prepareImageInput;
		prepareSession;
		predict)
			first
				first: 10)
					collect: [:each | each key -> ((each value * 100) roundTo: 0.01) asString]
```
You can inspect the 5 top results to see the following:
```
('military uniform' -> 3.97301852703094e-1 
'Windsor tie' -> 2.41386100649834e-1 
'bow tie, bow-tie, bowtie' -> 1.05204053223133e-1)
```

You can then run Inception V3 like what described at 
https://github.com/tensorflow/tensorflow/tree/master/tensorflow/examples/label_image/README.md.

```
|results|
results := LabelImage new
	imageSize: 299 @ 299;
	graphFile: 'examples\labelImage\inception_v3_2016_08_28_frozen.pb';
	labelsFile: 'examples\labelImage\labels.txt';
	addImageFile: 'examples\labelImage\grace_hopper.jpg';
	prepareImageInput;
    prepareSession;
    predict.
Transcript cr.
results do: [ :eachImage |
	(eachImage first: 3) do: [:each |
		Transcript 
			show: each key;
			show: ' %';
			show: ((each value * 100) roundTo: 0.01) asString;
			cr.
	]
].
```

You can even run multiple images in parallel:

```
|results|
results := LabelImage new
	imageSize: 299 @ 299;
	graphFile: 'examples\labelImage\inception_v3_2016_08_28_frozen.pb';
	labelsFile: 'examples\labelImage\labels.txt';
	addImageFile: 'examples\labelImage\grace_hopper.jpg';
	addImageFile: 'examples\labelImage\ski.jpg';
	addImageFile: 'examples\labelImage\Carrillon-Escobar-1.jpg';
	addImageFile: 'examples\labelImage\byteSmalltalk.jpg';
	prepareImageInput;
    prepareSession;
    predict.
Transcript cr.
results do: [ :eachImage |
	(eachImage first: 3) do: [:each |
		Transcript 
			show: each key;
			show: ' %';
			show: ((each value * 100) roundTo: 0.01) asString;
			cr.
	].
	Transcript cr. 
].    
```
"
Class {
	#name : 'LabelImage',
	#superclass : 'FrozenImagePredictor',
	#category : 'TensorFlowExamplesApp'
}

{ #category : 'helpers' }
LabelImage >> colorToArray: aColor [
	^Array 
		with: (aColor red - inputMean) / inputStddev
		with: (aColor green - inputMean) / inputStddev
		with: (aColor blue - inputMean) / inputStddev
]

{ #category : 'helpers' }
LabelImage >> imageToArray: image [

	| answer |

	answer := OrderedCollection new: imageSize y * imageSize x.
	0 to: imageSize y - 1 do: [:y | | p |
		0 to: imageSize x - 1 do: [:x |
			p := image getColor: x y: y.
			answer add: (self colorToArray: p)]].

	^answer
]

{ #category : 'initialization' }
LabelImage >> initialize [
	"Be careful because imageSize depends on the proto buffer used,
	so you must check its documentation for a correct size"

	super initialize. 
	imageSize := 299 @ 299.
	graphFile := 'examples\labelImage\inception_v3_2016_08_28_frozen.pb'.
	labelsFile := 'examples\labelImage\labels.txt'.
	self addImageFile: 'examples\labelImage\grace_hopper.jpg'


]

{ #category : 'run' }
LabelImage >> predict [

	| results labels |

	labels := self readLabels.
	results :=
		graph
			runInputs: (Array with: (graph allInputs first input: 0))
			values: (Array with: inputValues)
			outputs: (Array with: (graph allOperations last firstOutput)).
	results := results first asNumbers.
	results :=
		results collect: [:eachImage | | labeled |
			labeled := (1 to: eachImage size) collect: [:i | (labels at: i) -> (eachImage at: i)].
			labeled sort: [:a :b | a value > b value]].
	^results
]

{ #category : 'helpers' }
LabelImage >> readLabels [

	| labels |

	labels := OrderedCollection new.
	labelsFile asPath readStreamDo: [:strm |
		strm contents linesDo: [:aLine |
			labels add: (
				aLine readStream
					upTo: $:;
					upToEnd)]].
	^labels
]
