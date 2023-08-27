Class {
	#name : 'PrefetchDataset',
	#superclass : 'DatasetComputationAware',
	#instVars : [
		'currentComputation',
		'outputDomains'
	],
	#category : 'TensorFlowDatasetModel'
}

{ #category : 'Instance Creation' }
PrefetchDataset class >> prefetchingElementsIn: aDataset onBufferSized: aBufferSize withOutputIn: aTensorDomain [

	^self
		prefetchingElementsIn: aDataset
		onBufferSized: aBufferSize
		withOutputsIn: (Array with: aTensorDomain)
]

{ #category : 'Instance Creation' }
PrefetchDataset class >> prefetchingElementsIn: aDataset onBufferSized: aBufferSize withOutputsIn: aTensorDomainCollection [

	^self new
		initializePrefetchingElementsIn: aDataset
		onBufferSized: aBufferSize
		withOutputsIn: aTensorDomainCollection
]

{ #category : 'Accessing' }
PrefetchDataset >> currentComputation [

	^currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
PrefetchDataset >> initializePrefetchingElementsIn: aDataset onBufferSized: aBufferSize withOutputsIn: aTensorDomainCollection [

	currentComputation := aDataset currentComputation.
	outputDomains := aTensorDomainCollection.
	value :=
		currentComputation
			newOperationOf: 'PrefetchDataset'
			namePrefixed: 'PrefetchDataset'
			withAll: (Array with: aDataset with: aBufferSize asInt64Tensor)
			describedBy: [:description |
				description
					atOutputTypesPut: (outputDomains collect: #type);
					atOutputShapesPut: (outputDomains collect: #shape)]
]

{ #category : 'Accessing' }
PrefetchDataset >> outputDomains [

	^outputDomains
]