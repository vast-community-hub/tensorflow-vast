Extension {
	#name : 'TFReduceMeanTest'
}

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFReduceMeanTest >> testMeanOfAllElementsDerived [

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

	mean := TFReduceMean ofValuesIn: a.

	self
		assertPartialDerivativeOf: mean
		withRespectTo: a
		isMatrixCloseTo: (
			OrderedCollection new
				add: (Array with: 1 / 6 with: 1 / 6);
				add: (Array with: 1 / 6 with: 1 / 6);
				add: (Array with: 1 / 6 with: 1 / 6);
				yourself)
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFReduceMeanTest >> testMeanOfSquareAllElementsDerived [

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

	mean := TFReduceMean ofValuesIn: (TFElementWiseSquare of: a).

	self
		assertPartialDerivativeOf: mean
		withRespectTo: a
		isMatrixCloseTo: (
			OrderedCollection new
				add: (Array with: 2 * 1.1 / 6 with: 2 * 1.2 / 6);
				add: (Array with: 2 * 2.1 / 6 with: 2 * 2.2 / 6);
				add: (Array with: 2 * 3.1 / 6 with: 2 * 0.2 / 6);
				yourself)
]
