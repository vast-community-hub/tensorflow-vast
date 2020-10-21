Class {
	#name : 'BatchDataset',
	#superclass : 'Dataset',
	#instVars : [
		'outputTypes',
		'outputShapes',
		'outputDomains'
	],
	#category : 'TFDatasetModel'
}

{ #category : 'Instance Creation' }
BatchDataset class >> splitting: aDataset in: aBatchSize withOutputIn: aTensorDomain [

	^self splitting: aDataset in: aBatchSize withOutputsIn: (Array with: aTensorDomain)
]

{ #category : 'Instance Creation' }
BatchDataset class >> splitting: aDataset in: aBatchSize withOutputsIn: aTensorDomainCollection [

	^self new initializeSplitting: aDataset in: aBatchSize withOutputsIn: aTensorDomainCollection
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
BatchDataset >> initializeSplitting: aDataset in: aBatchSize withOutputsIn: aTensorDomainCollection [

	outputDomains := aTensorDomainCollection.

	value :=
		aDataset currentComputation
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
