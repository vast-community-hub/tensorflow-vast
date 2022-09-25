Class {
	#name : 'RootMeanSquaredPropagationTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'NeuralNetworkTrainingOptimizerModelTests'
}

{ #category : 'Tests' }
RootMeanSquaredPropagationTest >> testAppliedToVector [

	| parameter grad optimizer |

	parameter := #(1.0 2.0).
	grad := #(3.14 2.71).

	optimizer :=
		RootMeanSquaredPropagation new
			apply: (tf constantWith: grad asFloatTensor)
			to: (tf variableNamed: 'var' with: parameter asFloatTensor).

	self assertOutputOf: optimizer isFloatVectorCloseTo: #(0.9968377 1.9968377)
]

{ #category : 'Tests' }
RootMeanSquaredPropagationTest >> testAppliedTwice [

	| parameter grad gradTensor parameterTensor optimizer ms mom |

	parameter := 1.0.
	grad := Float pi.
	optimizer :=
		RootMeanSquaredPropagation
			scalingBy: 0.03
			decayingBy: 0.2
			momentumSetTo: 0.5
			usingForNumericalStability: 1e-08.

	gradTensor := tf constantWith: grad.
	parameterTensor := tf variableNamed: 'var' with: parameter asTensor.

	ms := 0.2 * 0 + ((1 - 0.2) * grad * grad).
	mom := 0.5 * 0 + (0.03 * grad / (ms + 1e-08) sqrt).
	parameter := parameter - mom.
	self
		assertOutputOf: (optimizer apply: gradTensor to: parameterTensor)
		isFloatScalarCloseTo: parameter.

	ms := (0.2 * ms) + ((1 - 0.2) * grad * grad).
	mom := (0.5 * mom) + (0.03 * grad / ((ms + 1e-08) sqrt)).
	parameter := parameter - mom.
	self
		assertOutputOf: (optimizer apply: gradTensor to: parameterTensor)
		isFloatScalarCloseTo: parameter
]

{ #category : 'Tests' }
RootMeanSquaredPropagationTest >> testAppliedTwiceToDifferentParameters [

	| parameter1 grad1 optimizer ms mom parameter2 grad2 param2Optimization param1Optimization |

	parameter1 := 1.0.
	parameter2 := #(1.5 2.0).
	grad1 := Float pi.
	grad2 := Array with: Float pi / 2 with: Float pi * 2.
	optimizer :=
		RootMeanSquaredPropagation
			scalingBy: 0.03
			decayingBy: 0.2
			momentumSetTo: 0.5
			usingForNumericalStability: 1e-08.

	param1Optimization :=
		optimizer
			apply: (tf constantWith: grad1)
			to: (tf variableNamed: 'var' with: parameter1 asTensor).
	param2Optimization :=
		optimizer
			apply: (tf constantWith: grad2 asFloatTensor)
			to: (tf variableNamed: 'bias' with: parameter2 asFloatTensor).

	ms := 0.2 * 0 + ((1 - 0.2) * grad1 * grad1).
	mom := 0.5 * 0 + (0.03 * grad1 / (ms + 1e-08) sqrt).
	parameter1 := parameter1 - mom.
	self assertOutputOf: param1Optimization isFloatScalarCloseTo: parameter1.

	ms := (0.2 * ms) + ((1 - 0.2) * grad1 * grad1).
	mom := (0.5 * mom) + (0.03 * grad1 / ((ms + 1e-08) sqrt)).
	parameter1 := parameter1 - mom.
	self assertOutputOf: param1Optimization isFloatScalarCloseTo: parameter1.

	self assertOutputOf: param2Optimization isFloatVectorCloseTo: #(1.46645903587341 1.96645903587341).
	self assertOutputOf: param2Optimization isFloatVectorCloseTo: #(1.41906988620758 1.91906988620758)
]

{ #category : 'Tests' }
RootMeanSquaredPropagationTest >> testInitializedWithCustomValues [

	| parameter grad optimizer ms mom |

	parameter := 1.0.
	grad := Float pi.

	optimizer :=
		(RootMeanSquaredPropagation
			scalingBy: 0.03
			decayingBy: 0.2
			momentumSetTo: 0.5
			usingForNumericalStability: 1e-08)
				apply: (tf constantWith: grad)
				to: (tf variableNamed: 'var' with: parameter asTensor).
		
	ms := 0.2 * 0 + (1 - 0.2) * grad * grad.
	mom := 0.5 * 0 + 0.03 * grad / (ms + 1e-08) sqrt.
	self assertOutputOf: optimizer isFloatScalarCloseTo: parameter - mom
]

{ #category : 'Tests' }
RootMeanSquaredPropagationTest >> testInitializedWithDefaultValues [

	| parameter grad optimizer ms mom |

	parameter := 1.0.
	grad := Float pi.

	optimizer :=
		RootMeanSquaredPropagation new
			apply: (tf constantWith: grad)
			to: (tf variableNamed: 'var' with: parameter asTensor).

	ms := (1 - 0.9) * grad * grad.
	mom := 0.001 * grad / (ms + 1e-07) sqrt.
	self assertOutputOf: optimizer isFloatScalarCloseTo: parameter - mom
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
