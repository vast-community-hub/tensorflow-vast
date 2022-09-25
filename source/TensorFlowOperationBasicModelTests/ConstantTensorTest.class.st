Class {
	#name : 'ConstantTensorTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TensorFlowOperationBasicModelTests'
}

{ #category : 'Test' }
ConstantTensorTest >> testFromFloatScalar [

	| const |

	const := ConstantTensor on: tf with: 1 asFloatTensor.

	self assertOutputOf: const isFloatScalarCloseTo: 1.

	self assert: const operationName equals: 'Const'
]

{ #category : 'Test' }
ConstantTensorTest >> testFromFloatVector [

	| const |

	const := ConstantTensor on: tf with: #(1 2) asFloatTensor.

	self assertOutputOf: const isFloatVectorCloseTo: #(1 2)
]

{ #category : 'Test' }
ConstantTensorTest >> testFromIntScalar [

	| const |

	const := ConstantTensor on: tf with: 1 asInt32Tensor.

	self assertOutputOf: const isIntegerScalarEqualTo: 1
]

{ #category : 'Test' }
ConstantTensorTest >> testFromIntVector [

	| const |

	const := ConstantTensor on: tf with: #(2 1) asInt32Tensor.

	self assertOutputOf: const isIntegerVectorEqualsTo: #(2 1)
]

{ #category : 'Test' }
ConstantTensorTest >> testFromShapeFilledWithFloatValue [

	| const |

	const := ConstantTensor on: tf shaped: #(2 2) filledWith: 2 asFloat.

	self assertOutputOf: const isMatrixCloseTo: #((2 2) (2 2))
]

{ #category : 'Test' }
ConstantTensorTest >> testFromShapeFilledWithIntValue [

	| const |

	const := ConstantTensor on: tf shaped: #(2 1) filledWith: 0 asInt32Tensor.

	self assertOutputOf: const isIntegerMatrixCloseTo: #((0) (0))
]

{ #category : 'Test' }
ConstantTensorTest >> testOperationName [

	self assert: (ConstantTensor on: tf with: 1 asTensor) isNamedInGraphAs: 'Const'.
	self assert: (ConstantTensor on: tf with: 1 asTensor) isNamedInGraphAs: 'Const_1'.
	self assert: (ConstantTensor on: tf named: 'var' with: 1 asTensor) isNamedInGraphAs: 'var'.
	self assert: (ConstantTensor on: tf named: 'var' with: 1 asTensor) isNamedInGraphAs: 'var_1'
]

{ #category : 'Test' }
ConstantTensorTest >> testPrintString [

	self assert: (ConstantTensor on: tf with: 1 asTensor) printString equals: 'Const'.
	self assert: (ConstantTensor on: tf with: 1 asTensor) printString equals: 'Const_1'
]
