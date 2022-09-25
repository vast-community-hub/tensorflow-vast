Extension {
	#name : 'ReLUTest'
}

{ #category : '*TensorFlowOperationGradientModelTests',
 #vaCategories : ['Test'] }
ReLUTest >> testDerivativeWithRespectToAnInvalidInput [

	| negativeScalar positiveScalar |

	negativeScalar := tf constantWith: -1.5.
	positiveScalar := tf constantWith: 4.0.

	self
		assert: (ReLU activating: negativeScalar)
		isNotDifferentiableRespectTo: positiveScalar
]

{ #category : '*TensorFlowOperationGradientModelTests',
 #vaCategories : ['Test'] }
ReLUTest >> testGradientOfReluOfFloatScalar [

	| negativeScalar positiveScalar |

	negativeScalar := tf constantWith: -1.5.
	positiveScalar := tf constantWith: 4.0.

	self
		assertPartialDerivativeOf: (ReLU activating: negativeScalar)
			withRespectTo: negativeScalar
			isCloseTo: 0;
		assertPartialDerivativeOf: (ReLU activating: positiveScalar)
			withRespectTo: positiveScalar
			isCloseTo: 1
]

{ #category : '*TensorFlowOperationGradientModelTests',
 #vaCategories : ['Test'] }
ReLUTest >> testGradientOfReluOfFloatVector [

	| input relu |

	input := tf variableNamed: 'input' with: #(-1 4 -0.4 5) asFloatTensor.

	relu := ReLU activating: input.

	self assertPartialDerivativeOf: relu withRespectTo: input isVectorCloseTo: #(0 1 0 1)
]
