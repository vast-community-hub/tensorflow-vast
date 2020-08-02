Class {
	#name : 'TFSumTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
TFSumTest >> testOperationName [

	| a b |

	a := tf floatConstantWith: #(1 2 3).
	b := tf floatConstantWith: #(4 5 6).

	self
		assert: (TFSum of: a plus: b) isNamedInGraphAs: 'Add';
		assert: (TFSum of: a plus: b) isNamedInGraphAs: 'Add_1';
		assert: (TFSum named: 'output' of: a plus: b) isNamedInGraphAs: 'output';
		assert: (TFSum named: 'output' of: a plus: b) isNamedInGraphAs: 'output_1'.

	self
		assert: (TFSum ofAll: (Array with: a with: b with: a)) isNamedInGraphAs: 'AddN';
		assert: (TFSum ofAll: (Array with: a with: b with: a)) isNamedInGraphAs: 'AddN_1';
		assert: (TFSum named: 'result' ofAll: (Array with: a with: b with: a))
			isNamedInGraphAs: 'result';
		assert: (TFSum named: 'result' ofAll: (Array with: a with: b with: a))
			isNamedInGraphAs: 'result_1'
]

{ #category : 'Test' }
TFSumTest >> testPrintString [

	| a b |

	a := tf floatConstantWith: #(1 2 3) named: 'a'.
	b := tf floatConstantWith: #(4 5 6) named: 'b'.

	self assert: (TFSum ofAll: (Array with: a with: b with: a)) printString equals: 'a + b + a'
]

{ #category : 'Test' }
TFSumTest >> testSum2FloatVectors [

	| sum a b |

	a := tf floatConstantWith: #(1 2 3).
	b := tf floatConstantWith: #(4 5 6).

	sum := TFSum of: a plus: b.

	self assertOutputOf: sum isFloatVectorCloseTo: #(5.0 7.0 9.0)
]

{ #category : 'Test' }
TFSumTest >> testSum2IntegerVectors [

	| sum a b |

	a := tf integerConstantWith: #(1 2 3).
	b := tf integerConstantWith: #(4 5 6).

	sum := TFSum of: a plus: b.

	self assertOutputOf: sum isIntegerVectorEqualsTo: #(5 7 9)
]

{ #category : 'Test' }
TFSumTest >> testSumMoreThan2FloatVectors [

	| sum tensors |

	tensors :=
		OrderedCollection new
			add: #(1 2 3 4);
			add: #(1 2 3 4);
			add: #(1 2 3 4);
			collect: [:tensor | tf floatConstantWith: tensor].

	sum := TFSum ofAll: tensors.

	self assertOutputOf: sum isFloatVectorCloseTo: #(3.0 6.0 9.0 12.0)
]
