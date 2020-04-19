Extension {
	#name : 'TFTanhActivation'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFTanhActivation >> partialDerivativeWithRespectTo: aVariable [

	^TFTanhGradient
		considering: self
		andGradientsOfInputs: (neuron partialDerivativeWithRespectTo: aVariable)
]
