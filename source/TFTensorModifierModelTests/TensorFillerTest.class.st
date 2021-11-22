Class {
	#name : 'TensorFillerTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFTensorModifierModelTests'
}

{ #category : 'Test' }
TensorFillerTest >> testFillConstant [

	| const1 const2 |

	const1 := TensorFiller on: tf fillWith: 4 tensorShaped: #(2 4) andType: FloatDataType new.
	const2 :=
		TensorFiller fillWith: 1.0 tensorShaped: (ConstantNode on: tf with: #(3 2) asInt32Tensor).

	self assertOutputOf: const1 isMatrixCloseTo: #((4 4 4 4) (4 4 4 4)).
	self assertOutputOf: const2 isMatrixCloseTo: #((1 1) (1 1) (1 1))
]
