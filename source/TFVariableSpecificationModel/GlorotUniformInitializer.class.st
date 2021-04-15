Class {
	#name : 'GlorotUniformInitializer',
	#superclass : 'VariableNodeInitializer',
	#instVars : [
		'tensorGenerator'
	],
	#category : 'TFVariableSpecificationModel'
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
GlorotUniformInitializer >> applyTo: aVariableNode [


	aVariableNode assign: (
		tensorGenerator
			glorotUniformTensorOn: aVariableNode currentComputation
			shaped: aVariableNode outputShape)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
GlorotUniformInitializer >> initializeGeneratingTensorWith: aRandomTensorGenerator [

	tensorGenerator := aRandomTensorGenerator
]
