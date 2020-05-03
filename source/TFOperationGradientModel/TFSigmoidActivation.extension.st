Extension {
	#name : 'TFSigmoidActivation'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFSigmoidActivation >> derivativeWithRespectTo: aVariable [

	aVariable = neuron
		ifTrue: [
			^TFSigmoidGradient
				considering: self
				andGradientsOfInputs: (TFConstant like: self filledWith: 1)].

	self raiseIsNotDifferentiableRespectTo: aVariable
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Accessing'] }
TFSigmoidActivation >> inputsDo: aBlock [

	aBlock value: neuron
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFSigmoidActivation >> partialDerivativeWithRespectTo: aVariable [

	^TFSigmoidGradient
		considering: self
		andGradientsOfInputs: (neuron partialDerivativeWithRespectTo: aVariable)
]
