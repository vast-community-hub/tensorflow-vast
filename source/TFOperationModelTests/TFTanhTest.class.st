Class {
	#name : 'TFTanhTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
TFTanhTest >> testActivatingFloatScalar [

	| input |

	input := tf variableNamed: 'input' with: 0.549306 asFloatTensor.

	self assertOutputOf: (TFTanhActivation activating: input) isFloatScalarCloseTo: 0.5
]

{ #category : 'Test' }
TFTanhTest >> testActivatingIntegerScalarFails [

	| input |

	input := tf variableNamed: 'input' with: 1 asInt32Tensor.

	self
		assert: [TFTanhActivation activating: input]
		raisesExceptionWith:
			'INVALID_ARGUMENT: Value for attr ''T'' of int32 is not in the list of allowed values: bfloat16, half, float, double, complex64, complex128
	; NodeDef: {{node Tanh}}; Op<name=Tanh; signature=x:T -> y:T; attr=T:type,allowed=[DT_BFLOAT16, DT_HALF, DT_FLOAT, DT_DOUBLE, DT_COMPLEX64, DT_COMPLEX128]>'
]

{ #category : 'Test' }
TFTanhTest >> testOperationName [

	| input |

	input := tf variableNamed: 'input' with: 0.549306 asFloatTensor.

	self assert: (TFTanhActivation activating: input) isNamedInGraphAs: 'Tanh'.
	self assert: (TFTanhActivation activating: input) isNamedInGraphAs: 'Tanh_1'.
	self assert: (TFTanhActivation named: 'output' activating: input) isNamedInGraphAs: 'output'.
	self assert: (TFTanhActivation named: 'output' activating: input) isNamedInGraphAs: 'output_1'
]

{ #category : 'Test' }
TFTanhTest >> testPrintString [

	| input |

	input := tf variableNamed: 'input' with: 0.549306 asFloatTensor.

	self assert: (TFTanhActivation activating: input) printString equals: 'tanh(input)'
]
