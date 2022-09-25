Class {
	#name : 'ShuffledDataset',
	#superclass : 'DatasetComputationAware',
	#instVars : [
		'currentComputation',
		'outputDomains'
	],
	#category : 'TensorFlowDatasetModel'
}

{ #category : 'Instance Creation' }
ShuffledDataset class >> shuffling: aTensorDataset buffering: aBufferSize [
	" Using zero as seed, makes it tf to use random seed"

	^self shuffling: aTensorDataset buffering: aBufferSize withSeed: 0 asInt64Tensor
]

{ #category : 'Instance Creation' }
ShuffledDataset class >> shuffling: aTensorDataset buffering: aBufferSize withSeed: anIntegerSeed [

	^self new initializeShuffling: aTensorDataset buffering: aBufferSize withSeed: anIntegerSeed
]

{ #category : 'Accessing' }
ShuffledDataset >> currentComputation [

	^currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
ShuffledDataset >> initializeShuffling: aDataset buffering: aBufferSize withSeed: aSeedInteger [

	currentComputation := aDataset currentComputation.
	outputDomains := aDataset outputDomains.
	value :=
		self currentComputation
			newOperationOf: 'ShuffleDataset'
			namePrefixed: 'ShuffleDataset'
			withAll:
				(Array with: aDataset with: aBufferSize with: aSeedInteger with: 0 asInt64Tensor)
			describedBy: [:description |
				description
					atOutputTypesPut: (outputDomains collect: #type);
					atOutputShapesPut: (outputDomains collect: #shape)]
]

{ #category : 'Accessing' }
ShuffledDataset >> outputDomains [

	^outputDomains
]
