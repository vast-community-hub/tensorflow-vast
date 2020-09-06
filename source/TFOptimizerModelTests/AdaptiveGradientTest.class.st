Class {
	#name : 'AdaptiveGradientTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOptimizerModelTests'
}

{ #category : 'Tests' }
AdaptiveGradientTest >> testAppliedToVector [

	| weights grads optimizer |

	weights := #(1.0 2.0).
	grads := #(3.14 2.71).

	optimizer :=
		AdaptiveGradient new
			apply: (tf constantWith: grads asFloatTensor)
			to: (tf variableNamed: 'var' with: weights asFloatTensor).

	self assertOutputOf: optimizer isFloatVectorCloseTo: #(0.999 1.99899)
]

{ #category : 'Tests' }
AdaptiveGradientTest >> testAppliedTwice [

	| weights grads optimizer gradsTensor weightsTensor accum |

	weights := 1.0.
	grads := Float pi.
	optimizer := AdaptiveGradient scalingBy: 0.02.

	gradsTensor := tf constantWith: grads.
	weightsTensor := tf variableNamed: 'var' with: weights asTensor.

	accum := (grads * grads).
	weights := weights - (0.02 * grads / accum sqrt).
	self
		assertOutputOf: (optimizer apply: gradsTensor to: weightsTensor)
		isFloatScalarCloseTo: weights.

	accum := accum + (grads * grads).
	weights := weights - (0.02 * grads / accum sqrt).
	self
		assertOutputOf: (optimizer apply: gradsTensor to: weightsTensor)
		isFloatScalarCloseTo: weights
]

{ #category : 'Tests' }
AdaptiveGradientTest >> testInitializedWithDefaultValues [

	| weights grads optimizer accum |

	weights := 1.0.
	grads := Float pi.

	optimizer :=
		AdaptiveGradient new
			apply: (tf constantWith: grads)
			to: (tf variableNamed: 'var' with: weights asTensor).

	accum := grads * grads.
	weights := weights - (0.001 * grads / accum sqrt).
	self assertOutputOf: optimizer isFloatScalarCloseTo: weights
]

{ #category : 'Tests' }
AdaptiveGradientTest >> testPrintString [

	| adagrad |

	adagrad := AdaptiveGradient new.
	self
		assert: adagrad shortName equals: 'AdaGrad';
		assert: adagrad printString equals: 'AdaGrad (learning rate: 0.001)'
]
