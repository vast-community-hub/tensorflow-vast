Class {
	#name : 'GlorotNormalInitializer',
	#superclass : 'VariableTensorInitializer',
	#instVars : [
		'tensorGenerator'
	],
	#category : 'TensorFlowOperationRandomModel'
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
GlorotNormalInitializer >> applyTo: aVariableTensor [

	aVariableTensor assign: (
		tensorGenerator
			glorotNormalTensorOn: aVariableTensor currentComputation
			shaped: aVariableTensor outputShape)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
GlorotNormalInitializer >> initializeGeneratingTensorWith: aRandomTensorGenerator [

	tensorGenerator := aRandomTensorGenerator
]
