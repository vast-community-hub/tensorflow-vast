Class {
	#name : 'SumTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TensorFlowOperationMathModelTests'
}

{ #category : 'Test' }
SumTest >> testOperationName [

	| a b |

	a := tf floatConstantWith: #(1 2 3).
	b := tf floatConstantWith: #(4 5 6).

	self
		assert: (Sum of: a plus: b) isNamedInGraphAs: 'Add';
		assert: (Sum of: a plus: b) isNamedInGraphAs: 'Add_1';
		assert: (Sum named: 'output' of: a plus: b) isNamedInGraphAs: 'output';
		assert: (Sum named: 'output' of: a plus: b) isNamedInGraphAs: 'output_1'.

	self
		assert: (Sum ofAll: (Array with: a with: b with: a)) isNamedInGraphAs: 'AddN';
		assert: (Sum ofAll: (Array with: a with: b with: a)) isNamedInGraphAs: 'AddN_1';
		assert: (Sum named: 'result' ofAll: (Array with: a with: b with: a))
			isNamedInGraphAs: 'result';
		assert: (Sum named: 'result' ofAll: (Array with: a with: b with: a))
			isNamedInGraphAs: 'result_1'
]

{ #category : 'Test' }
SumTest >> testPrintString [

	| a b |

	a := tf floatConstantWith: #(1 2 3) named: 'a'.
	b := tf floatConstantWith: #(4 5 6) named: 'b'.

	self assert: (Sum ofAll: (Array with: a with: b with: a)) printString equals: 'a + b + a'
]

{ #category : 'Test' }
SumTest >> testSum2FloatVectors [

	| a b |

	a := tf floatConstantWith: #(1 2 3).
	b := tf floatConstantWith: #(4 5 6).
	
	self assertOutputOf: a + b isFloatVectorCloseTo: #(5.0 7.0 9.0)
]

{ #category : 'Test' }
SumTest >> testSum2IntegerVectors [

	| a b |

	a := tf integerConstantWith: #(1 2 3).
	b := tf integerConstantWith: #(4 5 6).

	self assertOutputOf: a + b isIntegerVectorEqualsTo: #(5 7 9)
]

{ #category : 'Test' }
SumTest >> testSumMoreThan2FloatVectors [

	| sum tensors |

	tensors :=
		OrderedCollection new
			add: #(1 2 3 4);
			add: #(1 2 3 4);
			add: #(1 2 3 4);
			collect: [:tensor | tf floatConstantWith: tensor].

	sum := Sum ofAll: tensors.

	self assertOutputOf: sum isFloatVectorCloseTo: #(3.0 6.0 9.0 12.0)
]
