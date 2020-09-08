Class {
	#name : 'GradientDescentTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#instVars : [
		'optimizer'
	],
	#category : 'TFOptimizerModelTests'
}

{ #category : 'Test',
  #vaVisibility : 'private' }
GradientDescentTest >> learningRate [

	^0.7
]

{ #category : 'Test',
  #vaVisibility : 'private' }
GradientDescentTest >> setUp [

	super setUp.
	optimizer := GradientDescent scalingBy: self learningRate
]

{ #category : 'Test' }
GradientDescentTest >> testAppliedTwice [

	| parameter grad parameterTensor gradTensor |

	parameter := 1.0.
	grad := Float pi.
	parameterTensor := tf variableNamed: 'var' with: parameter asTensor.
	gradTensor := tf constantWith: grad.

	parameter := parameter - (grad * self learningRate).
	self
		assertOutputOf: (optimizer apply: gradTensor to: parameterTensor)
		isFloatScalarCloseTo: parameter.

	parameter := parameter - (grad * self learningRate).
	self
		assertOutputOf: (optimizer apply: gradTensor to: parameterTensor)
		isFloatScalarCloseTo: parameter
]

{ #category : 'Test' }
GradientDescentTest >> testApplyGradientShouldUpdateVariables [

	| parameter parameterTensor grad result |

	parameter := 1.0.
	parameterTensor := tf variableNamed: 'var' with: parameter asTensor.
	grad := tf constantWith: Float pi.

	parameter := parameter - (Float pi * self learningRate).

	result := optimizer apply: grad to: parameterTensor.
	self assertOutputOf: result isFloatScalarCloseTo: parameter.
	self assertOutputOf: parameterTensor isFloatScalarCloseTo: parameter
]

{ #category : 'Test' }
GradientDescentTest >> testPrintString [

	self
		assert: optimizer shortName equals: 'Gradient Descent';
		assert: optimizer printString equals: 'Gradient Descent (learning rate: 0.7)'
]
