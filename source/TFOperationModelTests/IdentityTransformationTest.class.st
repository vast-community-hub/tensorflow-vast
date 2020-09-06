Class {
	#name : 'IdentityTransformationTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
IdentityTransformationTest >> testOperationName [

	| input |

	input := tf constantWith: 3 asTensor.

	self
		assert: (IdentityTransformation of: input evaluatedOnlyAfter: #())
			isNamedInGraphAs: 'Identity';
		assert: (IdentityTransformation of: input evaluatedOnlyAfter: #())
			isNamedInGraphAs: 'Identity_1';
		assert: (IdentityTransformation named: 'output' of: input evaluatedOnlyAfter: #())
			isNamedInGraphAs: 'output';
		assert: (IdentityTransformation named: 'output' of: input evaluatedOnlyAfter: #())
			isNamedInGraphAs: 'output_1'
]
