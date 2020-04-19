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

	output := TFAddBias to: weight with: bias.

	self
		assertOutputOf: output
		isMatrixCloseTo: (
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

	addBias := TFAddBias to: weight with: bias.
	sum := TFSum of: weight plus: bias.
	self
		assertOutputOf: addBias
		isMatrixCloseTo: (
			OrderedCollection new
				add: (Array with: 1 + 100 with: 2 + 101 with: 3 + 102);
				add: (Array with: 5 + 100 with: 6 + 101 with: 7 + 102);
				yourself).

	self
		assertOutputOf: sum
		isMatrixCloseTo: (
			OrderedCollection new
				add: (Array with: 1 + 100 with: 2 + 101 with: 3 + 102);
				add: (Array with: 5 + 100 with: 6 + 101 with: 7 + 102);
				yourself)
]
