Class {
	#name : 'MatrixInverseTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TensorFlowOperationMathModelTests'
}

{ #category : 'Test' }
MatrixInverseTest >> testOperationName [

	| input |

	input := tf constantWith: #((1)) asFloatTensor.

	self assert: (MatrixInverse of: input) isNamedInGraphAs: 'MatrixInverse'.
	self assert: (MatrixInverse of: input) isNamedInGraphAs: 'MatrixInverse_1'.
	self assert: (MatrixInverse named: 'output' of: input) isNamedInGraphAs: 'output'.
	self assert: (MatrixInverse named: 'output' of: input) isNamedInGraphAs: 'output_1'
]
