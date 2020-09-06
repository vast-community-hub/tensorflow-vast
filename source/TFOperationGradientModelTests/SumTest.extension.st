Extension {
	#name : 'SumTest'
}

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
SumTest >> testGradientUsingSameInput [
	"f(x,y) = x^2 + 1/x
	 df/dx = 2x - 1/x^2"

	| x z |

	x := tf constantWith: 3.0.

	z := Sum of: x squared plus: x reciprocal.

	self assertPartialDerivativeOf: z withRespectTo: x isCloseTo: 2 * 3 - (1 / 9)
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
SumTest >> testPartialDerivativeWithRespectToFloatInput [
	"f(x,y) = x + y
	 df/dx = 1"

	| x y sum |

	x := tf floatConstantWith: #(1 2 3).
	y := tf floatConstantWith: #(4 5 6).

	sum := Sum of: x plus: y.

	self assertPartialDerivativeOf: sum withRespectTo: x isVectorCloseTo: #(1 1 1)
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
SumTest >> testPartialDerivativeWithRespectToIntegerInput [
	"f(x,y) = x + y
	 df/dx = 1"

	| x y sum dx |

	x := tf integerConstantWith: #(1 2 3).
	y := tf integerConstantWith: #(4 5 6).

	sum := Sum of: x plus: y.
	dx := sum partialDerivativeWithRespectTo: x.

	self assertOutputOf: dx isIntegerVectorEqualsTo: #(1 1 1)
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
SumTest >> testPartialDerivativeWithRespectToOneInput [
	"f(x,y) = x^2 + 3yx
	 df/dx = 2x + 3"

	| x y three sum dx |

	x := tf floatInputNamed: 'x'.
	y := tf floatInputNamed: 'y'.
	three := tf constantWith: 3.0.

	sum := x squared + (three * x * y).

	dx := sum partialDerivativeWithRespectTo: x.

	self
		assert: (
			tf
				compute: dx
				feedingInputsWith: (
					Dictionary new
						at: 'x' put: 0.5 asFloatTensor;
						at: 'y' put: 1 asFloatTensor;
						yourself))
		isFloatScalarCloseTo: (2 * 0.5 + 3)
]
