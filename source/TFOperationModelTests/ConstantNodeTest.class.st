Class {
	#name : 'ConstantNodeTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
ConstantNodeTest >> testFromFloatScalar [

	| const |

	const := ConstantNode on: tf with: 1 asFloatTensor.

	self assertOutputOf: const isFloatScalarCloseTo: 1.

	self assert: const operationName equals: 'Const'
]

{ #category : 'Test' }
ConstantNodeTest >> testFromFloatVector [

	| const |

	const := ConstantNode on: tf with: #(1 2) asFloatTensor.

	self assertOutputOf: const isFloatVectorCloseTo: #(1 2)
]

{ #category : 'Test' }
ConstantNodeTest >> testFromIntScalar [

	| const |

	const := ConstantNode on: tf with: 1 asInt32Tensor.

	self assertOutputOf: const isIntegerScalarEqualTo: 1
]

{ #category : 'Test' }
ConstantNodeTest >> testFromIntVector [

	| const |

	const := ConstantNode on: tf with: #(2 1) asInt32Tensor.

	self assertOutputOf: const isIntegerVectorEqualsTo: #(2 1)
]

{ #category : 'Test' }
ConstantNodeTest >> testFromShapeFilledWithFloatValue [

	| const |

	const := ConstantNode on: tf shaped: #(2 2) filledWith: 2 asFloat.

	self assertOutputOf: const isMatrixCloseTo: #((2 2) (2 2))
]

{ #category : 'Test' }
ConstantNodeTest >> testFromShapeFilledWithIntValue [

	| const |

	const := ConstantNode on: tf shaped: #(2 1) filledWith: 0 asInt32Tensor.

	self assertOutputOf: const isIntegerMatrixCloseTo: #((0) (0))
]

{ #category : 'Test' }
ConstantNodeTest >> testIndentityConstant [

	| eye eye1 |

	eye := ConstantNode identityMatrixOn: tf named: 'eye' rows: 2 columns: 3.
	eye1 := ConstantNode identityMatrixOn: tf named: 'eye1' rows: 4 columns: 1.

	self assertOutputOf: eye isMatrixCloseTo: #((1 0 0) (0 1 0)).
	self assertOutputOf: eye1 isMatrixCloseTo: #((1) (0) (0) (0))
]

{ #category : 'Test' }
ConstantNodeTest >> testOperationName [

	self assert: (ConstantNode on: tf with: 1 asTensor) isNamedInGraphAs: 'Const'.
	self assert: (ConstantNode on: tf with: 1 asTensor) isNamedInGraphAs: 'Const_1'.
	self assert: (ConstantNode on: tf named: 'var' with: 1 asTensor) isNamedInGraphAs: 'var'.
	self assert: (ConstantNode on: tf named: 'var' with: 1 asTensor) isNamedInGraphAs: 'var_1'
]

{ #category : 'Test' }
ConstantNodeTest >> testPrintString [

	self assert: (ConstantNode on: tf with: 1 asTensor) printString equals: 'Const'.
	self assert: (ConstantNode on: tf with: 1 asTensor) printString equals: 'Const_1'
]
