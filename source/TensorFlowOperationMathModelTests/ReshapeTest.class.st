Class {
	#name : 'ReshapeTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TensorFlowOperationMathModelTests'
}

{ #category : 'Test' }
ReshapeTest >> testOperationName [

	| tensor newShape |

	tensor := tf integerConstantWith: #((1 3) (3 2)).
	newShape := TensorShape vectorSized: 4.

	self assert: (Reshape of: tensor to: newShape) isNamedInGraphAs: 'Reshape'.
	self assert: (Reshape of: tensor to: newShape) isNamedInGraphAs: 'Reshape_1'.
	self assert: (Reshape named: 'output' of: tensor to: newShape) isNamedInGraphAs: 'output'.
	self assert: (Reshape named: 'output' of: tensor to: newShape) isNamedInGraphAs: 'output_1'
]

{ #category : 'Test' }
ReshapeTest >> testReshapeFailsWhenDimensionsDoesntMatch [

	| tensor newShape |

	tensor := tf integerConstantWith: #(1 3 3 2).
	newShape := TensorShape matrixSized: 2 by: 1.

	self
		assert: [Reshape named: 'reshape' of: tensor to: newShape]
		raisesExceptionWith:
			'INVALID_ARGUMENT: Cannot reshape a tensor with 4 elements to shape [2,1] (2 elements) for ''{{node reshape}} = Reshape[T=DT_INT32, Tshape=DT_INT32](Const, Const_1)'' with input shapes: [4], [2] and with input tensors computed as partial shapes: input[1] = [2,1].'
]

{ #category : 'Test' }
ReshapeTest >> testReshapeMatrixToVector [

	| tensor newShape |

	tensor := tf integerConstantWith: #((1 3) (3 2)).
	newShape := TensorShape vectorSized: 4.

	self assertOutputOf: (tensor reshapeTo: newShape) isIntegerVectorEqualsTo: #(1 3 3 2)
]

{ #category : 'Test' }
ReshapeTest >> testReshapeVectorToHorizontalVector [

	| tensor newShape |

	tensor := tf integerConstantWith: #(1 3 3 2).
	newShape := TensorShape matrixSized: 4 by: 1.

	self assertOutputOf: (tensor reshapeTo: newShape) isIntegerMatrixCloseTo: #((1) (3) (3) (2))
]

{ #category : 'Test' }
ReshapeTest >> testReshapeVectorToMatrix [

	| tensor newShape |

	tensor := tf integerConstantWith: #(1 3 3 2).
	newShape := TensorShape matrixSized: 2 by: 2.

	self assertOutputOf: (tensor reshapeTo: newShape) isIntegerMatrixCloseTo: #((1 3) (3 2))
]
