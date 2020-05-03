Extension {
	#name : 'TFReluActivationTest'
}

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFReluActivationTest >> testGradientOfReluOfFloatVector [

	| input relu |

	input := tf variableNamed: 'input' with: #(-1 4 -0.4 5) asFloatTensor.

	relu := TFReluActivation activating: input.

	self assertPartialDerivativeOf: relu withRespectTo: input isVectorCloseTo: #(0 4 0 5)
]
