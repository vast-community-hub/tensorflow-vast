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

{ #category : 'Initialization',
  #vaVisibility : 'private' }
DeterministicSeedTensorGenerator >> initializeFixedTo: anIntegerSeed [

	seed := anIntegerSeed
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
DeterministicSeedTensorGenerator >> truncatedNormalTensorOn: aComputation shaped: aTensorShape [


	| shape seeds |

	shape := ConstantNode on: aComputation with: aTensorShape dimensionSizes asInt32Tensor.
	seeds := ConstantNode on: aComputation with: ( Array with: seed with: 0 ) asInt32Tensor.
	^ aComputation
		newOperationOf: 'StatelessTruncatedNormal'
		namePrefixed: 'StatelessTruncatedNormal'
		withAll: ( Array with: shape with: seeds )
		describedBy: [ :description | description atDataTypePut: TFTensor typeFloat ]
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
DeterministicSeedTensorGenerator >> uniformTensorOn: aComputation shaped: aTensorShape [


	| shape seeds |

	shape := ConstantNode on: aComputation with: aTensorShape dimensionSizes asInt32Tensor.
	seeds := ConstantNode on: aComputation with: (Array with: seed with: 0) asInt32Tensor.
	^ aComputation 
		newOperationOf: 'StatelessRandomUniform'
		namePrefixed: 'StatelessRandomUniform'
		withAll: (Array with: shape with: seeds)
		describedBy: [:description | description atDataTypePut: TFTensor typeFloat] 
]
