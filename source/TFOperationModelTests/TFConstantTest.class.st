Class {
	#name : 'TFConstantTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
TFConstantTest >> testFromFloatScalar [

	| const |

	const := TFConstant on: tf with: 1 asFloatTensor.

	self assertOutputOf: const isFloatScalarCloseTo: 1.

	self assert: const operationName equals: 'Const'
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

{ #category : 'Test' }
TFConstantTest >> testIndentityConstant [

	| eye eye1 |

	eye := TFConstant identityMatrixOn: tf named: 'eye' rows: 2 columns: 3.
	eye1 := TFConstant identityMatrixOn: tf named: 'eye1' rows: 4 columns: 1.

	self assertOutputOf: eye isMatrixCloseTo: #((1 0 0) (0 1 0)).
	self assertOutputOf: eye1 isMatrixCloseTo: #((1) (0) (0) (0))
]

{ #category : 'Test' }
TFConstantTest >> testOperationName [

	self assert: (TFConstant on: tf with: 1 asTensor) isNamedInGraphAs: 'Const'.
	self assert: (TFConstant on: tf with: 1 asTensor) isNamedInGraphAs: 'Const_1'.
	self assert: (TFConstant on: tf named: 'var' with: 1 asTensor) isNamedInGraphAs: 'var'.
	self assert: (TFConstant on: tf named: 'var' with: 1 asTensor) isNamedInGraphAs: 'var_1'
]

{ #category : 'Test' }
TFConstantTest >> testPrintString [

	self assert: (TFConstant on: tf with: 1 asTensor) printString equals: 'Const'.
	self assert: (TFConstant on: tf with: 1 asTensor) printString equals: 'Const_1'
]
