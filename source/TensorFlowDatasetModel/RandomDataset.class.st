Class {
	#name : 'RandomDataset',
	#superclass : 'DatasetComputationAware',
	#instVars : [
		'currentComputation',
		'outputDomains'
	],
	#category : 'TensorFlowDatasetModel'
}

{ #category : 'Instance Creation' }
RandomDataset class >> on: aTensorFlowComputation withSeed: aSeed1 and: aSeed2 withOutputIn: aTensorDomain [

	^self
		on: aTensorFlowComputation
		withSeed: aSeed1
		and: aSeed2
		withOutputsIn: (Array with: aTensorDomain)
]

{ #category : 'Instance Creation' }
RandomDataset class >> on: aTensorFlowComputation withSeed: aSeed1 and: aSeed2 withOutputsIn: aTensorDomainCollection [

	^self new
		initializeOn: aTensorFlowComputation
		withSeed: aSeed1
		and: aSeed2
		withOutputsIn: aTensorDomainCollection
]

{ #category : 'Accessing' }
RandomDataset >> currentComputation [

	^currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
RandomDataset >> initializeOn: aTensorFlowComputation withSeed: aSeed1 and: aSeed2 withOutputsIn: aTensorDomainCollection [

	currentComputation := aTensorFlowComputation.
	value :=
		currentComputation
			newOperationOf: 'RandomDataset'
			namePrefixed: 'RandomDataset'
			withAll: (Array with: aSeed1 asInt64Tensor with: aSeed2 asInt64Tensor)
			describedBy: [:description |
				description
					atOutputTypesPut: (aTensorDomainCollection collect: #type);
					atOutputShapesPut: (aTensorDomainCollection collect: #shape)].
	outputDomains := aTensorDomainCollection collect: [:domain | TensorDomain ofLargeIntegerScalar]
]

{ #category : 'Accessing' }
RandomDataset >> outputDomains [

	^outputDomains 
]
