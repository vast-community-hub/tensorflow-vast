Class {
	#name : 'TensorShape',
	#superclass : 'Object',
	#instVars : [
		'dimensionSizes'
	],
	#category : 'TensorFlowCore'
}

{ #category : 'Instance Creation' }
TensorShape class >> matrixSized: aNumberOfRows by: aNumberOfColumns [

	^self withDimensionsSized: (Array with: aNumberOfRows with: aNumberOfColumns)
]

{ #category : 'Instance Creation' }
TensorShape class >> numberOfBatches: anInteger height: aHeight width: aWidth channels: anAmountOfChannels [

	^self withDimensionsSized:
		(Array with: anInteger with: aHeight with: aWidth with: anAmountOfChannels)
]

{ #category : 'Instance Creation' }
TensorShape class >> scalar [

	^self withDimensionsSized: #()
]

{ #category : 'Instance Creation' }
TensorShape class >> unknown [

	^self new initializeDimensionSized: -1
]

{ #category : 'Instance Creation' }
TensorShape class >> unknownBatchSizeWith: aNumberOfFeatures [

	^self matrixSized: -1 by: aNumberOfFeatures
]

{ #category : 'Instance Creation' }
TensorShape class >> vectorSized: anInteger [

	^self withDimensionsSized: (Array with: anInteger)
]

{ #category : 'Instance Creation' }
TensorShape class >> withDimensionsSized: aDimensionsSizeArray [

	(aDimensionsSizeArray isA: Array)
		ifFalse: [AssertionFailure signal: #'Dimensions sizes should be an array'].
	^self new initializeDimensionSized: aDimensionsSizeArray
]

{ #category : 'Comparing' }
TensorShape >> = anObject [

	^((anObject isA: TensorShape) and: [self dimensionSizes = anObject dimensionSizes])
		or: [(anObject isA: SequenceableCollection) and: [self dimensionSizes = anObject asArray]]
]

{ #category : 'Converting' }
TensorShape >> asInt32Tensor [

	^self dimensionSizes asInt32Tensor
]

{ #category : 'Converting' }
TensorShape >> asInt64Tensor [

	^self dimensionSizes asInt64Tensor
]

{ #category : 'Converting' }
TensorShape >> asTensorShape [

	^self
]

{ #category : 'Accessing' }
TensorShape >> description [

	self representsScalar ifTrue: [^'Scalar'].
	self representsVector ifTrue: [^'Vector size <1p>' expandMacrosWith: self dimensionSizes any].
	self representsMatrix
		ifTrue: [
			^'<1p>x<2p> matrix'
				expandMacrosWith: self dimensionSizes first
				with: self dimensionSizes second].
	^'<1p>' expandMacrosWith: self dimensionSizes
]

{ #category : 'Accessing' }
TensorShape >> dimensionSizes [

	^dimensionSizes
]

{ #category : 'Converting' }
TensorShape >> flattened [

	self rank < 2 ifTrue: [^self].
	self representsMatrix
		ifTrue: [^self class vectorSized: dimensionSizes first * dimensionSizes second].
	^self class matrixSized: dimensionSizes first by: dimensionSizes second * dimensionSizes third
]

{ #category : 'Comparing' }
TensorShape >> hash [

	^self dimensionSizes hash
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TensorShape >> initializeDimensionSized: anArray [

	dimensionSizes := anArray
]

{ #category : 'Testing' }
TensorShape >> isCompatibleWithNHWShapes [
	
	"NHW shape is those with (number of images in the batch, height, width) shape "
	
	^self rank = 3
]

{ #category : 'Accessing' }
TensorShape >> numberOfFeatures [
	" When shape represents a matrix, the second dimensions is the total amount of columns, 
	 which is the numbe of features in a dataset"
	^self dimensionSizes second
]

{ #category : 'Printing' }
TensorShape >> printOn: aStream [


	aStream nextPutAll: self description
]

{ #category : 'Accessing' }
TensorShape >> rank [

	^self dimensionSizes size
]

{ #category : 'Testing' }
TensorShape >> representsMatrix [

	^self rank = 2
]

{ #category : 'Testing' }
TensorShape >> representsScalar [

	^self rank = 0
]

{ #category : 'Testing' }
TensorShape >> representsVector [

	^self rank = 1
]

{ #category : 'Accessing' }
TensorShape >> size [

	^dimensionSizes size
]

{ #category : 'Accessing' }
TensorShape >> totalAmountOfElements [

	^self dimensionSizes inject: 1 into: [ :prev :next | prev * next ]
]
