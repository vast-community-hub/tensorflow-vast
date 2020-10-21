Class {
	#name : 'BatchDatasetTest',
	#superclass : 'DatasetTest',
	#category : 'TFDatasetModelTests'
}

{ #category : 'Tests' }
BatchDatasetTest >> testIterateThroughDatasetWithOneFloatMatrixInBatchesOfOne [

	| dataset batch iterator |

	dataset := self datasetWithOneFloatMatrix.
	batch :=
		BatchDataset
			splitting: dataset
			in: 1
			withOutputIn: (
				TensorDomain
					of: TFTensor typeFloat
					withShape: (TensorShape withDimensionsSized: #(-1 2 4))).

	self assertDatasetHasExpectedOutput: dataset.

	iterator := DatasetIterator on: tf iterating: batch.
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
	batch :=
		BatchDataset
			splitting: dataset
			in: 1
			withOutputIn: (
				TensorDomain of: TFTensor typeFloat withShape: (TensorShape unknownBatchSizeWith: 4)).

	self assertDatasetHasExpectedOutput: dataset.

	iterator := DatasetIterator on: tf iterating: batch.

	self assertOutputOf: iterator next isMatrixCloseTo: #((0 1 2 3)).
	self assertReachedEnd: iterator
]

{ #category : 'Tests' }
BatchDatasetTest >> testIterateThroughDatasetWithOneFloatVectorInBatchesOfTwo [

	| dataset batch iterator |

	dataset := self datasetWithOneFloatVector.
	batch :=
		BatchDataset
			splitting: dataset
			in: 2
			withOutputIn: (
				TensorDomain of: TFTensor typeFloat withShape: (TensorShape unknownBatchSizeWith: 4)).

	self assertDatasetHasExpectedOutput: dataset.

	iterator := DatasetIterator on: tf iterating: batch.
	self assertOutputOf: iterator next isMatrixCloseTo: #((0 1 2 3)).
	self assertReachedEnd: iterator
]
