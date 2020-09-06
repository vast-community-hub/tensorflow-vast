Class {
	#name : 'AddBiasTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
AddBiasTest >> testAddBias [

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
AddBiasTest >> testAddBiasComparedToSum [

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
AddBiasTest >> testOperationName [

	| weight bias |

	weight := tf variableNamed: 'weight' with: #((1 2 3) (5 6 7)) asInt32Tensor.
	bias := tf variableNamed: 'bias' with: #(100 101 102) asInt32Tensor.

	self assert: (AddBias to: weight with: bias) isNamedInGraphAs: 'BiasAdd'.
	self assert: (AddBias to: weight with: bias) isNamedInGraphAs: 'BiasAdd_1'.
	self assert: (AddBias named: 'output' to: weight with: bias) isNamedInGraphAs: 'output'.
	self assert: (AddBias named: 'output' to: weight with: bias) isNamedInGraphAs: 'output_1'
]

{ #category : 'Test' }
AddBiasTest >> testPrintString [

	| weight bias |

	weight := tf variableNamed: 'weight' with: #((1 2 3) (5 6 7)) asInt32Tensor.
	bias := tf variableNamed: 'bias' with: #(100 101 102) asInt32Tensor.

	self assert: (AddBias to: weight with: bias) printString equals: 'weight + bias'
]
