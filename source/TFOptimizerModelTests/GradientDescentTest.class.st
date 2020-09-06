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

	| weights grads weightsTensor gradsTensor |

	weights := 1.0.
	grads := Float pi.
	weightsTensor := tf variableNamed: 'var' with: weights asTensor.
	gradsTensor := tf constantWith: grads.

	weights := weights - (grads * self learningRate).
	self
		assertOutputOf: (optimizer apply: gradsTensor to: weightsTensor)
		isFloatScalarCloseTo: weights.

	weights := weights - (grads * self learningRate).
	self
		assertOutputOf: (optimizer apply: gradsTensor to: weightsTensor)
		isFloatScalarCloseTo: weights
]

{ #category : 'Test' }
GradientDescentTest >> testApplyGradientShouldUpdateVariables [

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
GradientDescentTest >> testPrintString [

	self
		assert: optimizer shortName equals: 'Gradient Descent';
		assert: optimizer printString equals: 'Gradient Descent (learning rate: 0.7)'
]
