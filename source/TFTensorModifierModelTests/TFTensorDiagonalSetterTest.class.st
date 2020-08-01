Class {
	#name : 'TFTensorDiagonalSetterTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFTensorModifierModelTests'
}

{ #category : 'Not categorized' }
TFTensorDiagonalSetterTest >> testSettingDiagonal [

	| input result |

	input := TFConstant on: tf shaped: #(3 3) filledWith: 0.0.
	result := TFDiagonalSetter like: input withElementsInDiagonal: #(1 2 3) asFloatTensor.

	self assertOutputOf: result isMatrixCloseTo: #((1 0 0) (0 2 0) (0 0 3))
]
