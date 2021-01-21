Class {
	#name : 'ShadesOfGrayRenderer',
	#superclass : 'Object',
	#category : 'DatasetProviderModel'
}

{ #category : 'Rendering',
  #vaVisibility : 'private' }
ShadesOfGrayRenderer >> createImageWithHeight: aHeight width: aWidth [

	^CgDeviceIndependentImage
		width: aHeight
		height: aWidth
		depth: 8
		palette: (CgIndexedPalette grayRamp: 255)
]

{ #category : 'Rendering' }
ShadesOfGrayRenderer >> renderImageIn: aTFTensor at: anImageIndex scaledBy: aScale [

	aTFTensor shape isCompatibleWithNHWShapes
		ifFalse: [AssertionFailure signal: 'Expected a tensor with shape NHW'].

	self
		renderImageIn: aTFTensor allElements
		at: anImageIndex
		withHeight: aTFTensor shape dimensionSizes second
		width: aTFTensor shape dimensionSizes third
		scaledBy: aScale
]

{ #category : 'Rendering' }
ShadesOfGrayRenderer >> renderImageIn: aFlattenArray at: anImageIndex withHeight: aHeight width: aWidth scaledBy: aScale [

	| image |

	image := self createImageWithHeight: aHeight width: aWidth.

	1 to: aWidth do: [:col |
		1 to: aHeight do: [:row | | pixelValue |
			pixelValue :=
				aFlattenArray at: aWidth * aHeight * (anImageIndex - 1) + ((col - 1) * aWidth + row).
			image putColor: row - 1 y: col - 1 color: (Color gray: 1 - (pixelValue / 255))]].

	(CgImageViewer new)
		viewImage: (image scaledTo: aHeight @ aWidth * aScale);
		open
]
