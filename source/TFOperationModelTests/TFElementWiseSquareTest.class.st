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

{ #category : 'Test' }
TFElementWiseSquareTest >> testOperationName [

	| tensor |

	tensor := tf constantWith: 3 asTensor.

	self assert: (TFElementWiseSquare of: tensor) isNamedInGraphAs: 'Square'.
	self assert: (TFElementWiseSquare of: tensor) isNamedInGraphAs: 'Square_1'.
	self assert: (TFElementWiseSquare named: 'output' of: tensor) isNamedInGraphAs: 'output'.
	self assert: (TFElementWiseSquare named: 'output' of: tensor) isNamedInGraphAs: 'output_1'
]

{ #category : 'Test' }
TFElementWiseSquareTest >> testPrintString [

	| tensor |

	tensor := tf constantWith: 3 asTensor.

	self assert: (TFElementWiseSquare of: tensor) printString equals: '(Const)^2'
]
