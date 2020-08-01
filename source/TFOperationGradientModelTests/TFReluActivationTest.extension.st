Extension {
	#name : 'TFReluActivationTest'
}

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFReluActivationTest >> testDerivativeWithRespectToAnInvalidInput [

	| negativeScalar positiveScalar |

	negativeScalar := tf constantWith: -1.5.
	positiveScalar := tf constantWith: 4.0.

	self
		assert: (TFReluActivation activating: negativeScalar)
		isNotDifferentiableRespectTo: positiveScalar
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFReluActivationTest >> testGradientOfReluOfFloatScalar [

	| negativeScalar positiveScalar |

	negativeScalar := tf constantWith: -1.5.
	positiveScalar := tf constantWith: 4.0.

	self
		assertPartialDerivativeOf: (TFReluActivation activating: negativeScalar)
			withRespectTo: negativeScalar
			isCloseTo: 0;
		assertPartialDerivativeOf: (TFReluActivation activating: positiveScalar)
			withRespectTo: positiveScalar
			isCloseTo: 1
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFReluActivationTest >> testGradientOfReluOfFloatVector [

	| input relu |

	input := tf variableNamed: 'input' with: #(-1 4 -0.4 5) asFloatTensor.

	relu := TFReluActivation activating: input.

	self assertPartialDerivativeOf: relu withRespectTo: input isVectorCloseTo: #(0 1 0 1)
]
