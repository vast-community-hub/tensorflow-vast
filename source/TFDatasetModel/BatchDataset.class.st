Class {
	#name : 'BatchDataset',
	#superclass : 'Dataset',
	#instVars : [
		'outputTypes',
		'outputShapes'
	],
	#category : 'TFDatasetModel'
}

{ #category : 'Instance Creation' }
BatchDataset class >> splitting: aDataset in: aBatchSize outputsTyped: aTypeCollection shaped: aShapeCollection [

	^self new
		initializeSplitting: aDataset
		in: aBatchSize
		outputsTyped: aTypeCollection
		shaped: aShapeCollection


]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
BatchDataset >> initializeSplitting: aDataset in: aBatchSize outputsTyped: aTypeCollection shaped: aShapeCollection [

	outputTypes := aTypeCollection.
	outputShapes := aShapeCollection.

	value :=
		aDataset currentComputation
			newOperationOf: 'BatchDataset'
			namePrefixed: 'BatchDataset'
			withAll: (Array with: aDataset with: aBatchSize asInt64Tensor)
			describedBy: [:description |
				description
					at: TFAttributeName outputTypes putTypes: outputTypes;
					at: TFAttributeName outputShapes putShapes: outputShapes]
]

{ #category : 'Accessing' }
BatchDataset >> outputShapes [

	^outputShapes
]

{ #category : 'Accessing' }
BatchDataset >> outputTypes [

	^outputTypes
]
