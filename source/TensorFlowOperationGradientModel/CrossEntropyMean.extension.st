Extension {
	#name : 'CrossEntropyMean'
}

{ #category : 'Gradients' }
CrossEntropyMean >> partialDerivativeWithRespectTo: aVariable [

	^crossEntropy partialDerivativeWithRespectTo: aVariable product: self backpropagatedGradient
]
