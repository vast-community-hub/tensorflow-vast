Extension {
	#name : 'CategoricalCrossEntropy'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Accessing'] }
CategoricalCrossEntropy >> partialDerivativeWithRespectTo: aVariable [

	^self partialDerivativeWithRespectTo: aVariable product: self backpropagatedGradient
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Accessing'] }
CategoricalCrossEntropy >> partialDerivativeWithRespectTo: aVariable product: aCotangent [

	^Gradient of: logits withRespectTo: aVariable product: aCotangent
]
