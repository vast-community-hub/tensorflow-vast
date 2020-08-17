Class {
	#name : 'ComposedOperationsMiscellaneousTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
ComposedOperationsMiscellaneousTest >> sumUpTo: anUpperLimit theTerms: aTermBlock [

	^TFSum ofAll: ((0 to: anUpperLimit) collect: [:n | aTermBlock value: n asFloat])
]

{ #category : 'Test' }
ComposedOperationsMiscellaneousTest >> testGeometricSeries [
	" https://en.wikipedia.org/wiki/Geometric_series "
	| a r y |

	a := tf floatInputNamed: 'a'.
	r := tf floatInputNamed: 'r'.

	y := self sumUpTo: 100 theTerms: [:n | a * (r raisedTo: n)].

	self
		assert: (
			y computeWith: (
				Dictionary new
					at: 'a' put: 3 asFloatTensor;
					at: 'r' put: 0.2 asTensor;
					yourself))
		isFloatScalarCloseTo: (3 / (1 - 0.2)).

	self
		assert: (
			y computeWith: (
				Dictionary new
					at: 'a' put: #(3 2) asFloatTensor;
					at: 'r' put: 0.2 asTensor;
					yourself))
		isFloatVectorCloseTo: (Array with: (3 / (1 - 0.2)) with: (2 / (1 - 0.2)))
]

{ #category : 'Test' }
ComposedOperationsMiscellaneousTest >> testLeibnizFormulaForPi [
	" https://en.wikipedia.org/wiki/Leibniz_formula_for_%CF%80 "
	| one x |

	self tolerateErrorsLowerThan: 5.0e-3.
	
	one := tf floatConstantWith: 1.
	x := self sumUpTo: 100 theTerms: [:n | (one negated raisedTo: n) / (n * 2.0 + 1.0)].

	self assertOutputOf: x isFloatScalarCloseTo: Float pi / 4
]

{ #category : 'Test' }
ComposedOperationsMiscellaneousTest >> testPolynomialCase01 [

	| x y |

	x := tf floatInputNamed: 'x'.

	y := x squared - (x * 2.0) - 15.0.

	self
		assert: (
			y computeWith: (
				Dictionary new
					at: 'x' put: 10.0 asTensor;
					yourself))
		isFloatScalarCloseTo: 65.
	self
		assert: (
			y computeWith: (
				Dictionary new
					at: 'x' put: #(-4 -3 -2 -1 0 1 2 3 5 6) asFloatTensor;
					yourself))
		isFloatVectorCloseTo: #(9 0 -7 -12 -15 -16 -15 -12 0 9)
]
