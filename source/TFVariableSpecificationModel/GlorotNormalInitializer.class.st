Class {
	#name : 'GlorotNormalInitializer',
	#superclass : 'VariableNodeInitializer',
	#instVars : [
		'tensorGenerator'
	],
	#category : 'TFVariableSpecificationModel'
}

{ #category : 'Instance Creation',
  #vaVisibility : 'private' }
GlorotNormalInitializer class >> generatingTensorWith: aRandomTensorGenerator [

	^super new initializeGeneratingTensorWith: aRandomTensorGenerator
]

{ #category : 'Instance Creation' }
GlorotNormalInitializer class >> new [

	^self generatingTensorWith: RandomSeedTensorGenerator new
]

{ #category : 'Instance Creation' }
GlorotNormalInitializer class >> withSeed: anIntegerSeed [

	^self generatingTensorWith: (DeterministicSeedTensorGenerator fixedTo: anIntegerSeed)
]

{ #category : 'Applying' }
GlorotNormalInitializer >> applyTo: aVariableNode [


	aVariableNode
		assign:
			( tensorGenerator
				glorotNormalTensorOn: aVariableNode currentComputation
				shaped: aVariableNode outputShape )
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
GlorotNormalInitializer >> initializeGeneratingTensorWith: aRandomTensorGenerator [

	tensorGenerator := aRandomTensorGenerator
]
