Class {
	#name : 'BatchDatasetTest',
	#superclass : 'DatasetTest',
	#category : 'TFDatasetModelTests'
}

{ #category : 'Tests' }
BatchDatasetTest >> testIterateThroughDatasetWithOneFloatMatrixInBatchesOfOne [

	| dataset batch iterator |

	dataset := self datasetWithOneFloatMatrix.
	batch := dataset inBatchesOf: 1.

	self assertDatasetHasExpectedOutput: dataset.

	iterator := batch newIterator.
	self
		assert: iterator next
		isOf: TFTensor typeFloat
		with: (TensorShape withDimensionsSized: #(1 2 4))
		comparedTo: #(0 1 2 3 9 8 7 6)
		complying: [:actual :expected | self assert: actual equals: expected].

	self assertReachedEnd: iterator
]

{ #category : 'Tests' }
BatchDatasetTest >> testIterateThroughDatasetWithOneFloatVectorInBatchesOfOne [

	| dataset batch iterator |

	dataset := self datasetWithOneFloatVector.
	batch := dataset inBatchesOf: 1.

	self assertDatasetHasExpectedOutput: dataset.

	iterator := batch newIterator.

	self assertOutputOf: iterator next isMatrixCloseTo: #((0 1 2 3)).
	self assertReachedEnd: iterator
]

{ #category : 'Tests' }
BatchDatasetTest >> testIterateThroughDatasetWithOneFloatVectorInBatchesOfTwo [

	| dataset batch iterator |

	dataset := self datasetWithOneFloatVector.
	batch := dataset inBatchesOf: 2.

	self assertDatasetHasExpectedOutput: dataset.

	iterator := batch newIterator.
	self assertOutputOf: iterator next isMatrixCloseTo: #((0 1 2 3)).
	self assertReachedEnd: iterator
]
