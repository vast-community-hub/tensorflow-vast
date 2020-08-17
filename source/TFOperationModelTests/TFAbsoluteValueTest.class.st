Class {
	#name : 'TFAbsoluteValueTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Tests' }
TFAbsoluteValueTest >> testAbsoluteValueOfMatrixVariable [

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
TFAbsoluteValueTest >> testOperationName [

	| input |

	input := tf constantWith: 3.

	self assert: (TFAbsoluteValue of: input) isNamedInGraphAs: 'Abs'.
	self assert: (TFAbsoluteValue of: input) isNamedInGraphAs: 'Abs_1'.
	self assert: (TFAbsoluteValue named: 'value' of: input) isNamedInGraphAs: 'value'.
	self assert: (TFAbsoluteValue named: 'value' of: input) isNamedInGraphAs: 'value_1'
]

{ #category : 'Tests' }
TFAbsoluteValueTest >> testPrintString [

	| input |

	input := tf constantWith: 3.

	self assert: (TFAbsoluteValue of: input) printString equals: 'abs(Const)'
]
