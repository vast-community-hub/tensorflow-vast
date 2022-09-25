Extension {
	#name : 'ElementWiseSquareTest'
}

{ #category : '*TensorFlowOperationGradientModelTests',
 #vaCategories : ['Test'] }
ElementWiseSquareTest >> testGradientWhenComposed [
	"f(x) = tanh(x) ^2
	 df/dx = 2tanh(x) tanh'(x) = 2 tanh(x) (1 - tanh(x)^2)"

	| input square |

	input := tf constantWith: 0.549306.
	square := ElementWiseSquare of: (Tanh activating: input).

	self
		assertPartialDerivativeOf: square
		withRespectTo: input
		isCloseTo: (2 * 0.5 * (1 - (0.5 squared)))
]

{ #category : '*TensorFlowOperationGradientModelTests',
 #vaCategories : ['Test'] }
ElementWiseSquareTest >> testPartialDerivativeWhenComposed [
	"f(x) = tanh(x) ^2
	 df/dx = 2tanh(x) tanh'(x) = 2 tanh(x) (1 - tanh(x)^2)"

	| input square |

	input := tf constantWith: 0.549306.
	square := ElementWiseSquare of: (Tanh activating: input).

	self
		assertPartialDerivativeOf: square
		withRespectTo: input
		isCloseTo: 2 * 0.5 * (1 - (0.5 squared))
]

{ #category : '*TensorFlowOperationGradientModelTests',
 #vaCategories : ['Test'] }
ElementWiseSquareTest >> testPartialDerivativeWithRespectToAnotherInputWhenComposed [
	" f(x) = tanh(x) ^2
	 df/dx = 2tanh(x) tanh'(x) = 2 tanh(x) (1 - tanh(x)^2)"

	| input square x |

	input := tf constantWith: 0.549306.
	square := ElementWiseSquare of: (Tanh activating: input).

	x := tf constantWith: 4.0.

	self assert: square isNotDifferentiableRespectTo: x
]

{ #category : '*TensorFlowOperationGradientModelTests',
 #vaCategories : ['Test'] }
ElementWiseSquareTest >> testPartialDerivativeWithRespectToAnotherScalarInput [
	" f(x) = x^2
	 df/dy = 0"

	| input square x |

	input := tf constantWith: 3.0.
	square := ElementWiseSquare of: input.

	x := tf constantWith: 4.0.

	self assert: square isNotDifferentiableRespectTo: x
]

{ #category : '*TensorFlowOperationGradientModelTests',
 #vaCategories : ['Test'] }
ElementWiseSquareTest >> testPartialDerivativeWithRespectToScalarInput [
	"f(x) = x^2
	 df/dx = 2x"

	| input square |

	input := tf constantWith: 3.0.
	square := ElementWiseSquare of: input.

	self assertPartialDerivativeOf: square withRespectTo: input isCloseTo: 6
]

{ #category : '*TensorFlowOperationGradientModelTests',
 #vaCategories : ['Test'] }
ElementWiseSquareTest >> testPartialDerivativeWithRespectToVectorInput [
	" f(x) = x^2
	 df/dx = 2x"

	| input square |

	input := tf floatConstantWith: #(3 5).
	square := ElementWiseSquare of: input.

	self assertPartialDerivativeOf: square withRespectTo: input isVectorCloseTo: #(6 10)
]
