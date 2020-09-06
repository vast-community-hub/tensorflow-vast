Class {
	#name : 'AdaptiveMomentEstimationTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOptimizerModelTests'
}

{ #category : 'Tests' }
AdaptiveMomentEstimationTest >> testAppliedToVector [

	| weights grads optimizer |

	weights := #(1.0 2.0).
	grads := #(3.14 2.71).

	optimizer :=
		AdaptiveMomentEstimation new
			apply: (tf constantWith: grads asFloatTensor)
			to: (tf variableNamed: 'var' with: weights asFloatTensor).

	self assertOutputOf: optimizer isFloatVectorCloseTo: #(0.999 1.999)
]

{ #category : 'Tests' }
AdaptiveMomentEstimationTest >> testAppliedTwice [

	| weights grads optimizer lrt mt vt gradsTensor weightsTensor |

	weights := 1.0.
	grads := Float pi.
	optimizer := AdaptiveMomentEstimation new.

	gradsTensor := tf constantWith: grads.
	weightsTensor := tf variableNamed: 'var' with: weights asTensor.

	lrt := 0.001 * ((1 - 0.999) sqrt / (1 - 0.9)).

	mt := (1 - 0.9) * grads.
	vt := (1 - 0.999) * grads * grads.
	weights := weights - (lrt * mt / (vt sqrt + 10e-8)).
	self
		assertOutputOf: (optimizer apply: gradsTensor to: weightsTensor)
		isFloatScalarCloseTo: weights.

	mt := (0.9 * mt) + ((1 - 0.9) * grads).
	vt := (0.999 * vt) + ((1 - 0.999) * grads * grads).
	weights := weights - (lrt * mt / (vt sqrt + 10e-8)).
	self
		assertOutputOf: (optimizer apply: gradsTensor to: weightsTensor)
		isFloatScalarCloseTo: weights
]

{ #category : 'Tests' }
AdaptiveMomentEstimationTest >> testInitializedWithDefaultValues [

	| weights grads optimizer lrt mt vt |

	weights := 1.0.
	grads := Float pi.

	optimizer :=
		AdaptiveMomentEstimation new
			apply: (tf constantWith: grads)
			to: (tf variableNamed: 'var' with: weights asTensor).

	lrt := 0.001 * ((1 - 0.999) sqrt / (1 - 0.9)).
	mt := (1 - 0.9) * grads.
	vt := (1 - 0.999) * grads * grads.
	self assertOutputOf: optimizer isFloatScalarCloseTo: (weights - (lrt * mt / (vt sqrt + 10e-8)))
]

{ #category : 'Tests' }
AdaptiveMomentEstimationTest >> testPrintString [

	| adam |

	adam := AdaptiveMomentEstimation new.
	self
		assert: adam shortName equals: 'Adam';
		assert: adam printString
			equals: 'Adam (learning rate: 0.001; beta1: 0.9; beta2: 0.999; epsilon: 0.0000001)'
]
