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
GlorotUniformInitializer >> applyTo: aTFVariable [

	aTFVariable assign: (
		tensorGenerator
			glorotUniformTensorOn: aTFVariable graph
			shaped: aTFVariable outputShape)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
GlorotUniformInitializer >> initializeGeneratingTensorWith: aRandomTensorGenerator [

	tensorGenerator := aRandomTensorGenerator
]
