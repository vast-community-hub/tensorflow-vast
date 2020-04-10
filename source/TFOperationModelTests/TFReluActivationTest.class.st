Class {
	#name : 'TFReluActivationTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
TFReluActivationTest >> testActivatingFloatMatrix [

	| input relu |

	input :=
		tf
			variableNamed: 'input'
			with: (
				OrderedCollection new
					add: #(-1 4 -0.4 5);
					add: #(100 -35 5 0);
					asFloatTensor).

	relu := TFReluActivation activating: input.

	self
		assertOutputOf: relu
		isMatrixCloseTo: (
			OrderedCollection new
				add: #(0 4 0 5);
				add: #(100 0 5 0);
				yourself)
]

{ #category : 'Test' }
TFReluActivationTest >> testActivatingFloatScalar [

	| negative positive relu |

	negative := tf variableNamed: 'negative' with: -4 asFloatTensor.
	positive := tf variableNamed: 'positive' with: 5 asFloatTensor.

	relu := TFReluActivation activating: negative.

	self assertOutputOf: relu isScalarEqualTo: 0.


	relu := TFReluActivation activating: positive.

	self assertOutputOf: relu isScalarEqualTo: 5
]

{ #category : 'Test' }
TFReluActivationTest >> testActivatingFloatVector [

	| input relu |

	input := tf variableNamed: 'input' with: #(-1 4 -0.4 5) asFloatTensor.

	relu := TFReluActivation activating: input.

	self assertOutputOf: relu isFloatVectorCloseTo: #(0 4 0 5)
]

{ #category : 'Test' }
TFReluActivationTest >> testActivatingIntegerScalar [

	| negative positive relu |

	negative := tf variableNamed: 'negative' with: -4 asInt32Tensor.
	positive := tf variableNamed: 'positive' with: 5 asInt32Tensor.

	relu := TFReluActivation activating: negative.

	self assertOutputOf: relu isScalarEqualTo: 0.


	relu := TFReluActivation activating: positive.

	self assertOutputOf: relu isScalarEqualTo: 5
]
