Extension {
	#name : 'TFSigmoidActivationTest'
}

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFSigmoidActivationTest >> testGradientWithRespectToVectorInput [

	| input sigmoid |

	input := tf variableNamed: 'input' with: #(5 -4) asFloatTensor.

	sigmoid := TFSigmoidActivation activating: input.

	self
		assertPartialDerivativeOf: sigmoid
		withRespectTo: input
		isVectorCloseTo: (
			OrderedCollection new
				add: (self sigmoidAppliedTo: 5) * (1 - (self sigmoidAppliedTo: 5));
				add: (self sigmoidAppliedTo: -4) * (1 - (self sigmoidAppliedTo: -4));
				yourself)
]
