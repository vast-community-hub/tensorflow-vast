Extension {
	#name : 'TFReluActivation'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFReluActivation >> derivativeWithRespectTo: aVariable [

	aVariable = neuron
		ifTrue: [
			^TFReluGradient
				considering: self
				andGradientsOfInputs: (TFConstant like: self filledWith: 1)].

	self raiseIsNotDifferentiableRespectTo: aVariable
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Accessing'] }
TFReluActivation >> inputsDo: aBlock [

	aBlock value: neuron
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFReluActivation >> partialDerivativeWithRespectTo: aVariable [

	^TFReluGradient
		considering: self
		andGradientsOfInputs: (neuron partialDerivativeWithRespectTo: aVariable)
]
