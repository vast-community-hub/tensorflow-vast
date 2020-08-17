Class {
	#name : 'TFSoftmaxActivationTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
TFSoftmaxActivationTest >> testActivatingFloatScalarFails [

	| input softmax |

	input := tf variableNamed: 'input' with: 4 asFloatTensor.
	softmax := input softmax.

	self
		assert: [tf compute: softmax]
		raisesExceptionWith:
			'INVALID_ARGUMENT: logits must have >= 1 dimension, got []
	 [[{{node Softmax}}]]'
]

{ #category : 'Test' }
TFSoftmaxActivationTest >> testActivatingFloatVector [

	| input |

	input := tf variableNamed: 'input' with: #(4 5 -1) asFloatTensor.
	
	self assertOutputOf: input softmax isFloatVectorCloseTo: #(4 5 -1) softmax
]

{ #category : 'Test' }
TFSoftmaxActivationTest >> testActivatingIntegerScalarFails [

	| input |

	input := tf variableNamed: 'input' with: 4 asInt32Tensor.

	self
		assert: [input softmax]
		raisesExceptionWith:
			'INVALID_ARGUMENT: Value for attr ''T'' of int32 is not in the list of allowed values: half, bfloat16, float, double
	; NodeDef: {{node Softmax}}; Op<name=Softmax; signature=logits:T -> softmax:T; attr=T:type,allowed=[DT_HALF, DT_BFLOAT16, DT_FLOAT, DT_DOUBLE]>'
]

{ #category : 'Test' }
TFSoftmaxActivationTest >> testOperationName [

	| input |

	input := tf variableNamed: 'input' with: #(4 5 -1) asFloatTensor.

	self assert: (TFSoftmaxActivation activating: input) isNamedInGraphAs: 'Softmax'.
	self assert: (TFSoftmaxActivation activating: input) isNamedInGraphAs: 'Softmax_1'.
	self assert: (TFSoftmaxActivation named: 'output' activating: input) isNamedInGraphAs: 'output'.
	self assert: (TFSoftmaxActivation named: 'output' activating: input) isNamedInGraphAs: 'output_1'
]

{ #category : 'Test' }
TFSoftmaxActivationTest >> testPrintString [

	| input |

	input := tf variableNamed: 'input' with: #(4 5 -1) asFloatTensor.

	self assert: (TFSoftmaxActivation activating: input) printString equals: 'softmax(input)'
]
