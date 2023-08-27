Extension {
	#name : 'CategoricalCrossEntropy'
}

{ #category : 'Accessing' }
CategoricalCrossEntropy >> partialDerivativeWithRespectTo: aVariable [

	^self partialDerivativeWithRespectTo: aVariable product: self backpropagatedGradient
]

{ #category : 'Accessing' }
CategoricalCrossEntropy >> partialDerivativeWithRespectTo: aVariable product: aCotangent [

	^Gradient of: logits withRespectTo: aVariable product: aCotangent
]