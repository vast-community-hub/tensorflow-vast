Class {
	#name : 'DiagonalSetterTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFTensorModifierModelTests'
}

{ #category : 'Test' }
DiagonalSetterTest >> testSettingDiagonal [

	| input result |

	input := ConstantNode on: tf shaped: #(3 3) filledWith: 0.0.
	result := DiagonalSetter like: input withElementsInDiagonal: #(1 2 3) asFloatTensor.

	self assertOutputOf: result isMatrixCloseTo: #((1 0 0) (0 2 0) (0 0 3))
]
