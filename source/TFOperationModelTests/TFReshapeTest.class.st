Class {
	#name : 'TFReshapeTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
TFReshapeTest >> testOperationName [

	| tensor newShape |

	tensor := tf integerConstantWith: #((1 3) (3 2)).
	newShape := tf integerConstantWith: #(4).

	self assert: (TFReshape of: tensor to: newShape) isNamedInGraphAs: 'Reshape'.
	self assert: (TFReshape of: tensor to: newShape) isNamedInGraphAs: 'Reshape_1'.
	self assert: (TFReshape named: 'output' of: tensor to: newShape) isNamedInGraphAs: 'output'.
	self assert: (TFReshape named: 'output' of: tensor to: newShape) isNamedInGraphAs: 'output_1'
]

{ #category : 'Test' }
TFReshapeTest >> testReshapeFailsWhenDimensionsDoesntMatch [

	| tensor newShape |

	tensor := tf integerConstantWith: #(1 3 3 2).
	newShape := tf integerConstantWith: #(2 1).

	self
		assert: [TFReshape named: 'reshape' of: tensor to: newShape]
		raisesExceptionWith:
			'INVALID_ARGUMENT: Cannot reshape a tensor with 4 elements to shape [2,1] (2 elements) for ''reshape'' (op: ''Reshape'') with input shapes: [4], [2] and with input tensors computed as partial shapes: input[1] = [2,1].'
]

{ #category : 'Test' }
TFReshapeTest >> testReshapeMatrixToVector [

	| tensor newShape |

	tensor := tf integerConstantWith: #((1 3) (3 2)).
	newShape := tf integerConstantWith: #(4).
	
	self assertOutputOf: (tensor reshapeTo: newShape) isIntegerVectorEqualsTo: #(1 3 3 2)
]

{ #category : 'Test' }
TFReshapeTest >> testReshapeVectorToHorizontalVector [

	| tensor newShape |

	tensor := tf integerConstantWith: #(1 3 3 2).
	newShape := tf integerConstantWith: #(4 1).
	
	self
		assertOutputOf: (tensor reshapeTo: newShape)
		isIntegerMatrixCloseTo: #((1) (3) (3) (2))
]

{ #category : 'Test' }
TFReshapeTest >> testReshapeVectorToMatrix [

	| tensor newShape |

	tensor := tf integerConstantWith: #(1 3 3 2).
	newShape := tf integerConstantWith: #(2 2).
	
	self assertOutputOf: (tensor reshapeTo: newShape) isIntegerMatrixCloseTo: #((1 3) (3 2))
]
