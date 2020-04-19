Extension {
	#name : 'TFElementWiseSquareTest'
}

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFElementWiseSquareTest >> testPartialDerivativeWhenComposed [
	" f(x) = tanh(x) ^2
	 df/dx = 2tanh(x) tanh'(x) = 2 tanh(x) (1 - tanh(x)^2)"

	| input square dSquare |

	input := tf defineFloatTensorWith: 0.549306.
	square := TFElementWiseSquare of: (TFTanhActivation activating: input).
	dSquare := square partialDerivativeWithRespectTo: input.

	self assertOutputOf: dSquare isFloatScalarCloseTo: 2 * 0.5 * (1 - (0.5 squared))
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFElementWiseSquareTest >> testPartialDerivativeWithRespectToAnotherInputWhenComposed [
	" f(x) = tanh(x) ^2
	 df/dx = 2tanh(x) tanh'(x) = 2 tanh(x) (1 - tanh(x)^2)"

	| input square dSquare x |

	input := tf defineFloatTensorWith: 0.549306.
	square := TFElementWiseSquare of: (TFTanhActivation activating: input).

	x := tf defineFloatTensorWith: 4.
	dSquare := square partialDerivativeWithRespectTo: x.

	self assertOutputOf: dSquare isFloatScalarCloseTo: 0
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFElementWiseSquareTest >> testPartialDerivativeWithRespectToAnotherScalarInput [
	" f(x) = x^2
	 df/dy = 0"

	| input square x dSquare |

	input := tf defineFloatTensorWith: 3.
	square := TFElementWiseSquare of: input.

	x := tf defineFloatTensorWith: 4.
	dSquare := square partialDerivativeWithRespectTo: x.

	self assertOutputOf: dSquare isFloatScalarCloseTo: 0
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFElementWiseSquareTest >> testPartialDerivativeWithRespectToScalarInput [
	" f(x) = x^2
	 df/dx = 2x"

	| input square dSquare |

	input := tf defineFloatTensorWith: 3.
	square := TFElementWiseSquare of: input.
	dSquare := square partialDerivativeWithRespectTo: input.

	self assertOutputOf: dSquare isFloatScalarCloseTo: 6
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFElementWiseSquareTest >> testPartialDerivativeWithRespectToVectorInput [
	" f(x) = x^2
	 df/dx = 2x"

	| input square dSquare |

	input := tf defineFloatTensorWith: #(3 5).
	square := TFElementWiseSquare of: input.
	dSquare := square partialDerivativeWithRespectTo: input.

	self assertOutputOf: dSquare isFloatVectorCloseTo: #(6 10)
]
