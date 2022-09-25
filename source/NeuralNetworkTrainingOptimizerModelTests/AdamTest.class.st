Class {
	#name : 'AdamTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'NeuralNetworkTrainingOptimizerModelTests'
}

{ #category : 'Tests' }
AdamTest >> testAppliedToVector [

	| parameter grad optimizer |

	parameter := #(1.0 2.0).
	grad := #(3.14 2.71).

	optimizer :=
		Adam new
			apply: (tf constantWith: grad asFloatTensor)
			to: (tf variableNamed: 'var' with: parameter asFloatTensor).

	self assertOutputOf: optimizer isFloatVectorCloseTo: #(0.999 1.999)
]

{ #category : 'Tests' }
AdamTest >> testAppliedTwice [

	| parameter grad optimizer lrt mt vt gradTensor parameterTensor |

	parameter := 1.0.
	grad := Float pi.
	optimizer := Adam new.

	gradTensor := tf constantWith: grad.
	parameterTensor := tf variableNamed: 'var' with: parameter asTensor.

	lrt := 0.001 * ((1 - 0.999) sqrt / (1 - 0.9)).

	mt := (1 - 0.9) * grad.
	vt := (1 - 0.999) * grad * grad.
	parameter := parameter - (lrt * mt / (vt sqrt + 10e-8)).
	self
		assertOutputOf: (optimizer apply: gradTensor to: parameterTensor)
		isFloatScalarCloseTo: parameter.

	mt := (0.9 * mt) + ((1 - 0.9) * grad).
	vt := (0.999 * vt) + ((1 - 0.999) * grad * grad).
	parameter := parameter - (lrt * mt / (vt sqrt + 10e-8)).
	self
		assertOutputOf: (optimizer apply: gradTensor to: parameterTensor)
		isFloatScalarCloseTo: parameter
]

{ #category : 'Tests' }
AdamTest >> testAppliedTwiceToDifferentParameters [

	| parameter1 grad1 optimizer lrt mt vt parameter2 grad2 weightOptimization biasOptimization |

	parameter1 := 1.0.
	parameter2 := #(1.5 2.0).
	grad1 := Float pi.
	grad2 := Array with: Float pi / 2 with: Float pi * 2.
	optimizer := Adam new.

	weightOptimization :=
		optimizer
			apply: (tf constantWith: grad1)
			to: (tf variableNamed: 'var' with: parameter1 asTensor).
	biasOptimization :=
		optimizer
			apply: (tf constantWith: grad2 asFloatTensor)
			to: (tf variableNamed: 'bias' with: parameter2 asFloatTensor).

	lrt := 0.001 * ((1 - 0.999) sqrt / (1 - 0.9)).

	mt := (1 - 0.9) * grad1.
	vt := (1 - 0.999) * grad1 * grad1.
	parameter1 := parameter1 - (lrt * mt / (vt sqrt + 10e-8)).
	self assertOutputOf: weightOptimization isFloatScalarCloseTo: parameter1.

	mt := (0.9 * mt) + ((1 - 0.9) * grad1).
	vt := (0.999 * vt) + ((1 - 0.999) * grad1 * grad1).
	parameter1 := parameter1 - (lrt * mt / (vt sqrt + 10e-8)).
	self assertOutputOf: weightOptimization isFloatScalarCloseTo: parameter1.

	self assertOutputOf: biasOptimization isFloatVectorCloseTo: #(1.49899995326996 1.99899995326996).
	self assertOutputOf: biasOptimization isFloatVectorCloseTo: #(1.49765610694885 1.99765610694885)
]

{ #category : 'Tests' }
AdamTest >> testInitializedWithDefaultValues [

	| parameter grad optimizer lrt mt vt |

	parameter := 1.0.
	grad := Float pi.

	optimizer :=
		Adam new
			apply: (tf constantWith: grad)
			to: (tf variableNamed: 'var' with: parameter asTensor).

	lrt := 0.001 * ((1 - 0.999) sqrt / (1 - 0.9)).
	mt := (1 - 0.9) * grad.
	vt := (1 - 0.999) * grad * grad.
	self assertOutputOf: optimizer isFloatScalarCloseTo: (parameter - (lrt * mt / (vt sqrt + 10e-8)))
]

{ #category : 'Tests' }
AdamTest >> testPrintString [

	| adam |

	adam := Adam new.
	self
		assert: adam shortName equals: 'Adam';
		assert: adam printString
			equals: 'Adam (learning rate: 0.001; beta1: 0.9; beta2: 0.999; epsilon: 0.0000001)'
]
