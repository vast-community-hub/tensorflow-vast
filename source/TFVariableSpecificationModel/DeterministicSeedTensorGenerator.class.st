Class {
	#name : 'DeterministicSeedTensorGenerator',
	#superclass : 'PseudorandomTensorGenerator',
	#instVars : [
		'seed'
	],
	#category : 'TFVariableSpecificationModel'
}

{ #category : 'Instance Creation' }
DeterministicSeedTensorGenerator class >> fixedTo: anIntegerSeed [

	^self new initializeFixedTo: anIntegerSeed
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
DeterministicSeedTensorGenerator >> binomialTensorOn: aComputation shaped: aTensorShape withProbabilityOfSuccess: aProbabilityOfSuccess in: aNumberOfExperiments [

	^aComputation
		newOperationOf: 'StatelessRandomBinomial'
		namePrefixed: 'StatelessRandomBinomial'
		withAll:
			{ aTensorShape asInt32Tensor. { seed. 0 } asInt32Tensor.
			aNumberOfExperiments asFloatTensor. aProbabilityOfSuccess asFloatTensor }
		describedBy: [:description | description atDataTypePut: FloatDataType new]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
DeterministicSeedTensorGenerator >> initializeFixedTo: anIntegerSeed [

	seed := anIntegerSeed
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
DeterministicSeedTensorGenerator >> truncatedNormalTensorOn: aComputation shaped: aTensorShape [

	^aComputation
		newOperationOf: 'StatelessTruncatedNormal'
		namePrefixed: 'StatelessTruncatedNormal'
		withAll: { aTensorShape asInt32Tensor. { seed. 0 } asInt32Tensor }
		describedBy: [:description | description atDataTypePut: FloatDataType new]
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
DeterministicSeedTensorGenerator >> uniformTensorOn: aComputation shaped: aTensorShape [

	^aComputation
		newOperationOf: 'StatelessRandomUniform'
		namePrefixed: 'StatelessRandomUniform'
		withAll: { aTensorShape asInt32Tensor. { seed. 0 } asInt32Tensor }
		describedBy: [:description | description atDataTypePut: FloatDataType new]
]
