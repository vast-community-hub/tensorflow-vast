Class {
	#name : 'AbsoluteValueTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TensorFlowOperationMathModelTests'
}

{ #category : 'Tests' }
AbsoluteValueTest >> testAbsoluteValueOfMatrixVariable [

	| input |

	input :=
		tf
			variableNamed: 'expected'
			with: (
				(OrderedCollection new)
					add: #(-1 -0 0.1);
					add: #(0.0 -0.5 0.9);
					add: #(0.9 -2 -10);
					add: #(-0.3 0.3 0.3);
					asFloatTensor).

	self
		assertOutputOf: input abs
		isMatrixCloseTo: (
			(OrderedCollection new)
				add: #(1 0 0.1);
				add: #(0.0 0.5 0.9);
				add: #(0.9 2 10);
				add: #(0.3 0.3 0.3);
				yourself)
]

{ #category : 'Tests' }
AbsoluteValueTest >> testOperationName [

	| input |

	input := tf constantWith: 3.

	self assert: (AbsoluteValue of: input) isNamedInGraphAs: 'Abs'.
	self assert: (AbsoluteValue of: input) isNamedInGraphAs: 'Abs_1'.
	self assert: (AbsoluteValue named: 'value' of: input) isNamedInGraphAs: 'value'.
	self assert: (AbsoluteValue named: 'value' of: input) isNamedInGraphAs: 'value_1'
]

{ #category : 'Tests' }
AbsoluteValueTest >> testPrintString [

	| input |

	input := tf constantWith: 3.

	self assert: (AbsoluteValue of: input) printString equals: 'abs(Const)'
]
