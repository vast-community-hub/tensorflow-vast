Class {
	#name : 'TensorSliceDatasetTest',
	#superclass : 'DatasetTest',
	#category : 'TFDatasetModelTests'
}

{ #category : 'Tests' }
TensorSliceDatasetTest >> testIterateThroughDatasetWithOneFloatMatrix [

	| dataset iterator |

	dataset :=
		TensorSliceDataset
			on: tf
			containing: (Array with: (tf floatConstantWith: #((0 1 2 3) (9 8 7 6))))
			withOutputShaped: (Array with: (TensorShape vectorSized: 4)).

	self assertDatasetHasExpectedOutput: dataset.

	iterator :=
		DatasetIterator
			on: tf
			iterating: dataset
			knowingOutputIsTyped: TFTensor typeFloat
			withShape: (TensorShape vectorSized: 4).

	self assertOutputOf: iterator next isFloatVectorCloseTo: #(0 1 2 3).
	self assertOutputOf: iterator next isFloatVectorCloseTo: #(9 8 7 6).
	self assertReachedEnd: iterator
]

{ #category : 'Tests' }
TensorSliceDatasetTest >> testIterateThroughDatasetWithOneFloatVector [

	| dataset iterator |

	dataset :=
		TensorSliceDataset
			on: tf
			containing: (Array with: (tf floatConstantWith: #(0 1 2 3)))
			withOutputShaped: (Array with: TensorShape scalar).
			
	self assertDatasetHasExpectedOutput: dataset.
	
	iterator :=
		DatasetIterator
			on: tf
			iterating: dataset
			knowingOutputIsTyped: TFTensor typeFloat
			withShape: TensorShape scalar.
			
	self assertOutputOf: iterator next isFloatScalarCloseTo: 0.
	self assertOutputOf: iterator next isFloatScalarCloseTo: 1.
	self assertOutputOf: iterator next isFloatScalarCloseTo: 2.
	self assertOutputOf: iterator next isFloatScalarCloseTo: 3.
	self assertReachedEnd: iterator
]

{ #category : 'Tests' }
TensorSliceDatasetTest >> testIterateThroughDatasetWithTwoFloatVectors [

	| dataset iterator next |

	dataset :=
		TensorSliceDataset
			on: tf
			containing: (
				Array
					with: (tf floatConstantWith: #(0 1 2 3))
					with: (tf floatConstantWith: #(9 8 7 6)))
			withOutputShaped: (Array with: TensorShape scalar with: TensorShape scalar).

	self assertDatasetHasExpectedOutput: dataset.

	iterator :=
		DatasetIterator
			on: tf
			iterating: dataset
			knowingOutputsAreTyped: (Array with: TFTensor typeFloat with: TFTensor typeFloat)
			withShape: (Array with: TensorShape scalar with: TensorShape scalar).

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
