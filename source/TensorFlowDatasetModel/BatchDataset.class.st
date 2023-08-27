Class {
	#name : 'BatchDataset',
	#superclass : 'DatasetComputationAware',
	#instVars : [
		'outputDomains',
		'currentComputation'
	],
	#category : 'TensorFlowDatasetModel'
}

{ #category : 'Instance Creation' }
BatchDataset class >> splitting: aDataset in: aBatchSize [

	^self new initializeSplitting: aDataset in: aBatchSize
]

{ #category : 'Accessing' }
BatchDataset >> currentComputation [

	^currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
BatchDataset >> initializeSplitting: aDataset in: aBatchSize [

	currentComputation := aDataset currentComputation.
	outputDomains := aDataset outputDomains collect: #withUnknowBatchDimension.
	value :=
		currentComputation
			newOperationOf: 'BatchDatasetV2'
			namePrefixed: 'BatchDataset'
			withAll:
				(Array with: aDataset with: aBatchSize asInt64Tensor with: false asBooleanTensor)
			describedBy: [:description |
				description
					atOutputTypesPut: (outputDomains collect: #type);
					atOutputShapesPut: (outputDomains collect: #shape)]
]

{ #category : 'Accessing' }
BatchDataset >> outputDomains [

	^outputDomains
]
