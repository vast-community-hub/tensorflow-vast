Extension {
	#name : 'TFReciprocalTest'
}

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Tests'] }
TFReciprocalTest >> testGradientWithRespectToScalarInput [
	"f(x) = 1/x
	 df/dx = -1/x^2"

	| x y |

	x := tf constantWith: 4.0.

	y := TFReciprocal of: x.

	self assertPartialDerivativeOf: y withRespectTo: x isCloseTo: (-1 / (4 * 4))
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Tests'] }
TFReciprocalTest >> testGradientWithRespectToVectorInput [

	| x y |

	x := tf floatConstantWith: #(5 10 -0.5).

	y := TFReciprocal of: x.

	self
		assertPartialDerivativeOf: y
		withRespectTo: x
		isVectorCloseTo: (Array with: (-1 / 25) with: (-1 / 100) with: -4)
]
