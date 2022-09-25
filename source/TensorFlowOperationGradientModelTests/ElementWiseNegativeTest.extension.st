Extension {
	#name : 'ElementWiseNegativeTest'
}

{ #category : '*TensorFlowOperationGradientModelTests',
 #vaCategories : ['Tests'] }
ElementWiseNegativeTest >> testGradientOfNegatedSquare [
	"f(x) = -x^2
	 df/dx = -2x"

	| x y |

	x := tf constantWith: 3.0.

	y := ElementWiseNegative of: x squared.

	self assertPartialDerivativeOf: y withRespectTo: x isCloseTo: -2 * 3
]

{ #category : '*TensorFlowOperationGradientModelTests',
 #vaCategories : ['Tests'] }
ElementWiseNegativeTest >> testGradientWithRespectToFloatInput [
	"f(x) = -x
	 df/dx = -1"

	| x y |

	x := tf constantWith: 3.0.

	y := ElementWiseNegative of: x.

	self assertPartialDerivativeOf: y withRespectTo: x isCloseTo: -1
]
