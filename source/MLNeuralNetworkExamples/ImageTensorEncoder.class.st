Class {
	#name : 'ImageTensorEncoder',
	#superclass : 'Object',
	#instVars : [
		'colorToArrayEncoder',
		'scale',
		'tensorType',
		'vectorizingHorizontally'
	],
	#category : 'MLNeuralNetworkExamples'
}

{ #category : 'Instance Creation' }
ImageTensorEncoder class >> new [

	^super new initialize
]

{ #category : 'Processing',
  #vaVisibility : 'private' }
ImageTensorEncoder >> addEncodedColorAt: aPoint in: anImage to: aCollection [

	aCollection add: (colorToArrayEncoder value: (anImage getColor: aPoint x y: aPoint y))
]

{ #category : 'Processing',
  #vaVisibility : 'private' }
ImageTensorEncoder >> convertToTensor: anImageFilePathCollection scalingTo: anImageSize [

	| images |

	images := self scaleAll: anImageFilePathCollection to: anImageSize.
	
	^TFTensor
		newTyped: tensorType
		shaped: (Array with: images size with: anImageSize x with: anImageSize y with: 3)
		containing: images
]

{ #category : 'Processing' }
ImageTensorEncoder >> encodeAll: anImageFilePathCollection [

	scale ifNil: [| image |
		image := CgPixmap imageFromFile: anImageFilePathCollection first.
		scale := image width @ image height].

	^self convertToTensor: anImageFilePathCollection scalingTo: scale
]

{ #category : 'Configuring' }
ImageTensorEncoder >> encodingToFloatTensor [

	tensorType := FloatDataType new
]

{ #category : 'Configuring' }
ImageTensorEncoder >> encodingToUnsignedSmallIntegerTensor [

	tensorType := UnsignedInt8DataType new
]

{ #category : 'Accessing' }
ImageTensorEncoder >> imageSize [

	^scale
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
ImageTensorEncoder >> initialize [

	self
		encodingToFloatTensor;
		vectorizingColorsUsing: [:color |
			Array with: color red with: color green with: color blue];
		vectorizingImageHorizontally
]

{ #category : 'Processing',
  #vaVisibility : 'private' }
ImageTensorEncoder >> scaleAll: anImageFilePathCollection to: anImageSize [

	^anImageFilePathCollection collect: [:each | | scaledImage |
		scaledImage := (CgPixmap imageFromFile: each) scaledTo: anImageSize.
		scaledImage := self vectorize: scaledImage assumingSize: anImageSize.
		scaledImage]
]

{ #category : 'Configuring' }
ImageTensorEncoder >> scalingImagesTo: anImageSize [

	scale := anImageSize
]

{ #category : 'Processing',
  #vaVisibility : 'private' }
ImageTensorEncoder >> vectorize: image assumingSize: anImageSize [

	| answer |

	answer := OrderedCollection new: anImageSize y * anImageSize x.
	vectorizingHorizontally
		ifTrue: [
			0 to: anImageSize x - 1 do: [:x |
				0 to: anImageSize y - 1 do: [:y |
					self addEncodedColorAt: (x @ y) in: image to: answer]]]
		ifFalse: [
			0 to: anImageSize y - 1 do: [:y |
				0 to: anImageSize x - 1 do: [:x |
					self addEncodedColorAt: (x @ y) in: image to: answer]]].
	^answer
]

{ #category : 'Configuring' }
ImageTensorEncoder >> vectorizingColorsUsing: anEncoder [


	colorToArrayEncoder := anEncoder 
]

{ #category : 'Configuring' }
ImageTensorEncoder >> vectorizingImageHorizontally [

	vectorizingHorizontally := true
]

{ #category : 'Configuring' }
ImageTensorEncoder >> vectorizingImageVertically [

	vectorizingHorizontally := false
]
