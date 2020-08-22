Extension {
	#name : 'TFSparseCategoricalCrossEntropy'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFSparseCategoricalCrossEntropy >> partialDerivativeWithRespectTo: aVariable [

	^self partialDerivativeWithRespectTo: aVariable product: self backpropagatedGradient
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFSparseCategoricalCrossEntropy >> partialDerivativeWithRespectTo: aVariable product: aCotangent [

	^TFGradient of: unscaledLogits withRespectTo: aVariable product: aCotangent
]
