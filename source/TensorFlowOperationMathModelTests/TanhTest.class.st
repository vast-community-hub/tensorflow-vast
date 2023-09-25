Class {
	#name : 'TanhTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TensorFlowOperationMathModelTests'
}

{ #category : 'Test' }
TanhTest >> testActivatingFloatScalar [

	| input |

	input := tf variableNamed: 'input' with: 0.549306 asFloatTensor.

	self assertOutputOf: input tanh isFloatScalarCloseTo: 0.5
]

{ #category : 'Test' }
TanhTest >> testActivatingIntegerScalarFails [

	| input |

	input := tf variableNamed: 'input' with: 1 asInt32Tensor.

	self
		assert: [input tanh]
		raisesExceptionWith:
			'INVALID_ARGUMENT: Value for attr ''T'' of int32 is not in the list of allowed values: bfloat16, half, float, double, complex64, complex128
	; NodeDef: {{node activation}}; Op<name=Tanh; signature=x:T -> y:T; attr=T:type,allowed=[DT_BFLOAT16, DT_HALF, DT_FLOAT, DT_DOUBLE, DT_COMPLEX64, DT_COMPLEX128]>'
]

{ #category : 'Test' }
TanhTest >> testOperationName [

	| input |

	input := tf variableNamed: 'input' with: 0.549306 asFloatTensor.

	self assert: (Tanh activating: input) isNamedInGraphAs: 'activation'.
	self assert: (Tanh activating: input) isNamedInGraphAs: 'activation_1'.
	self assert: (Tanh named: 'output' activating: input) isNamedInGraphAs: 'output'.
	self assert: (Tanh named: 'output' activating: input) isNamedInGraphAs: 'output_1'
]

{ #category : 'Test' }
TanhTest >> testPrintString [

	| input |

	input := tf variableNamed: 'input' with: 0.549306 asFloatTensor.

	self assert: (Tanh activating: input) printString equals: 'tanh(input)'
]
