Extension {
	#name : 'SparseCategoricalCrossEntropy'
}

{ #category : 'Gradients' }
SparseCategoricalCrossEntropy >> partialDerivativeWithRespectTo: aVariable [

	^self partialDerivativeWithRespectTo: aVariable product: self backpropagatedGradient
]

{ #category : 'Gradients' }
SparseCategoricalCrossEntropy >> partialDerivativeWithRespectTo: aVariable product: aCotangent [

	^Gradient of: unscaledLogits withRespectTo: aVariable product: aCotangent
]
