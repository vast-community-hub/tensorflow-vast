Class {
	#name : 'RandomSeedTensorGenerator',
	#superclass : 'PseudorandomTensorGenerator',
	#category : 'TFVariableSpecificationModel'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
RandomSeedTensorGenerator >> truncatedNormalTensorOn: aComputation shaped: aTensorShape [


	| shape |

	shape := ConstantNode on: aComputation with: aTensorShape dimensionSizes asInt32Tensor.

	^ aComputation
		newOperationOf: 'TruncatedNormal'
		namePrefixed: 'TruncatedNormal'
		withAll: ( Array with: shape )
		describedBy: [ :description | description atDataTypePut: TFTensor typeFloat ]
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
RandomSeedTensorGenerator >> uniformTensorOn: aComputation shaped: aTensorShape [


	| shape |

	shape := ConstantNode on: aComputation with: aTensorShape dimensionSizes asInt32Tensor.

	^ aComputation
		newOperationOf: 'RandomUniform'
		namePrefixed: 'RandomUniform'
		withAll: ( Array with: shape )
		describedBy: [ :description | description atDataTypePut: TFTensor typeFloat ]
]
