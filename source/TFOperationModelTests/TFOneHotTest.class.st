Class {
	#name : 'TFOneHotTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
TFOneHotTest >> testOperationName [

	| input |

	input := tf constantWith: #(0 1 2) asInt32Tensor.

	self assert: (TFOneHot transforming: input toDepth: 3 asInt32Tensor) isNamedInGraphAs: 'OneHot'.
	self assert: (TFOneHot transforming: input toDepth: 3 asInt32Tensor) isNamedInGraphAs: 'OneHot_1'
]

{ #category : 'Test' }
TFOneHotTest >> testTransforming3ElementVector [

	| input oneHot |

	input := tf integerConstantWith: #(0 1 2).
	oneHot := TFOneHot transforming: input toDepth: 3 asInt32Tensor.

	self
		assertOutputOf: oneHot
		isIntegerMatrixCloseTo: (
			OrderedCollection new
				add: #(1 0 0);
				add: #(0 1 0);
				add: #(0 0 1);
				yourself)
]
