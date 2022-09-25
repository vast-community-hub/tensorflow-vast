Class {
	#name : 'SoftmaxTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TensorFlowOperationMathModelTests'
}

{ #category : 'Test' }
SoftmaxTest >> testActivatingFloatScalarFails [

	| input |

	input := tf variableNamed: 'input' with: 4 asFloatTensor.

	self
		assert: [input softmax]
		raisesExceptionWith:
			'INVALID_ARGUMENT: Shape must be at least rank 1 but is rank 0 for ''{{node Softmax}} = Softmax[T=DT_FLOAT](input)'' with input shapes: [].'
]

{ #category : 'Test' }
SoftmaxTest >> testActivatingFloatVector [

	| input |

	input := tf variableNamed: 'input' with: #(4 5 -1) asFloatTensor.
	
	self assertOutputOf: input softmax isFloatVectorCloseTo: #(4 5 -1) softmax
]

{ #category : 'Test' }
SoftmaxTest >> testActivatingIntegerScalarFails [

	| input |

	input := tf variableNamed: 'input' with: 4 asInt32Tensor.

	self
		assert: [input softmax]
		raisesExceptionWith:
			'INVALID_ARGUMENT: Value for attr ''T'' of int32 is not in the list of allowed values: half, bfloat16, float, double
	; NodeDef: {{node Softmax}}; Op<name=Softmax; signature=logits:T -> softmax:T; attr=T:type,allowed=[DT_HALF, DT_BFLOAT16, DT_FLOAT, DT_DOUBLE]>'
]

{ #category : 'Test' }
SoftmaxTest >> testOperationName [

	| input |

	input := tf variableNamed: 'input' with: #(4 5 -1) asFloatTensor.

	self assert: (Softmax activating: input) isNamedInGraphAs: 'Softmax'.
	self assert: (Softmax activating: input) isNamedInGraphAs: 'Softmax_1'.
	self assert: (Softmax named: 'output' activating: input) isNamedInGraphAs: 'output'.
	self assert: (Softmax named: 'output' activating: input) isNamedInGraphAs: 'output_1'
]

{ #category : 'Test' }
SoftmaxTest >> testPrintString [

	| input |

	input := tf variableNamed: 'input' with: #(4 5 -1) asFloatTensor.

	self assert: (Softmax activating: input) printString equals: 'softmax(input)'
]
