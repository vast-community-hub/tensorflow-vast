Extension {
	#name : 'SubstractionTest'
}

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Tests'] }
SubstractionTest >> testGradientWithRespectToScalarInputs [
	"f(x,y) = x-y
	 df/dx = 1
	 df/dy = -1"

	| x y z |

	x := tf constantWith: 4.0.
	y := tf constantWith: 5.0.

	z := Substraction of: x minus: y.

	self assertPartialDerivativeOf: z withRespectTo: x isCloseTo: 1.
	self assertPartialDerivativeOf: z withRespectTo: y isCloseTo: -1
]
