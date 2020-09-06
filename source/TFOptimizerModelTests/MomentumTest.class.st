Class {
	#name : 'MomentumTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOptimizerModelTests'
}

{ #category : 'Tests' }
MomentumTest >> testAppliedToVector [

	| weights grads optimizer |

	weights := #(1.0 2.0).
	grads := #(3.14 2.71).
	optimizer :=
		(Momentum scalingBy: 0.02 momentumSetTo: 5.0)
			apply: (tf constantWith: grads asFloatTensor)
			to: (tf variableNamed: 'var' with: weights asFloatTensor).

	self
		assertOutputOf: optimizer
		isFloatVectorCloseTo: (Array with: (1 - (0.02 * 3.14)) with: (2 - (0.02 * 2.71)))
]

{ #category : 'Tests' }
MomentumTest >> testAppliedTwice [

	| weights grads optimizer gradsTensor weightsTensor accum |

	weights := 1.0.
	grads := Float pi.
	optimizer := Momentum scalingBy: 0.001 momentumSetTo: 0.9.

	gradsTensor := tf constantWith: grads.
	weightsTensor := tf variableNamed: 'var' with: weights asTensor.

	accum := grads.
	weights := weights - (0.001 * accum).
	self
		assertOutputOf: (optimizer apply: gradsTensor to: weightsTensor)
		isFloatScalarCloseTo: weights.

	accum := (accum * 0.9) + grads.
	weights := weights - (0.001 * accum).
	self
		assertOutputOf: (optimizer apply: gradsTensor to: weightsTensor)
		isFloatScalarCloseTo: weights
]

{ #category : 'Tests' }
MomentumTest >> testInitializedWithCustomValues [

	| weights grads optimizer |

	weights := 1.0.
	grads := Float pi.
	optimizer :=
		(Momentum scalingBy: 0.02 momentumSetTo: 5.0)
			apply: (tf constantWith: grads)
			to: (tf variableNamed: 'var' with: weights asTensor).

	self assertOutputOf: optimizer isFloatScalarCloseTo: weights - (0.02 * grads)
]

{ #category : 'Tests' }
MomentumTest >> testInitializedWithDefaultValues [

	| weights grads optimizer |

	weights := 1.0.
	grads := Float pi.
	optimizer :=
		Momentum new
			apply: (tf constantWith: grads)
			to: (tf variableNamed: 'var' with: weights asTensor).

	self assertOutputOf: optimizer isFloatScalarCloseTo: weights - (0.001 * grads)
]

{ #category : 'Tests' }
MomentumTest >> testPrintString [

	| adagrad |

	adagrad := Momentum new.
	self
		assert: adagrad shortName equals: 'Momentum';
		assert: adagrad printString equals: 'Momentum (learning rate: 0.001; momentum: 0.9)'
]
