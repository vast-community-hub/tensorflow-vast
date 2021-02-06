Class {
	#name : 'ShuffledDatasetTest',
	#superclass : 'DatasetTest',
	#category : 'TFDatasetModelTests'
}

{ #category : 'Test' }
ShuffledDatasetTest >> testIterateUsingDo [

	| dataset |

	dataset :=
		TensorDataset
			on: tf
			slicing: (tf floatConstantWith: #((0 1 2 3) (9 8 7 6) (-5 -4 -3 -7))).
	dataset := dataset shuffledWithSeed: -2.

	self assertDatasetHasExpectedOutput: dataset.

	self assert: dataset cardinality equals: 3.
	self
		iterateThrough: dataset
		collecting: [:tensor | tensor allElements]
		thenDo: [:foundElements |
			self
				assert: foundElements
				equals: (
					OrderedCollection new
						add: #(9.0 8.0 7.0 6.0);
						add: #(0.0 1.0 2.0 3.0);
						add: #(-5.0 -4.0 -3.0 -7.0);
						yourself)]
]

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

	self assert: dataset cardinality equals: 3.
	self assertOutputOf: iterator next isFloatVectorCloseTo: #(9 8 7 6).
	self assertOutputOf: iterator next isFloatVectorCloseTo: #(0 1 2 3).
	self assertOutputOf: iterator next isFloatVectorCloseTo: #(-5 -4 -3 -7).
	self assertReachedEnd: iterator
]
