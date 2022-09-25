Class {
	#name : 'TileTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TensorFlowOperationExperimentalModelTests'
}

{ #category : 'Test' }
TileTest >> test1 [

	| input multiples |

	input := tf constantWith: #((1 2 3) (4 5 6)) asInt32Tensor.
	multiples := tf constantWith: #(1 2) asInt32Tensor.

	self
		assertOutputOf: (Tile replicating: input by: multiples)
		isIntegerMatrixCloseTo: #((1 2 3 1 2 3) (4 5 6 4 5 6))
]

{ #category : 'Test' }
TileTest >> test2 [

	| input multiples |

	input := tf constantWith: #((1 2 3) (4 5 6)) asInt32Tensor.
	multiples := tf constantWith: #(2 1) asInt32Tensor.

	self
		assertOutputOf: (Tile replicating: input by: multiples)
		isIntegerMatrixCloseTo: #((1 2 3) (4 5 6) (1 2 3) (4 5 6))
]

{ #category : 'Test' }
TileTest >> test3 [

	| input multiples |

	input := tf constantWith: #((1 2 3) (4 5 6)) asInt32Tensor.
	multiples := tf constantWith: #(2 2) asInt32Tensor.

	self
		assertOutputOf: (Tile replicating: input by: multiples)
		isIntegerMatrixCloseTo: #((1 2 3 1 2 3) (4 5 6 4 5 6) (1 2 3 1 2 3) (4 5 6 4 5 6))
]

{ #category : 'Test' }
TileTest >> testOperationName [

	| input multiples |

	input := tf constantWith: #((1 2 3) (4 5 6)) asInt32Tensor.
	multiples := tf constantWith: #(1 2) asInt32Tensor.

	self
		assert: (Tile replicating: input by: multiples) isNamedInGraphAs: 'Tile';
		assert: (Tile replicating: input by: multiples) isNamedInGraphAs: 'Tile_1';
		assert: (Tile named: 'output' replicating: input by: multiples) isNamedInGraphAs: 'output';
		assert: (Tile named: 'output' replicating: input by: multiples)
			isNamedInGraphAs: 'output_1'
]
