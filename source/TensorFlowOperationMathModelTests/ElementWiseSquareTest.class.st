Class {
	#name : 'ElementWiseSquareTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TensorFlowOperationMathModelTests'
}

{ #category : 'Test' }
ElementWiseSquareTest >> testFloatMatrixSquare [

	| tensor |

	tensor := tf floatConstantWith: #((2 3 4) (0.5 -8 -5)).

	self assertOutputOf: tensor squared isMatrixCloseTo: #((4 9 16) (0.25 64 25))
]

{ #category : 'Test' }
ElementWiseSquareTest >> testFloatVectorSquare [

	| tensor |

	tensor := tf floatConstantWith: #(2 3 4).

	self assertOutputOf: tensor squared isFloatVectorCloseTo: #(4.0 9.0 16.0)
]

{ #category : 'Test' }
ElementWiseSquareTest >> testOperationName [

	| tensor |

	tensor := tf constantWith: 3 asTensor.

	self assert: (ElementWiseSquare of: tensor) isNamedInGraphAs: 'Square'.
	self assert: (ElementWiseSquare of: tensor) isNamedInGraphAs: 'Square_1'.
	self assert: (ElementWiseSquare named: 'output' of: tensor) isNamedInGraphAs: 'output'.
	self assert: (ElementWiseSquare named: 'output' of: tensor) isNamedInGraphAs: 'output_1'
]

{ #category : 'Test' }
ElementWiseSquareTest >> testPrintString [

	| tensor |

	tensor := tf constantWith: 3 asTensor.

	self assert: (ElementWiseSquare of: tensor) printString equals: '(Const)^2'
]
