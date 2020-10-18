Class {
	#name : 'RandomDataset',
	#superclass : 'Dataset',
	#instVars : [
		'outputTypes',
		'outputShapes'
	],
	#category : 'TFDatasetModel'
}

{ #category : 'Instance Creation' }
RandomDataset class >> on: aTensorFlowComputation withSeed: aSeed1 and: aSeed2 outputsTyped: aTypeCollection shaped: aShapeCollection [

	^self new
		initializeOn: aTensorFlowComputation
		withSeed: aSeed1
		and: aSeed2
		outputsTyped: aTypeCollection
		shaped: aShapeCollection
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
RandomDataset >> initializeOn: aTensorFlowComputation withSeed: aSeed1 and: aSeed2 outputsTyped: aTypeCollection shaped: aShapeCollection [

	outputTypes := aTypeCollection.
	outputShapes := aShapeCollection.

	value :=
		aTensorFlowComputation
			newOperationOf: 'RandomDataset'
			namePrefixed: 'RandomDataset'
			withAll: (Array with: aSeed1 asInt64Tensor with: aSeed2 asInt64Tensor)
			describedBy: [:description |
				description
					at: TFAttributeName outputTypes putTypes: outputTypes;
					at: TFAttributeName outputShapes putShapes: outputShapes]
]

{ #category : 'Accessing' }
RandomDataset >> outputShapes [

	^Array with: TensorShape scalar
]

{ #category : 'Accessing' }
RandomDataset >> outputTypes [

	^Array with: TFTensor typeInt64
]
