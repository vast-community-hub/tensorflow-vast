Class {
	#name : 'TFElementWiseSquareTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
TFElementWiseSquareTest >> testSquare [

	| tensor result |

	tensor := tf defineFloatTensorWith: #(2 3 4).

	result := TFElementWiseSquare of: tensor.

	self assertOutputOf: result isIntegerVectorEqualsTo: #(4.0 9.0 16.0)
]
