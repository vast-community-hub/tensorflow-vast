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
		assertOutputOf: (TFAbsoluteValue of: input)
		isMatrixCloseTo: (
			(OrderedCollection new)
				add: #(1 0 0.1);
				add: #(0.0 0.5 0.9);
				add: #(0.9 2 10);
				add: #(0.3 0.3 0.3);
				yourself)
]
