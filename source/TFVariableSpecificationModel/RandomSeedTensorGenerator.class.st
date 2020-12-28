Class {
	#name : 'RandomSeedTensorGenerator',
	#superclass : 'PseudorandomTensorGenerator',
	#category : 'TFVariableSpecificationModel'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
RandomSeedTensorGenerator >> truncatedNormalTensorOn: aGraph shaped: aTensorShape [

	| shape |

	shape := aGraph const: aTensorShape dimensionSizes asInt32Tensor.
	
	^shape
		unaryOp: 'TruncatedNormal'
		described: [:description | description atDataTypePut: TFTensor typeFloat]
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
RandomSeedTensorGenerator >> uniformTensorOn: aGraph shaped: aTensorShape [

	| shape |

	shape := aGraph const: aTensorShape dimensionSizes asInt32Tensor.
	
	^shape
		unaryOp: 'RandomUniform'
		described: [:description | description atDataTypePut: TFTensor typeFloat]
]
