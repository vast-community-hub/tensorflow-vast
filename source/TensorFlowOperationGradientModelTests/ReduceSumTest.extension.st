Extension {
	#name : 'ReduceSumTest'
}

{ #category : '*TensorFlowOperationGradientModelTests',
 #vaCategories : ['Test'] }
ReduceSumTest >> testSumOfAllElementsDerived [

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

	mean := ReduceSum valuesIn: a.

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

{ #category : '*TensorFlowOperationGradientModelTests',
 #vaCategories : ['Test'] }
ReduceSumTest >> testSumOfDotProductDerived [

	| a b mean |

	a := tf floatConstantWith: #((1.1) (2.1)) named: 'a'.
	b := tf floatConstantWith: #((0.1 1.1)) named: 'b'.
	mean := ReduceSum valuesIn: (MatrixMultiplication of: a and: b).

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

{ #category : '*TensorFlowOperationGradientModelTests',
 #vaCategories : ['Test'] }
ReduceSumTest >> testSumOfDotProductDerived1 [

	| a b mean |

	a := tf floatConstantWith: #((1.1 2.1)) named: 'a'.
	b := tf floatConstantWith: #((0.1) (1.1)) named: 'b'.
	mean := ReduceSum valuesIn: (MatrixMultiplication of: a and: b).

	self
		assertPartialDerivativeOf: mean withRespectTo: a isMatrixCloseTo: #((0.1 1.1));
		assertPartialDerivativeOf: mean withRespectTo: b isMatrixCloseTo: #((1.1) (2.1))
]

{ #category : '*TensorFlowOperationGradientModelTests',
 #vaCategories : ['Test'] }
ReduceSumTest >> testSumOfSquareAllElementsDerived [

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

	mean := ReduceSum valuesIn: (ElementWiseSquare of: a).

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
