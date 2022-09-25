Class {
	#name : 'AdagradTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'NeuralNetworkTrainingOptimizerModelTests'
}

{ #category : 'Tests' }
AdagradTest >> testAppliedToVector [

	| parameter grad optimizer |

	parameter := #(1.0 2.0).
	grad := #(3.14 2.71).

	optimizer :=
		Adagrad new
			apply: (tf constantWith: grad asFloatTensor)
			to: (tf variableNamed: 'var' with: parameter asFloatTensor).

	self assertOutputOf: optimizer isFloatVectorCloseTo: #(0.999 1.999)
]

{ #category : 'Tests' }
AdagradTest >> testAppliedTwice [

	| parameter grad optimizer optimization accum epsilon lr |
	
	accum := Adagrad defaultInitialAccumulatorValue. 
	epsilon := Adagrad defaultEpsilonValue. 
	lr := Adagrad defaultLearningRate. 
	
	parameter := 1.0.
	grad := Float pi.
	optimizer := Adagrad new.
	optimization :=
		optimizer
			apply: (tf constantWith: grad)
			to: (tf variableNamed: 'var' with: parameter asTensor).

	accum := accum + (grad * grad) + epsilon.
	parameter := parameter - (lr * grad / accum sqrt).
	self assertOutputOf: optimization isFloatScalarCloseTo: parameter.

	accum := accum + (grad * grad) + epsilon.
	parameter := parameter - (lr * grad / accum sqrt).
	self assertOutputOf: optimization isFloatScalarCloseTo: parameter
]

{ #category : 'Tests' }
AdagradTest >> testAppliedTwiceToDifferentParameters [

	| parameter1 parameter2 grad2 grad1 optimizer accum param1optimization param2optimization |

	parameter1 := 1.0.
	parameter2 := #(1.5 2.0).
	grad1 := Float pi.
	grad2 := Array with: Float pi / 2 with: Float pi * 2.
	optimizer := Adagrad scalingBy: 0.02 startingAccumulatorWith: 0.0 usingForNumericalStability: 0.0.

	param1optimization :=
		optimizer
			apply: (tf constantWith: grad1)
			to: (tf variableNamed: 'var' with: parameter1 asTensor).
	param2optimization :=
		optimizer
			apply: (tf constantWith: grad2 asFloatTensor)
			to: (tf variableNamed: 'bias' with: parameter2 asFloatTensor).

	accum := grad1 * grad1.
	parameter1 := parameter1 - (0.02 * grad1 / accum sqrt).
	self assertOutputOf: param1optimization isFloatScalarCloseTo: parameter1.

	accum := accum + (grad1 * grad1).
	parameter1 := parameter1 - (0.02 * grad1 / accum sqrt).
	self assertOutputOf: param1optimization isFloatScalarCloseTo: parameter1.

	self assertOutputOf: param2optimization isFloatVectorCloseTo: #(1.48 1.98).
	self assertOutputOf: param2optimization isFloatVectorCloseTo: #(1.46585786342621 1.96585786342621)
]

{ #category : 'Tests' }
AdagradTest >> testAppliedTwiceToSameVariable [

	| parameter grad optimization accum epsilon lr |

	accum := 0.02.
	epsilon := 1e-6.
	lr := 0.9.

	parameter := 1.0.
	grad := Float pi.
	optimization :=
		(Adagrad
			scalingBy: lr
			startingAccumulatorWith: accum
			usingForNumericalStability: epsilon)
				apply: (tf constantWith: grad)
				to: (tf variableNamed: 'var' with: parameter asTensor).

	accum := accum + (grad * grad) + epsilon.
	parameter := parameter - (lr * grad / accum sqrt).
	self assertOutputOf: optimization isFloatScalarCloseTo: parameter.

	accum := accum + (grad * grad) + epsilon.
	parameter := parameter - (lr * grad / accum sqrt).
	self assertOutputOf: optimization isFloatScalarCloseTo: parameter
]

{ #category : 'Tests' }
AdagradTest >> testInitializedWithDefaultValues [

	| parameter grad optimizer accum |

	parameter := 1.0.
	grad := Float pi.

	optimizer :=
		Adagrad new
			apply: (tf constantWith: grad)
			to: (tf variableNamed: 'var' with: parameter asTensor).

	accum := grad * grad.
	parameter := parameter - (0.001 * grad / accum sqrt).
	self assertOutputOf: optimizer isFloatScalarCloseTo: parameter
]

{ #category : 'Tests' }
AdagradTest >> testPrintString [

	| adagrad |

	adagrad := Adagrad new.
	self
		assert: adagrad shortName equals: 'AdaGrad';
		assert: adagrad printString equals: 'AdaGrad (learning rate: 0.001)'
]
