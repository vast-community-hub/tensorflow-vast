Extension {
	#name : 'TFElementWiseMultiplicationTest'
}

{ #category : '*TFOperationGradientFailingModelTests',
 #vaCategories : ['Test'] }
TFElementWiseMultiplicationTest >> testGradientWithRespectToVariable [
	"Somehow using a variable instead of constant, gradient crash de image
	 f(x) = x^2 / x
	 df/dx = 1

	| x z |

	x := tf variableNamed: 'input' with: 3.0 asTensor.

	z := TFElementWiseMultiplication of: x squared and: x reciprocal.

	self assertPartialDerivativeOf: z withRespectTo: x isCloseTo: 1"
]
