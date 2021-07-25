Class {
	#name : 'InputNodeTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Tests' }
InputNodeTest >> testOutputAttributesOfPartiallyUndefinedShapedInput [

	| input |

	input := InputNode
		on: tf
		named: 'inputWithSize'
		of: TFTensor typeFloat
		sized: 2.
	
	self assert: input value firstOutput rank equals: 2. 
	self assert: input outputShape equals: ( TensorShape unknownBatchSizeWith: 2 ).
	self assert: input outputDimensions equals: 2
]

{ #category : 'Tests' }
InputNodeTest >> testOutputAttributesOfUndefinedShapedInput [

	| input |

	input := InputNode on: tf named: 'input' of: TFTensor typeFloat.

	self assert: input value firstOutput rank equals: -1. 
	self assert: input outputShape equals: TensorShape scalar.
	self assert: input outputDimensions equals: -1
]
