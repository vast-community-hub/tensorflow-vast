Extension {
	#name : 'TFSumTest'
}

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFSumTest >> testPartialDerivativeWithRespectToFloatInput [
	"f(x,y) = x + y
	 df/dx = 1"

	| x y sum dx |

	x := tf defineFloatTensorWith: #(1 2 3).
	y := tf defineFloatTensorWith: #(4 5 6).

	sum := TFSum of: x plus: y.
	dx := sum partialDerivativeWithRespectTo: x.

	self assertOutputOf: dx isFloatVectorCloseTo: #(1 1 1)
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFSumTest >> testPartialDerivativeWithRespectToIntegerInput [
	"f(x,y) = x + y
	 df/dx = 1"

	| x y sum dx |

	x := tf defineIntegerTensorWith: #(1 2 3).
	y := tf defineIntegerTensorWith: #(4 5 6).

	sum := TFSum of: x plus: y.
	dx := sum partialDerivativeWithRespectTo: x.

	self assertOutputOf: dx isIntegerVectorEqualsTo: #(1 1 1)
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFSumTest >> testPartialDerivativeWithRespectToOneInput [
	"f(x,y) = x^2 + 3yx
	 df/dx = 2x + 3"

	| x y three sum dx |

	x := tf floatInputNamed: 'x'.
	y := tf floatInputNamed: 'y'.
	three := tf defineFloatTensorWith: 3.

	sum :=
		TFSum
			of: (TFElementWiseSquare of: x)
			plus: (
				TFElementWiseMultiplication of: three and: (TFElementWiseMultiplication of: x and: y)).

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
