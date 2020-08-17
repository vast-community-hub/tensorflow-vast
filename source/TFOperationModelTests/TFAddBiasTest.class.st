Class {
	#name : 'TFAddBiasTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
TFAddBiasTest >> testAddBias [

	| weight bias output |

	weight := tf variableNamed: 'weight' with: #((1 2 3) (5 6 7)) asInt32Tensor.
	bias := tf variableNamed: 'bias' with: #(100 101 102) asInt32Tensor.

	output := weight biasedBy: bias.

	self
		assertOutputOf: output
		isIntegerMatrixCloseTo: (
			OrderedCollection new
				add: (Array with: 1 + 100 with: 2 + 101 with: 3 + 102);
				add: (Array with: 5 + 100 with: 6 + 101 with: 7 + 102);
				yourself)
]

{ #category : 'Test' }
TFAddBiasTest >> testAddBiasComparedToSum [

	| weight bias addBias sum |

	weight := tf variableNamed: 'weight' with: #((1 2 3) (5 6 7)) asInt32Tensor.
	bias := tf variableNamed: 'bias' with: #(100 101 102) asInt32Tensor.

	addBias := weight biasedBy: bias.
	sum := weight + bias.
	self
		assertOutputOf: addBias
		isIntegerMatrixCloseTo: (
			OrderedCollection new
				add: (Array with: 1 + 100 with: 2 + 101 with: 3 + 102);
				add: (Array with: 5 + 100 with: 6 + 101 with: 7 + 102);
				yourself).

	self
		assertOutputOf: sum
		isIntegerMatrixCloseTo: (
			OrderedCollection new
				add: (Array with: 1 + 100 with: 2 + 101 with: 3 + 102);
				add: (Array with: 5 + 100 with: 6 + 101 with: 7 + 102);
				yourself)
]

{ #category : 'Test' }
TFAddBiasTest >> testOperationName [

	| weight bias |

	weight := tf variableNamed: 'weight' with: #((1 2 3) (5 6 7)) asInt32Tensor.
	bias := tf variableNamed: 'bias' with: #(100 101 102) asInt32Tensor.

	self assert: (TFAddBias to: weight with: bias) isNamedInGraphAs: 'BiasAdd'.
	self assert: (TFAddBias to: weight with: bias) isNamedInGraphAs: 'BiasAdd_1'.
	self assert: (TFAddBias named: 'output' to: weight with: bias) isNamedInGraphAs: 'output'.
	self assert: (TFAddBias named: 'output' to: weight with: bias) isNamedInGraphAs: 'output_1'
]

{ #category : 'Test' }
TFAddBiasTest >> testPrintString [

	| weight bias |

	weight := tf variableNamed: 'weight' with: #((1 2 3) (5 6 7)) asInt32Tensor.
	bias := tf variableNamed: 'bias' with: #(100 101 102) asInt32Tensor.

	self assert: (TFAddBias to: weight with: bias) printString equals: 'weight + bias'
]
