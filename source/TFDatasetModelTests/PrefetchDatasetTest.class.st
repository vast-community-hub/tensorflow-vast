Class {
	#name : 'PrefetchDatasetTest',
	#superclass : 'DatasetTest',
	#category : 'TFDatasetModelTests'
}

{ #category : 'Tests' }
PrefetchDatasetTest >> testIterateThroughDatasetWithOneFloatMatrix [

	| input_dataset dataset iterator |

	input_dataset := self datasetWithOneFloatMatrix.
	dataset :=
		PrefetchDataset
			prefetchingElementsIn: input_dataset
			withBufferSized: 2
			outputsTyped: (Array with: TFTensor typeFloat)
			shaped: (Array with: (TensorShape matrixSized: 2 by: 4)).

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
PrefetchDatasetTest >> testIterateThroughDatasetWithOneFloatVector [

	| input_dataset dataset iterator |

	input_dataset := self datasetWithOneFloatVector.
	dataset :=
		PrefetchDataset
			prefetchingElementsIn: input_dataset
			withBufferSized: 2
			outputsTyped: (Array with: TFTensor typeFloat)
			shaped: (Array with: (TensorShape vectorSized: 4)).
			
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
