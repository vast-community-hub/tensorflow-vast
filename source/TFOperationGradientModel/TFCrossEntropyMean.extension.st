Extension {
	#name : 'TFCrossEntropyMean'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFCrossEntropyMean >> partialDerivativeWithRespectTo: aVariable [

	^crossEntropy partialDerivativeWithRespectTo: aVariable product: self backpropagatedGradient
]
