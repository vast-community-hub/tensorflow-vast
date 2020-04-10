Class {
	#name : 'TFSoftmaxActivationTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
TFSoftmaxActivationTest >> testActivatingFloatScalarFails [

	| input softmax |

	input := tf variableNamed: 'input' with: 4 asFloatTensor.
	softmax := TFSoftmaxActivation activating: input.
	
	self
		assert: [tf compute: softmax]
		raisesExceptionWith:
			'INVALID_ARGUMENT: logits must have >= 1 dimension, got []
	 [[{{node Softmax_3}}]]'
]

{ #category : 'Test' }
TFSoftmaxActivationTest >> testActivatingFloatVector [

	| input softmax |

	input := tf variableNamed: 'input' with: #(4 5 -1) asFloatTensor.
	softmax := TFSoftmaxActivation activating: input.

	self assertOutputOf: softmax isFloatVectorCloseTo: #(4 5 -1) softmax
]

{ #category : 'Test' }
TFSoftmaxActivationTest >> testActivatingIntegerScalarFails [

	| input |

	input := tf variableNamed: 'input' with: 4 asInt32Tensor.

	self
		assert: [TFSoftmaxActivation activating: input]
		raisesExceptionWith:
			'INVALID_ARGUMENT: Value for attr ''T'' of int32 is not in the list of allowed values: half, bfloat16, float, double
	; NodeDef: {{node Softmax_3}}; Op<name=Softmax; signature=logits:T -> softmax:T; attr=T:type,allowed=[DT_HALF, DT_BFLOAT16, DT_FLOAT, DT_DOUBLE]>'
]
