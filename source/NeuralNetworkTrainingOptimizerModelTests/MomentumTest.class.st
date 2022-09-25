Class {
	#name : 'MomentumTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'NeuralNetworkTrainingOptimizerModelTests'
}

{ #category : 'Tests' }
MomentumTest >> testAppliedToVector [

	| parameter grad optimizer |

	parameter := #(1.0 2.0).
	grad := #(3.14 2.71).
	optimizer :=
		(Momentum scalingBy: 0.02 momentumSetTo: 5.0)
			apply: (tf constantWith: grad asFloatTensor)
			to: (tf variableNamed: 'var' with: parameter asFloatTensor).

	self
		assertOutputOf: optimizer
		isFloatVectorCloseTo: (Array with: (1 - (0.02 * 3.14)) with: (2 - (0.02 * 2.71)))
]

{ #category : 'Tests' }
MomentumTest >> testAppliedTwice [

	| parameter grad optimizer gradTensor parameterTensor accum |

	parameter := 1.0.
	grad := Float pi.
	optimizer := Momentum scalingBy: 0.001 momentumSetTo: 0.9.

	gradTensor := tf constantWith: grad.
	parameterTensor := tf variableNamed: 'var' with: parameter asTensor.

	accum := grad.
	parameter := parameter - (0.001 * accum).
	self
		assertOutputOf: (optimizer apply: gradTensor to: parameterTensor)
		isFloatScalarCloseTo: parameter.

	accum := (accum * 0.9) + grad.
	parameter := parameter - (0.001 * accum).
	self
		assertOutputOf: (optimizer apply: gradTensor to: parameterTensor)
		isFloatScalarCloseTo: parameter
]

{ #category : 'Tests' }
MomentumTest >> testAppliedTwiceToDifferentParameters [

	| parameter1 optimizer param1Optimization param2Optimization accum parameter2 grad1 grad2 |

	parameter1 := 1.0.
	parameter2 := #(1.5 2.0).
	grad1 := Float pi.
	grad2 := Array with: Float pi / 2 with: Float pi * 2.
	optimizer := Momentum scalingBy: 0.001 momentumSetTo: 0.9.

	param1Optimization :=
		optimizer
			apply: (tf constantWith: grad1)
			to: (tf variableNamed: 'var' with: parameter1 asTensor).
	param2Optimization :=
		optimizer
			apply: (tf constantWith: grad2 asFloatTensor)
			to: (tf variableNamed: 'bias' with: parameter2 asFloatTensor).

	accum := grad1.
	parameter1 := parameter1 - (0.001 * accum).
	self assertOutputOf: param1Optimization isFloatScalarCloseTo: parameter1.

	accum := (accum * 0.9) + grad1.
	parameter1 := parameter1 - (0.001 * accum).
	self assertOutputOf: param1Optimization isFloatScalarCloseTo: parameter1.

	self
		assertOutputOf: param2Optimization
		isFloatVectorCloseTo: #(1.49842917919159 1.99371683597565).
	self
		assertOutputOf: param2Optimization
		isFloatVectorCloseTo: #(1.4954446554184 1.98177874088287)
]

{ #category : 'Tests' }
MomentumTest >> testInitializedWithCustomValues [

	| parameter grad optimizer |

	parameter := 1.0.
	grad := Float pi.
	optimizer :=
		(Momentum scalingBy: 0.02 momentumSetTo: 5.0)
			apply: (tf constantWith: grad)
			to: (tf variableNamed: 'var' with: parameter asTensor).

	self assertOutputOf: optimizer isFloatScalarCloseTo: parameter - (0.02 * grad)
]

{ #category : 'Tests' }
MomentumTest >> testInitializedWithDefaultValues [

	| parameter grad optimizer |

	parameter := 1.0.
	grad := Float pi.
	optimizer :=
		Momentum new
			apply: (tf constantWith: grad)
			to: (tf variableNamed: 'var' with: parameter asTensor).

	self assertOutputOf: optimizer isFloatScalarCloseTo: parameter - (0.001 * grad)
]

{ #category : 'Tests' }
MomentumTest >> testPrintString [

	| adagrad |

	adagrad := Momentum new.
	self
		assert: adagrad shortName equals: 'Momentum';
		assert: adagrad printString equals: 'Momentum (learning rate: 0.001; momentum: 0.9)'
]
