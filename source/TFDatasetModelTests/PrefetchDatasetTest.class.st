Class {
	#name : 'PrefetchDatasetTest',
	#superclass : 'DatasetTest',
	#category : 'TFDatasetModelTests'
}

{ #category : 'Tests' }
PrefetchDatasetTest >> testCardinality [

	| input_dataset dataset |

	input_dataset := self datasetWithOneFloatVector.
	dataset := input_dataset prefetchingInBufferSized: 2.

	self
		deny: dataset isCardinalityUndefined;
		assert: dataset cardinality equals: 1
]

{ #category : 'Tests' }
PrefetchDatasetTest >> testIterateThroughDatasetWithOneFloatMatrix [

	| input_dataset dataset iterator |

	input_dataset := self datasetWithOneFloatMatrix.
	dataset := input_dataset prefetchingInBufferSized: 2.

	self assertDatasetHasExpectedOutput: dataset.

	iterator := dataset newIterator.
	self assertOutputOf: iterator next isMatrixCloseTo: #((0 1 2 3) (9 8 7 6)).
	self assertReachedEnd: iterator
]

{ #category : 'Tests' }
PrefetchDatasetTest >> testIterateThroughDatasetWithOneFloatVector [

	| input_dataset dataset iterator |

	input_dataset := self datasetWithOneFloatVector.
	dataset := input_dataset prefetchingInBufferSized: 2.

	self assertDatasetHasExpectedOutput: dataset.

	iterator := dataset newIterator.
	self assertOutputOf: iterator next isFloatVectorCloseTo: #(0 1 2 3).
	self assertReachedEnd: iterator
]

{ #category : 'Tests' }
PrefetchDatasetTest >> testIterateUsingDo [

	| input_dataset dataset |

	input_dataset := self datasetWithOneFloatMatrix.
	dataset := input_dataset prefetchingInBufferSized: 2.

	self assertDatasetHasExpectedOutput: dataset.

	self assert: dataset cardinality equals: 1.
	self
		iterateThrough: dataset
		collecting: [:tensor | tensor allElements]
		thenDo: [:foundElements |
			self
				assert: foundElements
				equals: (
					OrderedCollection new
						add: #(0.0 1.0 2.0 3.0 9.0 8.0 7.0 6.0);
						yourself)]
]
