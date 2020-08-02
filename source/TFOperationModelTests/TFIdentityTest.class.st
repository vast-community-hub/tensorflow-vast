Class {
	#name : 'TFIdentityTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
TFIdentityTest >> testOperationName [

	| input |

	input := tf constantWith: 3 asTensor.

	self
		assert: (TFIdentity of: input evaluatedOnlyAfter: #()) isNamedInGraphAs: 'Identity';
		assert: (TFIdentity of: input evaluatedOnlyAfter: #()) isNamedInGraphAs: 'Identity_1';
		assert: (TFIdentity named: 'output' of: input evaluatedOnlyAfter: #())
			isNamedInGraphAs: 'output';
		assert: (TFIdentity named: 'output' of: input evaluatedOnlyAfter: #())
			isNamedInGraphAs: 'output_1'
]
