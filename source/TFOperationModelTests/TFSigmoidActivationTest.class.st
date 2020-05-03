Class {
	#name : 'TFSigmoidActivationTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFSigmoidActivationTest >> sigmoidAppliedTo: aNumber [

	^1 / (1 + aNumber negated exp)
]

{ #category : 'Test' }
TFSigmoidActivationTest >> testActivatingFloatScalar [

	| input sigmoid |

	input := tf variableNamed: 'input' with: 5 asFloatTensor.

	sigmoid := TFSigmoidActivation activating: input.

	self assertOutputOf: sigmoid isFloatScalarCloseTo: (self sigmoidAppliedTo: 5)
]

{ #category : 'Test' }
TFSigmoidActivationTest >> testActivatingFloatVector [

	| input sigmoid |

	input := tf variableNamed: 'input' with: #(5 -4) asFloatTensor.

	sigmoid := TFSigmoidActivation activating: input.

	self
		assertOutputOf: sigmoid
		isFloatVectorCloseTo: (
			OrderedCollection new
				add: (self sigmoidAppliedTo: 5);
				add: (self sigmoidAppliedTo: -4);
				yourself)
]

{ #category : 'Test' }
TFSigmoidActivationTest >> testActivatingIntegerScalarFails [

	| input |

	input := tf variableNamed: 'input' with: 5 asInt32Tensor.

	self
		assert: [TFSigmoidActivation activating: input]
		raisesExceptionWith:
			'INVALID_ARGUMENT: Value for attr ''T'' of int32 is not in the list of allowed values: bfloat16, half, float, double, complex64, complex128
	; NodeDef: {{node Sigmoid}}; Op<name=Sigmoid; signature=x:T -> y:T; attr=T:type,allowed=[DT_BFLOAT16, DT_HALF, DT_FLOAT, DT_DOUBLE, DT_COMPLEX64, DT_COMPLEX128]>'
]
