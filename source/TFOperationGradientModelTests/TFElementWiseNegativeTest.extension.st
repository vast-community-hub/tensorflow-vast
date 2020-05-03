Extension {
	#name : 'TFElementWiseNegativeTest'
}

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Tests'] }
TFElementWiseNegativeTest >> testGradientOfNegatedSquare [
	"f(x) = -x^2
	 df/dx = -2x"

	| x y |

	x := tf constantWith: 3.0.

	y := TFElementWiseNegative negativeOf: (TFElementWiseSquare of: x).

	self assertPartialDerivativeOf: y withRespectTo: x isCloseTo: -2 * 3
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Tests'] }
TFElementWiseNegativeTest >> testGradientWithRespectToFloatInput [
	"f(x) = -x
	 df/dx = -1"

	| x y |

	x := tf constantWith: 3.0.

	y := TFElementWiseNegative negativeOf: x.

	self assertPartialDerivativeOf: y withRespectTo: x isCloseTo: -1
]
