Class {
	#name : 'ShuffledDatasetTest',
	#superclass : 'DatasetTest',
	#category : 'TFDatasetModelTests'
}

{ #category : 'Test' }
ShuffledDatasetTest >> testShuffleTensorDataset [

	| dataset iterator |

	dataset :=
		TensorDataset
			on: tf
			slicing: (tf floatConstantWith: #((0 1 2 3) (9 8 7 6) (-5 -4 -3 -7))).
	dataset := dataset shuffledWithSeed: -2.

	self assertDatasetHasExpectedOutput: dataset.

	iterator := dataset newIterator.

	self assert: (tf compute: dataset cardinality) isLargeIntegerScalarEqualsTo: 3.
	self assertOutputOf: iterator next isFloatVectorCloseTo: #(9 8 7 6).
	self assertOutputOf: iterator next isFloatVectorCloseTo: #(0 1 2 3).
	self assertOutputOf: iterator next isFloatVectorCloseTo: #(-5 -4 -3 -7).
	self assertReachedEnd: iterator
]
