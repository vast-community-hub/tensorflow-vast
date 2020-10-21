Class {
	#name : 'RandomDatasetTest',
	#superclass : 'DatasetTest',
	#category : 'TFDatasetModelTests'
}

{ #category : 'Tests',
  #vaVisibility : 'private' }
RandomDatasetTest >> datasetWithRandomFloatScalars [

	^RandomDataset on: tf withSeed: 0 and: 1 withOutputIn: TensorDomain ofFloatScalar
]

{ #category : 'Tests',
  #vaVisibility : 'private' }
RandomDatasetTest >> datasetWithRandomFloatVectors [

	^RandomDataset on: tf withSeed: 0 and: 1 withOutputIn: (TensorDomain ofFloatVectorSized: 3)
]

{ #category : 'Tests',
  #vaVisibility : 'private' }
RandomDatasetTest >> datasetWithRandomIntegerScalars [

	^RandomDataset on: tf withSeed: 0 and: 1 withOutputIn: TensorDomain ofIntegerScalar
]

{ #category : 'Tests' }
RandomDatasetTest >> testIterateThroughDatasetWithFloatScalars [

	| dataset iterator |

	dataset := self datasetWithRandomFloatScalars.
	self assertDatasetHasExpectedOutput: dataset.
	
	iterator := DatasetIterator on: tf iterating: dataset.
	
	self assert: (tf compute: dataset cardinality) isLargeIntegerScalarEqualsTo: -1.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 2219120097.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 4035800746.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 253345875.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 2214098416.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 3397187230.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 3653729773.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 2120669524.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 1835372352
]

{ #category : 'Tests' }
RandomDatasetTest >> testIterateThroughDatasetWithFloatVectors [

	| dataset iterator |

	dataset := self datasetWithRandomFloatVectors.
	self assertDatasetHasExpectedOutput: dataset.
	
	iterator := DatasetIterator on: tf iterating: dataset.
	
	self assert: (tf compute: dataset cardinality) isLargeIntegerScalarEqualsTo: -1.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 2219120097.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 4035800746.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 253345875.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 2214098416.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 3397187230.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 3653729773.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 2120669524.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 1835372352
]

{ #category : 'Tests' }
RandomDatasetTest >> testIterateThroughDatasetWithIntegerScalars [

	| dataset iterator |

	dataset := self datasetWithRandomIntegerScalars.
	self assertDatasetHasExpectedOutput: dataset.
	
	iterator := DatasetIterator on: tf iterating: dataset.
	
	self assert: (tf compute: dataset cardinality) isLargeIntegerScalarEqualsTo: -1.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 2219120097.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 4035800746.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 253345875.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 2214098416.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 3397187230.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 3653729773.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 2120669524.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 1835372352
]
