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
	optimizer := TFGradientDescent scalingBy: (tf defineFloatTensorWith: self learningRate)
]

{ #category : 'Test' }
TFGradientDescentTest >> testApplyGradientShouldUpdateVariables [

	| originalWeight weights delta result expectedNewWeight |

	originalWeight := 1.0.
	weights := tf variableNamed: 'var' with: originalWeight asTensor.
	delta := tf defineFloatTensorWith: Float pi.

	expectedNewWeight := originalWeight - (Float pi * self learningRate).

	result := tf compute: (optimizer apply: delta to: weights).
	self assert: (result allFloats first closeTo: expectedNewWeight).

	result := tf compute: weights.
	self assert: (result allFloats first closeTo: expectedNewWeight)
]
