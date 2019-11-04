Class {
	#name : 'FrozenImagePredictor',
	#superclass : 'Object',
	#instVars : [
		'imageSize',
		'inputMean',
		'inputStddev',
		'imageFiles',
		'graphFile',
		'labelsFile',
		'graph',
		'inputValues',
		'top_n'
	],
	#category : 'TensorFlowExamplesApp'
}

{
	#category : 'Not categorized'
}
FrozenImagePredictor class >> new [
	"Answer an instance of the receiver."

	^super new
		initialize;
		yourself
]

{
	#category : 'accessing'
}
FrozenImagePredictor >> addImageFile: aFilename [

	imageFiles add: aFilename
]

{
	#category : 'helpers'
}
FrozenImagePredictor >> colorToArray: aColor [
	^Array 
		with: aColor red
		with: aColor green
		with: aColor blue
]

{
	#category : 'accessing'
}
FrozenImagePredictor >> graphFile [

	^graphFile
]

{
	#category : 'accessing'
}
FrozenImagePredictor >> graphFile: anObject [

	graphFile := anObject
]

{
	#category : 'accessing'
}
FrozenImagePredictor >> imageFiles [

	^imageFiles
]

{
	#category : 'accessing'
}
FrozenImagePredictor >> imageFiles: anObject [

	imageFiles := anObject
]

{
	#category : 'helpers'
}
FrozenImagePredictor >> images [

	^self imageFiles collect: [:each | | scaledImage |
		scaledImage := (CgPixmap imageFromFile: each).
		scaledImage := self imageToArray: scaledImage.
		scaledImage]
]

{
	#category : 'accessing'
}
FrozenImagePredictor >> imageSize [

	^imageSize
]

{
	#category : 'accessing'
}
FrozenImagePredictor >> imageSize: anPoint [


	imageSize := anPoint
]

{
	#category : 'helpers'
}
FrozenImagePredictor >> imageToArray: image [

	self subclassResponsibility
]

{
	#category : 'initialization'
}
FrozenImagePredictor >> initialize [
	"Be careful because imageSize depends on the proto buffer used,
	so you must check its documentation for a correct size"

	imageFiles := OrderedCollection new.
	inputMean := 0.0.
	inputStddev := 65535.0.
	

]

{
	#category : 'accessing'
}
FrozenImagePredictor >> inputMean [

	^inputMean
]

{
	#category : 'accessing'
}
FrozenImagePredictor >> inputMean: anObject [

	inputMean := anObject
]

{
	#category : 'accessing'
}
FrozenImagePredictor >> inputStddev [

	^inputStddev
]

{
	#category : 'accessing'
}
FrozenImagePredictor >> inputStddev: anObject [

	inputStddev := anObject
]

{
	#category : 'accessing'
}
FrozenImagePredictor >> labelsFile [

	^labelsFile
]

{
	#category : 'accessing'
}
FrozenImagePredictor >> labelsFile: anObject [

	labelsFile := anObject
]

{
	#category : 'run'
}
FrozenImagePredictor >> predict [

	self subclassResponsibility
]

{
	#category : 'initialization'
}
FrozenImagePredictor >> prepareImageInput [

	| scaledImages |

	scaledImages := self scaledImages.
	inputValues :=
		TFTensor
			fromFloats: scaledImages
			shape: (Array with: scaledImages size with: imageSize x with: imageSize y with: 3 "RGB")


]

{
	#category : 'initialization'
}
FrozenImagePredictor >> prepareSession [

	graph := TFGraph fromFileNamed: graphFile
]

{
	#category : 'helpers'
}
FrozenImagePredictor >> readLabels [

	self subclassResponsibility
]

{
	#category : 'helpers'
}
FrozenImagePredictor >> scaledImages [

	^self imageFiles collect: [:each | | scaledImage |
		scaledImage := ((CgPixmap imageFromFile: each) scaledTo: imageSize).
		scaledImage := self imageToArray: scaledImage.
		scaledImage]
]
