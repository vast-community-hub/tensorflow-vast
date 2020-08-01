Extension {
	#name : 'TFElementWiseSquareTest'
}

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFElementWiseSquareTest >> testGradientWhenComposed [
	"f(x) = tanh(x) ^2
	 df/dx = 2tanh(x) tanh'(x) = 2 tanh(x) (1 - tanh(x)^2)"

	| input square |

	input := tf constantWith: 0.549306.
	square := TFElementWiseSquare of: (TFTanhActivation activating: input).

	self
		assertPartialDerivativeOf: square
		withRespectTo: input
		isCloseTo: (2 * 0.5 * (1 - (0.5 squared)))
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFElementWiseSquareTest >> testPartialDerivativeWhenComposed [
	"f(x) = tanh(x) ^2
	 df/dx = 2tanh(x) tanh'(x) = 2 tanh(x) (1 - tanh(x)^2)"

	| input square |

	input := tf constantWith: 0.549306.
	square := TFElementWiseSquare of: (TFTanhActivation activating: input).

	self
		assertPartialDerivativeOf: square
		withRespectTo: input
		isCloseTo: 2 * 0.5 * (1 - (0.5 squared))
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFElementWiseSquareTest >> testPartialDerivativeWithRespectToAnotherInputWhenComposed [
	" f(x) = tanh(x) ^2
	 df/dx = 2tanh(x) tanh'(x) = 2 tanh(x) (1 - tanh(x)^2)"

	| input square x |

	input := tf constantWith: 0.549306.
	square := TFElementWiseSquare of: (TFTanhActivation activating: input).

	x := tf constantWith: 4.0.

	self assert: square isNotDifferentiableRespectTo: x
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFElementWiseSquareTest >> testPartialDerivativeWithRespectToAnotherScalarInput [
	" f(x) = x^2
	 df/dy = 0"

	| input square x |

	input := tf constantWith: 3.0.
	square := TFElementWiseSquare of: input.

	x := tf constantWith: 4.0.

	self assert: square isNotDifferentiableRespectTo: x
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFElementWiseSquareTest >> testPartialDerivativeWithRespectToScalarInput [
	"f(x) = x^2
	 df/dx = 2x"

	| input square |

	input := tf constantWith: 3.0.
	square := TFElementWiseSquare of: input.

	self assertPartialDerivativeOf: square withRespectTo: input isCloseTo: 6
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFElementWiseSquareTest >> testPartialDerivativeWithRespectToVectorInput [
	" f(x) = x^2
	 df/dx = 2x"

	| input square |

	input := tf floatConstantWith: #(3 5).
	square := TFElementWiseSquare of: input.

	self assertPartialDerivativeOf: square withRespectTo: input isVectorCloseTo: #(6 10)
]
