Class {
	#name : 'TFGradientDescentTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#instVars : [
		'optimizer'
	],
	#category : 'TFOptimizerModelTests'
}

{ #category : 'Test',
  #vaVisibility : 'private' }
TFGradientDescentTest >> learningRate [

	^0.7
]

{ #category : 'Test',
  #vaVisibility : 'private' }
TFGradientDescentTest >> setUp [

	super setUp.
	optimizer := TFGradientDescent scalingBy: self learningRate
]

{ #category : 'Test' }
TFGradientDescentTest >> testApplyGradientShouldUpdateVariables [

	| originalWeight weights delta result expectedNewWeight |

	originalWeight := 1.0.
	weights := tf variableNamed: 'var' with: originalWeight asTensor.
	delta := tf constantWith: Float pi.

	expectedNewWeight := originalWeight - (Float pi * self learningRate).

	result := optimizer apply: delta to: weights.
	self assertOutputOf: result isFloatScalarCloseTo: expectedNewWeight.
	self assertOutputOf: weights isFloatScalarCloseTo: expectedNewWeight
]

{ #category : 'Test' }
TFGradientDescentTest >> testPrintString [

	self assert: optimizer printString equals: 'Gradient Descent with a learning rate of 0.7'
]
