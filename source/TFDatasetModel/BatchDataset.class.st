Class {
	#name : 'BatchDataset',
	#superclass : 'DatasetComputationAware',
	#instVars : [
		'outputDomains',
		'currentComputation'
	],
	#category : 'TFDatasetModel'
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
	outputDomains := aDataset outputDomains collect: #withNewUnknownDimension.
	value :=
		currentComputation
			newOperationOf: 'BatchDataset'
			namePrefixed: 'BatchDataset'
			withAll: (Array with: aDataset with: aBatchSize asInt64Tensor)
			describedBy: [:description |
				description
					atOutputTypesPut: (outputDomains collect: #type);
					atOutputShapesPut: (outputDomains collect: #shape)]
]

{ #category : 'Accessing' }
BatchDataset >> outputDomains [

	^outputDomains
]
