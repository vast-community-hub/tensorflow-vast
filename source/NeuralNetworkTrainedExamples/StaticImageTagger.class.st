Class {
	#name : 'StaticImageTagger',
	#superclass : 'StaticImageAnalizer',
	#instVars : [
		'labelsFile',
		'imageEncoder',
		'outputOperationName',
		'tf'
	],
	#category : 'NeuralNetworkTrainedExamples'
}

{ #category : 'Instance Creation' }
StaticImageTagger class >> example [

	| results images |
	
	images := #(
		'examples\labelImage\Carrillon-Escobar-1.jpg'
		'examples\labelImage\grace_hopper.jpg'
		'examples\labelImage\ski.jpg'
	). 
	results := StaticImageTagger usingInceptionV3 labelAll: images.
	
	images with: results do: [:image :labels |
		Transcript cr; cr; show: image. 
		(labels first: 3) do: [:labelAndScore |
			Transcript
				cr; 
				tab; show: labelAndScore key;
				tab; show: ((labelAndScore value * 100) roundTo: 0.01) asString;
				show: ' %']]
]

{ #category : 'Instance Creation' }
StaticImageTagger class >> new [

	^self usingInceptionV3
]

{ #category : 'Instance Creation',
  #vaVisibility : 'private' }
StaticImageTagger class >> usingGraphDefinedIn: aProtoBufferFilePath obtainingPredictionsFrom: anOperationName [

	^super new
		initializeUsingGraphDefinedIn: aProtoBufferFilePath
		obtainingPredictionsFrom: anOperationName
]

{ #category : 'Instance Creation' }
StaticImageTagger class >> usingInceptionV3 [

	^self
		usingGraphDefinedIn: 'examples\labelImage\inception_v3_2016_08_28_frozen.pb'
		obtainingPredictionsFrom: 'InceptionV3/Predictions/Reshape_1'
]

{ #category : 'Instance Creation' }
StaticImageTagger class >> usingMobilenetV1 [

	^self
		usingGraphDefinedIn: 'examples\labelImage\mobilenet_v1_1.0_224_quant_frozen.pb'
		obtainingPredictionsFrom: 'MobilenetV1/Predictions/Reshape_1'
]

{ #category : 'Processing' }
StaticImageTagger >> analizeAll: aFileNameCollection [

	^tf
		computeAllNamed: (Array with: outputOperationName)
		feedingInputsWith: (
			Dictionary new
				at: 'input' put: (imageEncoder encodeAll: aFileNameCollection);
				yourself)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
StaticImageTagger >> initializeUsingGraphDefinedIn: aGraphFile obtainingPredictionsFrom: anOperationName [

	super initialize.

	tf := TensorFlowComputation on: (TFGraph fromFileNamed: aGraphFile).
	outputOperationName := anOperationName.
	labelsFile := 'examples\labelImage\labels.txt'.

	imageEncoder :=
		ImageTensorEncoder new
			encodingToFloatTensor;
			scalingImagesTo: 299 @ 299;
			vectorizingImageVertically;
			vectorizingColorsUsing: [:aColor | | inputMean inputStddev |
				inputMean := 0.0.
				inputStddev := 65535.0.
				Array
					with: (aColor red - inputMean) / inputStddev
					with: (aColor green - inputMean) / inputStddev
					with: (aColor blue - inputMean) / inputStddev]
]

{ #category : 'Processing' }
StaticImageTagger >> labelAll: anInputTensor [

	^self labelAll: anInputTensor using: labelsFile
]

{ #category : 'Processing' }
StaticImageTagger >> labelAll: anInputTensor using: aLabelsFile [

	| result results labels |

	result := ((self analizeAll: anInputTensor) at: outputOperationName) asNumbers.

	labels := self parseLabelsIn: aLabelsFile.
	results :=
		result collect: [:eachImage | | labeled |
			labeled := (1 to: eachImage size) collect: [:i | (labels at: i) -> (eachImage at: i)].
			labeled sort: [:a :b | a value > b value]].
	^results
]

{ #category : 'Processing',
  #vaVisibility : 'private' }
StaticImageTagger >> parseLabelsIn: aLabelsFile [

	| labels |

	labels := OrderedCollection new.
	aLabelsFile asPath readStreamDo: [:strm |
		strm contents linesDo: [:aLine |
			labels add: (
				aLine readStream
					upTo: $:;
					upToEnd)]].
	^labels
]
