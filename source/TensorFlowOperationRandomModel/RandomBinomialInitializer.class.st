Class {
	#name : 'RandomBinomialInitializer',
	#superclass : 'VariableTensorInitializer',
	#instVars : [
		'tensorGenerator',
		'successProbability',
		'numberOfExperiments'
	],
	#category : 'TensorFlowOperationRandomModel'
}

{ #category : 'Instance Creation' }
RandomBinomialInitializer class >> new [

	^self withProbabilityOfSuccess: 0.5 in: 1 with: RandomSeedTensorGenerator new
]

{ #category : 'Instance Creation' }
RandomBinomialInitializer class >> withProbabilityOfSuccess: aProbabilityOfSuccess in: aNumberOfExperiments [

	^self
		withProbabilityOfSuccess: aProbabilityOfSuccess
		in: aNumberOfExperiments
		with: RandomSeedTensorGenerator new
]

{ #category : 'Instance Creation' }
RandomBinomialInitializer class >> withProbabilityOfSuccess: aProbabilityOfSuccess in: aNumberOfExperiments with: aRandomTensorGenerator [

	^super new
		initializeWithProbabilityOfSuccess: aProbabilityOfSuccess
		in: aNumberOfExperiments
		with: aRandomTensorGenerator
]

{ #category : 'Instance Creation' }
RandomBinomialInitializer class >> withProbabilityOfSuccess: aProbabilityOfSuccess in: aNumberOfExperiments withSeed: anIntegerSeed [

	^self
		withProbabilityOfSuccess: aProbabilityOfSuccess
		in: aNumberOfExperiments
		with: (DeterministicSeedTensorGenerator fixedTo: anIntegerSeed)
]

{ #category : 'Instance Creation' }
RandomBinomialInitializer class >> withSeed: anIntegerSeed [

	^self
		withProbabilityOfSuccess: 0.5
		in: 1
		with: (DeterministicSeedTensorGenerator fixedTo: anIntegerSeed)
]

{ #category : 'Applying' }
RandomBinomialInitializer >> applyTo: aVariableTensor [

	aVariableTensor assign: (
		tensorGenerator
			binomialTensorOn: aVariableTensor currentComputation
			shaped: aVariableTensor outputShape
			withProbabilityOfSuccess: successProbability
			in: numberOfExperiments)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
RandomBinomialInitializer >> initializeWithProbabilityOfSuccess: aProbabilityOfSuccess in: aNumberOfExperiments with: aRandomTensorGenerator [

	tensorGenerator := aRandomTensorGenerator.
	successProbability := aProbabilityOfSuccess.
	numberOfExperiments := aNumberOfExperiments
]
