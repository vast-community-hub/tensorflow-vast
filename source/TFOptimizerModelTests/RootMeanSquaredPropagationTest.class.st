Class {
	#name : 'RootMeanSquaredPropagationTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOptimizerModelTests'
}

{ #category : 'Tests' }
RootMeanSquaredPropagationTest >> testAppliedToVector [

	| weights grads optimizer |

	weights := #(1.0 2.0).
	grads := #(3.14 2.71).

	optimizer :=
		RootMeanSquaredPropagation new
			apply: (tf constantWith: grads asFloatTensor)
			to: (tf variableNamed: 'var' with: weights asFloatTensor).

	self assertOutputOf: optimizer isFloatVectorCloseTo: #(0.9968377 1.9968377)
]

{ #category : 'Tests' }
RootMeanSquaredPropagationTest >> testAppliedTwice [

	| weights grads gradsTensor weightsTensor optimizer ms mom |

	weights := 1.0.
	grads := Float pi.
	optimizer :=
		RootMeanSquaredPropagation
			scalingBy: 0.03
			decayingBy: 0.2
			momentumSetTo: 0.5
			usingForNumericalStability: 1e-08.

	gradsTensor := tf constantWith: grads.
	weightsTensor := tf variableNamed: 'var' with: weights asTensor.

	ms := 0.2 * 0 + ((1 - 0.2) * grads * grads).
	mom := 0.5 * 0 + (0.03 * grads / (ms + 1e-08) sqrt).
	weights := weights - mom.
	self
		assertOutputOf: (optimizer apply: gradsTensor to: weightsTensor)
		isFloatScalarCloseTo: weights.

	ms := (0.2 * ms) + ((1 - 0.2) * grads * grads).
	mom := (0.5 * mom) + (0.03 * grads / ((ms + 1e-08) sqrt)).
	weights := weights - mom.
	self
		assertOutputOf: (optimizer apply: gradsTensor to: weightsTensor)
		isFloatScalarCloseTo: weights
]

{ #category : 'Tests' }
RootMeanSquaredPropagationTest >> testInitializedWithCustomValues [

	| weights grads optimizer ms mom |

	weights := 1.0.
	grads := Float pi.

	optimizer :=
		(RootMeanSquaredPropagation
			scalingBy: 0.03
			decayingBy: 0.2
			momentumSetTo: 0.5
			usingForNumericalStability: 1e-08)
				apply: (tf constantWith: grads)
				to: (tf variableNamed: 'var' with: weights asTensor).
		
	ms := 0.2 * 0 + (1 - 0.2) * grads * grads.
	mom := 0.5 * 0 + 0.03 * grads / (ms + 1e-08) sqrt.
	self assertOutputOf: optimizer isFloatScalarCloseTo: weights - mom
]

{ #category : 'Tests' }
RootMeanSquaredPropagationTest >> testInitializedWithDefaultValues [

	| weights grads optimizer ms mom |

	weights := 1.0.
	grads := Float pi.

	optimizer :=
		RootMeanSquaredPropagation new
			apply: (tf constantWith: grads)
			to: (tf variableNamed: 'var' with: weights asTensor).

	ms := (1 - 0.9) * grads * grads.
	mom := 0.001 * grads / (ms + 1e-07) sqrt.
	self assertOutputOf: optimizer isFloatScalarCloseTo: weights - mom
]

{ #category : 'Tests' }
RootMeanSquaredPropagationTest >> testPrintString [

	| rmsprop |

	rmsprop := RootMeanSquaredPropagation new.
	self
		assert: rmsprop shortName equals: 'RMSProp';
		assert: rmsprop printString
			equals: 'RMSProp (learning rate: 0.001; rho: 0.9; momentum: 0.0; epsilon: 0.0000001)'
]
