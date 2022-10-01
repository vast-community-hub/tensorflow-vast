Class {
	#name : 'CurrentEpochHolder',
	#superclass : 'Object',
	#instVars : [
		'currentComputation',
		'epochValue',
		'epochVariable',
		'incrementEpoch',
		'trainingStepVariable',
		'incrementTrainingStep'
	],
	#category : 'NeuralNetworkTrainingModel'
}

{ #category : 'Instance Creation' }
CurrentEpochHolder class >> on: aTensorFlowComputation [

	^self new initializeOn: aTensorFlowComputation
]

{ #category : 'Accessing' }
CurrentEpochHolder >> asVariable [

	^epochVariable
]

{ #category : 'Incrementing' }
CurrentEpochHolder >> increment [

	currentComputation compute: incrementEpoch
]

{ #category : 'Incrementing' }
CurrentEpochHolder >> incrementTrainingStep [

	currentComputation compute: incrementTrainingStep
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
CurrentEpochHolder >> initializeOn: aTensorFlowComputation [

	currentComputation := aTensorFlowComputation.
	epochVariable := VariableTensor on: currentComputation named: 'currentEpoch' with: 1 asInt64Tensor.
	incrementEpoch := epochVariable += 1 asInt64Tensor.

	trainingStepVariable :=
		VariableTensor on: currentComputation named: 'trainingStep' with: 1 asInt64Tensor.
	incrementTrainingStep := trainingStepVariable += 1 asInt64Tensor
]

{ #category : 'Printing' }
CurrentEpochHolder >> printOn: aStream [

	aStream nextPutAll: ('Epoch: <1p>' expandMacrosWith: self value)
]

{ #category : 'Accessing' }
CurrentEpochHolder >> trainingStepAsVariable [

	^trainingStepVariable
]

{ #category : 'Accessing' }
CurrentEpochHolder >> trainingStepValue [

	^(currentComputation compute: self trainingStepAsVariable) scalarOutput
]

{ #category : 'Accessing' }
CurrentEpochHolder >> value [

	^(currentComputation compute: self asVariable) scalarOutput
]
