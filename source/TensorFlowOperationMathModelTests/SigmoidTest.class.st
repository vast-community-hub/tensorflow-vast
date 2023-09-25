Class {
	#name : 'SigmoidTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TensorFlowOperationMathModelTests'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
SigmoidTest >> sigmoidAppliedTo: aNumber [

	^1 / (1 + aNumber negated exp)
]

{ #category : 'Test' }
SigmoidTest >> testActivatingFloatScalar [

	| input |

	input := tf variableNamed: 'input' with: 5 asFloatTensor.

	self assertOutputOf: input sigmoid isFloatScalarCloseTo: (self sigmoidAppliedTo: 5)
]

{ #category : 'Test' }
SigmoidTest >> testActivatingFloatVector [

	| input |

	input := tf variableNamed: 'input' with: #(5 -4) asFloatTensor.
	
	self
		assertOutputOf: input sigmoid
		isFloatVectorCloseTo: (
			(OrderedCollection new)
				add: (self sigmoidAppliedTo: 5);
				add: (self sigmoidAppliedTo: -4);
				yourself)
]

{ #category : 'Test' }
SigmoidTest >> testActivatingIntegerScalarFails [

	| input |

	input := tf variableNamed: 'input' with: 5 asInt32Tensor.

	self
		assert: [input sigmoid]
		raisesExceptionWith:
			'INVALID_ARGUMENT: Value for attr ''T'' of int32 is not in the list of allowed values: bfloat16, half, float, double, complex64, complex128
	; NodeDef: {{node activation}}; Op<name=Sigmoid; signature=x:T -> y:T; attr=T:type,allowed=[DT_BFLOAT16, DT_HALF, DT_FLOAT, DT_DOUBLE, DT_COMPLEX64, DT_COMPLEX128]>'
]

{ #category : 'Test' }
SigmoidTest >> testOperationName [

	| neuron |

	neuron := tf variableNamed: 'input' with: 5 asFloatTensor.

	self assert: (Sigmoid activating: neuron) isNamedInGraphAs: 'activation'.
	self assert: (Sigmoid activating: neuron) isNamedInGraphAs: 'activation_1'.
	self assert: (Sigmoid named: 'output' activating: neuron) isNamedInGraphAs: 'output'.
	self
		assert: (Sigmoid named: 'output' activating: neuron)
		isNamedInGraphAs: 'output_1'
]

{ #category : 'Test' }
SigmoidTest >> testPrintString [

	| neuron |

	neuron := tf variableNamed: 'input' with: 5 asFloatTensor.

	self assert: (Sigmoid activating: neuron) printString equals: 'sigmoid(input)'
]
