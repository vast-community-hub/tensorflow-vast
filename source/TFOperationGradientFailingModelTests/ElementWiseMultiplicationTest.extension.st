Extension {
	#name : 'ElementWiseMultiplicationTest'
}

{ #category : '*TFOperationGradientFailingModelTests',
 #vaCategories : ['Test'] }
ElementWiseMultiplicationTest >> testGradientWithRespectToVariable [
	"  f(x) = x^2 / x
	 df/dx = 1"

	| x z |

	self skip. "Somehow using a variable instead of constant, computing the gradient crashes the image"
	x := tf variableNamed: 'input' with: 3.0 asTensor.

	z := ElementWiseMultiplication of: x squared and: x reciprocal.

	self assertPartialDerivativeOf: z withRespectTo: x isCloseTo: 1
]