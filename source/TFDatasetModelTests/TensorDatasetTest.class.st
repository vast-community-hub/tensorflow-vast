Class {
	#name : 'TensorDatasetTest',
	#superclass : 'DatasetTest',
	#category : 'TFDatasetModelTests'
}

{ #category : 'Tests' }
TensorDatasetTest >> testIterateThenReset [

	| dataset iterator next |

	dataset :=
		TensorDataset
			on: tf
			slicingAll: (
				Array
					with: (tf floatConstantWith: #(0 1 2 3))
					with: (tf floatConstantWith: #(9 8 7 6))).

	self assertDatasetHasExpectedOutput: dataset.

	self assert: (tf compute: dataset cardinality) isLargeIntegerScalarEqualsTo: 4.
	iterator := dataset newIterator.
	next := iterator next.
	self assert: (next at: 1) isFloatScalarCloseTo: 0.
	self assert: (next at: 2) isFloatScalarCloseTo: 9.
	next := iterator next.
	self assert: (next at: 1) isFloatScalarCloseTo: 1.
	self assert: (next at: 2) isFloatScalarCloseTo: 8.

	iterator reset.
	next := iterator next.
	self assert: (next at: 1) isFloatScalarCloseTo: 0.
	self assert: (next at: 2) isFloatScalarCloseTo: 9.
	next := iterator next.
	self assert: (next at: 1) isFloatScalarCloseTo: 1.
	self assert: (next at: 2) isFloatScalarCloseTo: 8.
	next := iterator next.
	self assert: (next at: 1) isFloatScalarCloseTo: 2.
	self assert: (next at: 2) isFloatScalarCloseTo: 7.
	next := iterator next.
	self assert: (next at: 1) isFloatScalarCloseTo: 3.
	self assert: (next at: 2) isFloatScalarCloseTo: 6.
	self assertReachedEnd: iterator
]

{ #category : 'Tests' }
TensorDatasetTest >> testIterateThroughDatasetWithOneFloatMatrix [

	| dataset iterator |

	dataset := self datasetWithOneFloatMatrix.
	self assertDatasetHasExpectedOutput: dataset.

	iterator := dataset newIterator.

	self assert: (tf compute: dataset cardinality) isLargeIntegerScalarEqualsTo: 1.
	self assertOutputOf: iterator next isMatrixCloseTo: #((0 1 2 3) (9 8 7 6)).
	self assertReachedEnd: iterator
]

{ #category : 'Tests' }
TensorDatasetTest >> testIterateThroughDatasetWithOneFloatVector [

	| dataset iterator |

	dataset := self datasetWithOneFloatVector.
	self assertDatasetHasExpectedOutput: dataset.

	iterator := dataset newIterator.

	self assert: (tf compute: dataset cardinality) isLargeIntegerScalarEqualsTo: 1.
	self assertOutputOf: iterator next isFloatVectorCloseTo: #(0 1 2 3).
	self assertReachedEnd: iterator
]

{ #category : 'Tests' }
TensorDatasetTest >> testIterateThroughSlicedDatasetWithOneFloatMatrix [

	| dataset iterator |

	dataset := TensorDataset on: tf slicing: (tf floatConstantWith: #((0 1 2 3) (9 8 7 6))).

	self assertDatasetHasExpectedOutput: dataset.

	iterator := dataset newIterator.

	self assert: (tf compute: dataset cardinality) isLargeIntegerScalarEqualsTo: 2.
	self assertOutputOf: iterator next isFloatVectorCloseTo: #(0 1 2 3).
	self assertOutputOf: iterator next isFloatVectorCloseTo: #(9 8 7 6).
	self assertReachedEnd: iterator
]

{ #category : 'Tests' }
TensorDatasetTest >> testIterateThroughSlicedDatasetWithOneFloatVector [

	| dataset iterator |

	dataset := TensorDataset on: tf slicing: (tf floatConstantWith: #(0 1 2 3)).

	self assertDatasetHasExpectedOutput: dataset.

	iterator := dataset newIterator.

	self assert: (tf compute: dataset cardinality) isLargeIntegerScalarEqualsTo: 4.
	self assertOutputOf: iterator next isFloatScalarCloseTo: 0.
	self assertOutputOf: iterator next isFloatScalarCloseTo: 1.
	self assertOutputOf: iterator next isFloatScalarCloseTo: 2.
	self assertOutputOf: iterator next isFloatScalarCloseTo: 3.
	self assertReachedEnd: iterator
]

{ #category : 'Tests' }
TensorDatasetTest >> testIterateThroughSlicedDatasetWithTwoFloatVectors [

	| dataset iterator next |

	dataset :=
		TensorDataset
			on: tf
			slicingAll: (
				Array
					with: (tf floatConstantWith: #(0 1 2 3))
					with: (tf floatConstantWith: #(9 8 7 6))).

	self assertDatasetHasExpectedOutput: dataset.

	self assert: (tf compute: dataset cardinality) isLargeIntegerScalarEqualsTo: 4.
	iterator := dataset newIterator.
	next := iterator next.
	self assert: (next at: 1) isFloatScalarCloseTo: 0.
	self assert: (next at: 2) isFloatScalarCloseTo: 9.
	next := iterator next.
	self assert: (next at: 1) isFloatScalarCloseTo: 1.
	self assert: (next at: 2) isFloatScalarCloseTo: 8.
	next := iterator next.
	self assert: (next at: 1) isFloatScalarCloseTo: 2.
	self assert: (next at: 2) isFloatScalarCloseTo: 7.
	next := iterator next.
	self assert: (next at: 1) isFloatScalarCloseTo: 3.
	self assert: (next at: 2) isFloatScalarCloseTo: 6.
	self assertReachedEnd: iterator
]