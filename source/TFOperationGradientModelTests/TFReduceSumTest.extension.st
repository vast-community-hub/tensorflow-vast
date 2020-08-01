Extension {
	#name : 'TFReduceSumTest'
}

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFReduceSumTest >> testSumOfAllElementsDerived [

	| a mean |

	a :=
		tf
			floatConstantWith: (
				OrderedCollection new
					add: #(1.1 1.2);
					add: #(2.1 2.2);
					add: #(3.1 0.2);
					yourself)
			named: 'tensor'.

	mean := TFReduceSum valuesIn: a.

	self
		assertPartialDerivativeOf: mean
		withRespectTo: a
		isMatrixCloseTo: (
			OrderedCollection new
				add: (Array with: 1 with: 1);
				add: (Array with: 1 with: 1);
				add: (Array with: 1 with: 1);
				yourself)
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFReduceSumTest >> testSumOfDotProductDerived [

	| a b mean |

	a := tf floatConstantWith: #((1.1) (2.1)) named: 'a'.
	b := tf floatConstantWith: #((0.1 1.1)) named: 'b'.
	mean := TFReduceSum valuesIn: (TFMatrixMultiplication of: a and: b).

	self
		assertPartialDerivativeOf: mean
		withRespectTo: a
		isMatrixCloseTo: (
			OrderedCollection new
				add: (Array with: 0.1 + 1.1);
				add: (Array with: 0.1 + 1.1);
				yourself).

	self
		assertPartialDerivativeOf: mean
		withRespectTo: b
		isMatrixCloseTo: (
			OrderedCollection new
				add: (Array with: 1.1 + 2.1 with: 1.1 + 2.1);
				yourself)
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFReduceSumTest >> testSumOfDotProductDerived1 [

	| a b mean |

	a := tf floatConstantWith: #((1.1 2.1)) named: 'a'.
	b := tf floatConstantWith: #((0.1) (1.1)) named: 'b'.
	mean := TFReduceSum valuesIn: (TFMatrixMultiplication of: a and: b).

	self
		assertPartialDerivativeOf: mean withRespectTo: a isMatrixCloseTo: #((0.1 1.1));
		assertPartialDerivativeOf: mean withRespectTo: b isMatrixCloseTo: #((1.1) (2.1))
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFReduceSumTest >> testSumOfSquareAllElementsDerived [

	| a mean |

	a :=
		tf
			floatConstantWith: (
				OrderedCollection new
					add: #(1.1 1.2);
					add: #(2.1 2.2);
					add: #(3.1 0.2);
					yourself)
			named: 'tensor'.

	mean := TFReduceSum valuesIn: (TFElementWiseSquare of: a).

	self
		assertPartialDerivativeOf: mean
		withRespectTo: a
		isMatrixCloseTo: (
			OrderedCollection new
				add: (Array with: 2 * 1.1 with: 2 * 1.2);
				add: (Array with: 2 * 2.1 with: 2 * 2.2);
				add: (Array with: 2 * 3.1 with: 2 * 0.2);
				yourself)
]
