Class {
	#name : 'GlorotUniformInitializer',
	#superclass : 'VariableTensorInitializer',
	#instVars : [
		'tensorGenerator'
	],
	#category : 'TensorFlowOperationRandomModel'
}

{ #category : 'Instance Creation',
  #vaVisibility : 'private' }
GlorotUniformInitializer class >> generatingTensorWith: aRandomTensorGenerator [

	^super new initializeGeneratingTensorWith: aRandomTensorGenerator
]

{ #category : 'Instance Creation' }
GlorotUniformInitializer class >> new [

	^self generatingTensorWith: RandomSeedTensorGenerator new
]

{ #category : 'Instance Creation' }
GlorotUniformInitializer class >> withSeed: anIntegerSeed [

	^self generatingTensorWith: (DeterministicSeedTensorGenerator fixedTo: anIntegerSeed)
]

{ #category : 'Applying' }
GlorotUniformInitializer >> applyTo: aVariableTensor [

	aVariableTensor assign: (
		tensorGenerator
			glorotUniformTensorOn: aVariableTensor currentComputation
			shaped: aVariableTensor outputShape)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
GlorotUniformInitializer >> initializeGeneratingTensorWith: aRandomTensorGenerator [

	tensorGenerator := aRandomTensorGenerator
]
