Extension {
	#name : 'TFAddBias'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFAddBias >> partialDerivativeWithRespectTo: aVariable [

	^TFAddBiasGradient withGradientsOfInputs: (addend partialDerivativeWithRespectTo: aVariable)
]
