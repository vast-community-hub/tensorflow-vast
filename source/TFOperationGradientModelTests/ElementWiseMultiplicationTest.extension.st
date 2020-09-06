Extension {
	#name : 'ElementWiseMultiplicationTest'
}

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
ElementWiseMultiplicationTest >> testGradientUsingSameInput [
	"f(x) = x^2 / x
	 df/dx = 1"

	| x z |

	x := tf constantWith: 3.0.

	z := ElementWiseMultiplication of: x squared and: x reciprocal.

	self assertPartialDerivativeOf: z withRespectTo: x isCloseTo: 1
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
ElementWiseMultiplicationTest >> testGradientWithRespectToScalarInput [
	"f(x,y) = x^2 y
	 df/dx = 2xy
	 df/dy = x^2"

	| x y z |

	x := tf constantWith: 3.0.
	y := tf constantWith: 4.0.

	z := ElementWiseMultiplication of: x squared and: y.

	self assertPartialDerivativeOf: z withRespectTo: x isCloseTo: 2 * 3 * 4.
	self assertPartialDerivativeOf: z withRespectTo: y isCloseTo: 3 * 3
]
