Class {
	#name : 'OneHotTensorTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TensorFlowOperationMathModelTests'
}

{ #category : 'Test' }
OneHotTensorTest >> testOperationName [

	| input |

	input := tf constantWith: #(0 1 2) asInt32Tensor.

	self assert: (OneHotTensor transforming: input toDepth: 3 asInt32Tensor) isNamedInGraphAs: 'OneHot'.
	self assert: (OneHotTensor transforming: input toDepth: 3 asInt32Tensor) isNamedInGraphAs: 'OneHot_1'
]

{ #category : 'Test' }
OneHotTensorTest >> testTransforming3ElementVector [

	| input oneHot |

	input := tf integerConstantWith: #(0 1 2).
	oneHot := OneHotTensor transforming: input toDepth: 3 asInt32Tensor.

	self
		assertOutputOf: oneHot
		isIntegerMatrixCloseTo: (
			OrderedCollection new
				add: #(1 0 0);
				add: #(0 1 0);
				add: #(0 0 1);
				yourself)
]
