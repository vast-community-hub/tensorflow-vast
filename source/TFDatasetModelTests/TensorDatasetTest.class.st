Class {
	#name : 'TensorDatasetTest',
	#superclass : 'DatasetTest',
	#category : 'TFDatasetModelTests'
}

{ #category : 'Tests' }
TensorDatasetTest >> testIterateThroughDatasetWithOneFloatMatrix [

	| dataset iterator |

	dataset := self datasetWithOneFloatMatrix.

	self assertDatasetHasExpectedOutput: dataset.

	iterator :=
		DatasetIterator
			on: tf
			iterating: dataset
			knowingOutputIsTyped: TFTensor typeFloat
			withShape: (TensorShape matrixSized: 2 by: 4).

	self assertOutputOf: iterator next isMatrixCloseTo: #((0 1 2 3) (9 8 7 6)).
	self assertReachedEnd: iterator
]

{ #category : 'Tests' }
TensorDatasetTest >> testIterateThroughDatasetWithOneFloatVector [

	| dataset iterator |

	dataset := self datasetWithOneFloatVector.

	self assertDatasetHasExpectedOutput: dataset.

	iterator :=
		DatasetIterator
			on: tf
			iterating: dataset
			knowingOutputIsTyped: TFTensor typeFloat
			withShape: (TensorShape vectorSized: 4).

	self assertOutputOf: iterator next isFloatVectorCloseTo: #(0 1 2 3).
	self assertReachedEnd: iterator
]
