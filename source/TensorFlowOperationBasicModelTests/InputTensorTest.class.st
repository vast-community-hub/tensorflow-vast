Class {
	#name : 'InputTensorTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TensorFlowOperationBasicModelTests'
}

{ #category : 'Tests' }
InputTensorTest >> testOutputAttributesOfPartiallyUndefinedShapedInput [

	| input |

	input := InputTensor
		on: tf
		named: 'inputWithSize'
		of: FloatDataType new
		sized: 2.
	
	self assert: input value firstOutput rank equals: 2. 
	self assert: input outputShape equals: ( TensorShape unknownBatchSizeWith: 2 ).
	self assert: input outputDimensions equals: 2
]

{ #category : 'Tests' }
InputTensorTest >> testOutputAttributesOfUndefinedShapedInput [

	| input |

	input := InputTensor on: tf named: 'input' of: FloatDataType new.

	self assert: input value firstOutput rank equals: -1. 
	self assert: input outputShape equals: TensorShape scalar.
	self assert: input outputDimensions equals: -1
]
