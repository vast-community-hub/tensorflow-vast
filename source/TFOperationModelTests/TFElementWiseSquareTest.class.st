Class {
	#name : 'TFElementWiseSquareTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
TFElementWiseSquareTest >> testFloatMatrixSquare [

	| tensor result |

	tensor := tf floatConstantWith: #((2 3 4) (0.5 -8 -5)).

	result := TFElementWiseSquare of: tensor.

	self assertOutputOf: result isMatrixCloseTo: #((4 9 16) (0.25 64 25))
]

{ #category : 'Test' }
TFElementWiseSquareTest >> testFloatVectorSquare [

	| tensor result |

	tensor := tf floatConstantWith: #(2 3 4).

	result := TFElementWiseSquare of: tensor.

	self assertOutputOf: result isFloatVectorCloseTo: #(4.0 9.0 16.0)
]
