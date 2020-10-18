Class {
	#name : 'BatchDatasetTest',
	#superclass : 'DatasetTest',
	#category : 'TFDatasetModelTests'
}

{ #category : 'Tests' }
BatchDatasetTest >> testIterateThroughDatasetWithOneFloatMatrixInBatchesOfOne [

	| iterator batch dataset |

	dataset := self datasetWithOneFloatMatrix.
	batch :=
		BatchDataset
			splitting: dataset
			in: 2
			outputsTyped: (Array with: TFTensor typeFloat)
			shaped: (Array with: (TensorShape withDimensionsSized: #(-1 2 4))).

	self assertDatasetHasExpectedOutput: dataset.

	iterator :=
		DatasetIterator
			on: tf
			iterating: batch
			knowingOutputIsTyped: TFTensor typeFloat
			withShape: (TensorShape withDimensionsSized: #(-1 2 4)).

	self
		assert: (tf compute: iterator next)
		isOf: TFTensor typeFloat
		with: (TensorShape withDimensionsSized: #(1 2 4))
		comparedTo: #(0 1 2 3 9 8 7 6)
		complying: [:actual :expected | self assert: actual equals: expected].
	self assertReachedEnd: iterator
]

{ #category : 'Tests' }
BatchDatasetTest >> testIterateThroughDatasetWithOneFloatVectorInBatchesOfOne [

	| iterator batch dataset |

	dataset := self datasetWithOneFloatVector.
	batch :=
		BatchDataset
			splitting: dataset
			in: 1
			outputsTyped: (Array with: TFTensor typeFloat)
			shaped: (Array with: (TensorShape unknownBatchSizeWith: 4)).

	self assertDatasetHasExpectedOutput: dataset.

	iterator :=
		DatasetIterator
			on: tf
			iterating: batch
			knowingOutputIsTyped: TFTensor typeFloat
			withShape: (TensorShape unknownBatchSizeWith: 4).

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
			outputsTyped: (Array with: TFTensor typeFloat)
			shaped: (Array with: (TensorShape unknownBatchSizeWith: 4)).

	self assertDatasetHasExpectedOutput: dataset.

	iterator :=
		DatasetIterator
			on: tf
			iterating: batch
			knowingOutputIsTyped: TFTensor typeFloat
			withShape: (TensorShape unknownBatchSizeWith: 4).

	self assertOutputOf: iterator next isMatrixCloseTo: #((0 1 2 3)).
	self assertReachedEnd: iterator
]
