Class {
	#name : 'CurrentEpochHolderTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'NeuralNetworkTrainingModelTests'
}

{ #category : 'Test' }
CurrentEpochHolderTest >> testIncrementEpoch [

	| epoch | 
	
	epoch := CurrentEpochHolder on: tf. 
	
	self assert: epoch value equals: 1.
	
	epoch increment. 
	
	self assert: epoch value equals: 2.
	
]

{ #category : 'Test' }
CurrentEpochHolderTest >> testIncrementStep [

	| epoch | 
	
	epoch := CurrentEpochHolder on: tf. 
	
	self assert: (tf compute: epoch trainingStepAsVariable) isLargeIntegerScalarEqualsTo: 1.
	
	epoch incrementTrainingStep. 
	
	self assert: (tf compute: epoch trainingStepAsVariable) isLargeIntegerScalarEqualsTo: 2.
]
