Class {
	#name : 'TFTileTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFTensorModifierModelTests'
}

{ #category : 'Test' }
TFTileTest >> test1 [

	| input multiples |

	input := tf constantWith: #((1 2 3) (4 5 6)) asInt32Tensor.
	multiples := tf constantWith: #(1 2) asInt32Tensor.

	self
		assertOutputOf: (TFTile replicating: input by: multiples)
		isIntegerMatrixCloseTo: #((1 2 3 1 2 3) (4 5 6 4 5 6))
]

{ #category : 'Test' }
TFTileTest >> test2 [

	| input multiples |

	input := tf constantWith: #((1 2 3) (4 5 6)) asInt32Tensor.
	multiples := tf constantWith: #(2 1) asInt32Tensor.

	self
		assertOutputOf: (TFTile replicating: input by: multiples)
		isIntegerMatrixCloseTo: #((1 2 3) (4 5 6) (1 2 3) (4 5 6))
]

{ #category : 'Test' }
TFTileTest >> test3 [

	| input multiples |

	input := tf constantWith: #((1 2 3) (4 5 6)) asInt32Tensor.
	multiples := tf constantWith: #(2 2) asInt32Tensor.

	self
		assertOutputOf: (TFTile replicating: input by: multiples)
		isIntegerMatrixCloseTo: #((1 2 3 1 2 3) (4 5 6 4 5 6) (1 2 3 1 2 3) (4 5 6 4 5 6))
]
