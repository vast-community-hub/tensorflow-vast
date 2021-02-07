Class {
	#name : 'CurrentEpochHolder',
	#superclass : 'Object',
	#instVars : [
		'currentComputation',
		'epochValue',
		'epochVariable',
		'incrementEpoch'
	],
	#category : 'MLTrainingModel'
}

{ #category : 'Instance Creation' }
CurrentEpochHolder class >> on: aTensorFlowComputation [

	^self new initializeOn: aTensorFlowComputation
]

{ #category : 'Converting' }
CurrentEpochHolder >> asVariable [

	^epochVariable
]

{ #category : 'Initialization' }
CurrentEpochHolder >> increment [

	epochValue := epochValue + 1.
	currentComputation compute: incrementEpoch
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
CurrentEpochHolder >> initializeOn: aTensorFlowComputation [

	currentComputation := aTensorFlowComputation.
	epochValue := 0.
	epochVariable := VariableNode on: currentComputation named: 'currentEpoch' with: 1 asInt64Tensor.
	incrementEpoch := epochVariable += 1 asInt64Tensor
]

{ #category : 'Initialization' }
CurrentEpochHolder >> value [

	^epochValue
]
