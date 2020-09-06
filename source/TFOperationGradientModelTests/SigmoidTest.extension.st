Extension {
	#name : 'SigmoidTest'
}

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
SigmoidTest >> testGradientWithRespectToScalarInput [

	| input sigmoid |

	input := tf variableNamed: 'input' with: -4.0 asFloatTensor.

	sigmoid := Sigmoid activating: input.

	self
		assertPartialDerivativeOf: sigmoid
		withRespectTo: input
		isCloseTo: (self sigmoidAppliedTo: -4) * (1 - (self sigmoidAppliedTo: -4))
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
SigmoidTest >> testGradientWithRespectToVectorInput [

	| input sigmoid |

	input := tf variableNamed: 'input' with: #(5 -4) asFloatTensor.

	sigmoid := Sigmoid activating: input.

	self
		assertPartialDerivativeOf: sigmoid
		withRespectTo: input
		isVectorCloseTo: (
			OrderedCollection new
				add: (self sigmoidAppliedTo: 5) * (1 - (self sigmoidAppliedTo: 5));
				add: (self sigmoidAppliedTo: -4) * (1 - (self sigmoidAppliedTo: -4));
				yourself)
]
