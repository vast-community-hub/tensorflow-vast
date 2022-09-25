Class {
	#name : 'RandomDatasetTest',
	#superclass : 'DatasetTest',
	#category : 'TensorFlowDatasetModelTests'
}

{ #category : 'Tests' }
RandomDatasetTest >> testIterateThroughDatasetWithFloatScalars [

	| dataset iterator |

	dataset := RandomDataset on: tf withSeed: 0 and: 1 withOutputIn: TensorDomain ofFloatScalar.
	self assertDatasetHasExpectedOutput: dataset.

	iterator := dataset newIterator.

	self assert: dataset isCardinalityUndefined.
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

	dataset :=
		RandomDataset on: tf withSeed: 0 and: 1 withOutputIn: (TensorDomain ofFloatVectorSized: 3).
	self assertDatasetHasExpectedOutput: dataset.

	iterator := dataset newIterator.

	self assert: dataset isCardinalityUndefined.
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

	dataset := RandomDataset on: tf withSeed: 0 and: 1 withOutputIn: TensorDomain ofIntegerScalar.
	self assertDatasetHasExpectedOutput: dataset.

	iterator := dataset newIterator.

	self assert: dataset isCardinalityUndefined.
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
RandomDatasetTest >> testIterateUsingDo [

	| dataset |

	dataset := RandomDataset on: tf withSeed: 0 and: 1 withOutputIn: TensorDomain ofFloatScalar.
	self assertDatasetHasExpectedOutput: dataset.

	self assert: dataset isCardinalityUndefined.
	self
		iterateThrough: dataset
		collecting: [:item | item]
		thenDo: [:foundElements | self assert: foundElements isEmpty]
]
