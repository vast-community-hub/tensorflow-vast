Class {
	#name : 'TFSumTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
TFSumTest >> testSumMoreThan2Terms [

	| sum tensors |

	tensors :=
		OrderedCollection new
			add: #(1 2 3 4);
			add: #(1 2 3 4);
			add: #(1 2 3 4);
			collect: [:tensor | tf defineFloatTensorWith: tensor].

	sum := TFSum ofAll: tensors.

	self assertOutputOf: sum isFloatVectorCloseTo: #(3.0 6.0 9.0 12.0)
]
