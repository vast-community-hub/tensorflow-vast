Class {
	#name : 'TFSumTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
TFSumTest >> testSum2FloatVectors [

	| sum a b |

	a := tf defineFloatTensorWith: #(1 2 3).
	b := tf defineFloatTensorWith: #(4 5 6).

	sum := TFSum of: a plus: b.

	self assertOutputOf: sum isFloatVectorCloseTo: #(5.0 7.0 9.0)
]

{ #category : 'Test' }
TFSumTest >> testSum2IntegerVectors [

	| sum a b |

	a := tf defineIntegerTensorWith: #(1 2 3).
	b := tf defineIntegerTensorWith: #(4 5 6).

	sum := TFSum of: a plus: b.

	self assertOutputOf: sum isIntegerVectorEqualsTo: #(5 7 9)
]

{ #category : 'Test' }
TFSumTest >> testSumMoreThan2FloatVectors [

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
