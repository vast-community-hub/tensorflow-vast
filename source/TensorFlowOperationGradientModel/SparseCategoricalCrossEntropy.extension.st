Extension {
	#name : 'SparseCategoricalCrossEntropy'
}

{ #category : '*TensorFlowOperationGradientModel',
 #vaCategories : ['Gradients'] }
SparseCategoricalCrossEntropy >> partialDerivativeWithRespectTo: aVariable [

	^self partialDerivativeWithRespectTo: aVariable product: self backpropagatedGradient
]

{ #category : '*TensorFlowOperationGradientModel',
 #vaCategories : ['Gradients'] }
SparseCategoricalCrossEntropy >> partialDerivativeWithRespectTo: aVariable product: aCotangent [

	^Gradient of: unscaledLogits withRespectTo: aVariable product: aCotangent
]
