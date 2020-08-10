Extension {
	#name : 'TFElementWiseDivisionTest'
}

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFElementWiseDivisionTest >> testPartialDerivativeWithRespectToScalarDenominator [
	"f(x,y) = x / y 
	 df/dy = - x / y^2 "

	| x y result |

	x := tf constantWith: 10.0.
	y := tf constantWith: 3.0.
	result := TFElementWiseDivision of: x and: y.

	self assertPartialDerivativeOf: result withRespectTo: y isCloseTo: (0 - 10) / 9
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFElementWiseDivisionTest >> testPartialDerivativeWithRespectToScalarNumerator [
	"f(x,y) = x / y 
	 df/dx = 1 / y 
	 df/dy = -x/y^2"

	| x y result |

	x := tf constantWith: 10.0.
	y := tf constantWith: 3.0.
	result := TFElementWiseDivision of: x and: y.

	self assertPartialDerivativeOf: result withRespectTo: x isCloseTo: 1 / 3.
	self assertPartialDerivativeOf: result withRespectTo: y isCloseTo: -10 / 9
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFElementWiseDivisionTest >> testPartialDerivativeWithRespectToVectorDenominator [

	" f(x,y) = x / y 
	 df/dy = - x / y^2 "

	| x y result |

	x := tf floatConstantWith: #(10 -5).
	y := tf floatConstantWith: #(3 -2.5).
	result := TFElementWiseDivision of: x and: y.

	self
		assertPartialDerivativeOf: result
		withRespectTo: y
		isVectorCloseTo: (Array with: 10 / 9 negated with: 5 / 6.25)
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFElementWiseDivisionTest >> testPartialDerivativeWithRespectToVectorNumerator [

	" f(x,y) = x / y 
	 df/dy = 1 / y "

	| x y result |

	x := tf floatConstantWith: #(10 -5).
	y := tf floatConstantWith: #(3 -2.5).
	result := TFElementWiseDivision of: x and: y.

	self
		assertPartialDerivativeOf: result
		withRespectTo: x
		isVectorCloseTo: (Array with: 1 / 3 with: 0.4 negated)
]