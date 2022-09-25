Extension {
	#name : 'CrossEntropyMean'
}

{ #category : '*TensorFlowOperationGradientModel',
 #vaCategories : ['Gradients'] }
CrossEntropyMean >> partialDerivativeWithRespectTo: aVariable [

	^crossEntropy partialDerivativeWithRespectTo: aVariable product: self backpropagatedGradient
]
