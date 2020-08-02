Class {
	#name : 'TFMatrixInverseTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
TFMatrixInverseTest >> testOperationName [

	| input |

	input := tf constantWith: #((1)) asFloatTensor.

	self assert: (TFMatrixInverse of: input) isNamedInGraphAs: 'MatrixInverse'.
	self assert: (TFMatrixInverse of: input) isNamedInGraphAs: 'MatrixInverse_1'.
	self assert: (TFMatrixInverse named: 'output' of: input) isNamedInGraphAs: 'output'.
	self assert: (TFMatrixInverse named: 'output' of: input) isNamedInGraphAs: 'output_1'
]
