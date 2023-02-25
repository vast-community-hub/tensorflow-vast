Extension {
	#name : 'AddBiasTest'
}

{ #category : 'Test' }
AddBiasTest >> testAddBiasGradientComparedToSum [

	| weight bias addBias sum |

	weight := tf variableNamed: 'weight' with: #((1 2 3) (5 6 7)) asFloatTensor.
	bias := tf variableNamed: 'bias' with: #(100 101 102) asFloatTensor.

	sum := Sum of: weight plus: bias.
	self
		assertPartialDerivativeOf: sum
		withRespectTo: weight
		isMatrixCloseTo: (
			OrderedCollection new
				add: #(1 1 1);
				add: #(1 1 1);
				yourself).

	addBias := AddBias to: weight with: bias.
	self
		assertPartialDerivativeOf: addBias
		withRespectTo: weight
		isMatrixCloseTo: (
			OrderedCollection new
				add: #(1 1 1);
				add: #(1 1 1);
				yourself)
]
