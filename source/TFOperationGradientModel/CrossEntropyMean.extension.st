Extension {
	#name : 'CrossEntropyMean'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
CrossEntropyMean >> partialDerivativeWithRespectTo: aVariable [

	^crossEntropy partialDerivativeWithRespectTo: aVariable product: self backpropagatedGradient
]
