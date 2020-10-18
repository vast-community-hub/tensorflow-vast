Class {
	#name : 'PrefetchDataset',
	#superclass : 'Dataset',
	#instVars : [
		'outputTypes',
		'outputShapes'
	],
	#category : 'TFDatasetModel'
}

{ #category : 'Instance Creation' }
PrefetchDataset class >> prefetchingElementsIn: aDataset withBufferSized: aBufferSize outputsTyped: aTypeCollection shaped: aShapeCollection [

	^self new
		initializePrefetchingElementsIn: aDataset
		withBufferSized: aBufferSize
		outputsTyped: aTypeCollection
		shaped: aShapeCollection
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
PrefetchDataset >> initializePrefetchingElementsIn: aDataset withBufferSized: aBufferSize outputsTyped: aTypeCollection shaped: aShapeCollection [

	outputTypes := aTypeCollection.
	outputShapes := aShapeCollection.
	value :=
		aDataset currentComputation
			newOperationOf: 'PrefetchDataset'
			namePrefixed: 'PrefetchDataset'
			withAll: (Array with: aDataset with: aBufferSize asInt64Tensor)
			describedBy: [:description |
				description
					at: TFAttributeName outputTypes putTypes: outputTypes;
					at: TFAttributeName outputShapes putShapes: outputShapes]
]

{ #category : 'Accessing' }
PrefetchDataset >> outputShapes [

	^outputShapes
]

{ #category : 'Accessing' }
PrefetchDataset >> outputTypes [

	^outputTypes
]
