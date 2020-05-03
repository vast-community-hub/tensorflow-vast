Class {
	#name : 'TFConstantTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
TFConstantTest >> testFromFloatScalar [

	| const |

	const := TFConstant on: tf with: 1 asFloatTensor.

	self assertOutputOf: const isFloatScalarCloseTo: 1
]

{ #category : 'Test' }
TFConstantTest >> testFromFloatVector [

	| const |

	const := TFConstant on: tf with: #(1 2) asFloatTensor.

	self assertOutputOf: const isFloatVectorCloseTo: #(1 2)
]

{ #category : 'Test' }
TFConstantTest >> testFromIntScalar [

	| const |

	const := TFConstant on: tf with: 1 asInt32Tensor.

	self assertOutputOf: const isIntegerScalarEqualTo: 1
]

{ #category : 'Test' }
TFConstantTest >> testFromIntVector [

	| const |

	const := TFConstant on: tf with: #(2 1) asInt32Tensor.

	self assertOutputOf: const isIntegerVectorEqualsTo: #(2 1)
]

{ #category : 'Test' }
TFConstantTest >> testFromShapeFilledWithFloatValue [

	| const |

	const := TFConstant on: tf shaped: #(2 2) filledWith: 2 asFloat.

	self assertOutputOf: const isMatrixCloseTo: #((2 2) (2 2))
]

{ #category : 'Test' }
TFConstantTest >> testFromShapeFilledWithIntValue [

	| const |

	const := TFConstant on: tf shaped: #(2 1) filledWith: 0 asInt32Tensor.

	self assertOutputOf: const isIntegerMatrixCloseTo: #((0) (0))
]
