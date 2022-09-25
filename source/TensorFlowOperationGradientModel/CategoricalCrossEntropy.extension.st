Extension {
	#name : 'CategoricalCrossEntropy'
}

{ #category : '*TensorFlowOperationGradientModel',
 #vaCategories : ['Accessing'] }
CategoricalCrossEntropy >> partialDerivativeWithRespectTo: aVariable [

	^self partialDerivativeWithRespectTo: aVariable product: self backpropagatedGradient
]

{ #category : '*TensorFlowOperationGradientModel',
 #vaCategories : ['Accessing'] }
CategoricalCrossEntropy >> partialDerivativeWithRespectTo: aVariable product: aCotangent [

	^Gradient of: logits withRespectTo: aVariable product: aCotangent
]
