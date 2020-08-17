Class {
	#name : 'TFReluActivationTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
TFReluActivationTest >> testActivatingFloatMatrix [

	| input |

	input :=
		tf
			variableNamed: 'input'
			with: (
				OrderedCollection new
					add: #(-1 4 -0.4 5);
					add: #(100 -35 5 0);
					asFloatTensor).

	self
		assertOutputOf: input relu
		isMatrixCloseTo: (
			OrderedCollection new
				add: #(0 4 0 5);
				add: #(100 0 5 0);
				yourself)
]

{ #category : 'Test' }
TFReluActivationTest >> testActivatingFloatScalar [

	| negative positive |

	negative := tf variableNamed: 'negative' with: -4 asFloatTensor.
	positive := tf variableNamed: 'positive' with: 5 asFloatTensor.

	self assertOutputOf: negative relu isFloatScalarCloseTo: 0.
	self assertOutputOf: positive relu isFloatScalarCloseTo: 5
]

{ #category : 'Test' }
TFReluActivationTest >> testActivatingFloatVector [

	| input |

	input := tf variableNamed: 'input' with: #(-1 4 -0.4 5) asFloatTensor.

	self assertOutputOf: input relu isFloatVectorCloseTo: #(0 4 0 5)
]

{ #category : 'Test' }
TFReluActivationTest >> testActivatingIntegerScalar [

	| negative positive |

	negative := tf variableNamed: 'negative' with: -4 asInt32Tensor.
	positive := tf variableNamed: 'positive' with: 5 asInt32Tensor.

	self assertOutputOf: negative relu isIntegerScalarEqualTo: 0.
	self assertOutputOf: positive relu isIntegerScalarEqualTo: 5
]

{ #category : 'Test' }
TFReluActivationTest >> testOperationName [

	| neuron |

	neuron := tf variableNamed: 'positive' with: 5 asFloatTensor.

	self assert: (TFReluActivation activating: neuron) isNamedInGraphAs: 'Relu'.
	self assert: (TFReluActivation activating: neuron) isNamedInGraphAs: 'Relu_1'.
	self assert: (TFReluActivation named: 'output' activating: neuron) isNamedInGraphAs: 'output'.
	self assert: (TFReluActivation named: 'output' activating: neuron) isNamedInGraphAs: 'output_1'
]

{ #category : 'Test' }
TFReluActivationTest >> testPrintString [

	| neuron |

	neuron := tf variableNamed: 'positive' with: 5 asFloatTensor.

	self assert: (TFReluActivation activating: neuron) printString equals: 'relu(positive)'
]
