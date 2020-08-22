Extension {
	#name : 'TFCategoricalCrossEntropy'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Accessing'] }
TFCategoricalCrossEntropy >> partialDerivativeWithRespectTo: aVariable [

	^self partialDerivativeWithRespectTo: aVariable product: self backpropagatedGradient
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Accessing'] }
TFCategoricalCrossEntropy >> partialDerivativeWithRespectTo: aVariable product: aCotangent [

	^TFGradient of: logits withRespectTo: aVariable product: aCotangent
]
