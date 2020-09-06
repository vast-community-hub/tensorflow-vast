Extension {
	#name : 'SparseCategoricalCrossEntropy'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
SparseCategoricalCrossEntropy >> partialDerivativeWithRespectTo: aVariable [

	^self partialDerivativeWithRespectTo: aVariable product: self backpropagatedGradient
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
SparseCategoricalCrossEntropy >> partialDerivativeWithRespectTo: aVariable product: aCotangent [

	^Gradient of: unscaledLogits withRespectTo: aVariable product: aCotangent
]
