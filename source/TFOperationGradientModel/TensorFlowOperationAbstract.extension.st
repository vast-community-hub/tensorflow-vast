Extension {
	#name : 'TensorFlowOperationAbstract'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TensorFlowOperationAbstract >> partialDerivativeWithRespectTo: aVariable [

	^Gradient of: self withRespectTo: aVariable
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TensorFlowOperationAbstract >> partialDerivativeWithRespectTo: aVariable product: aCotangent [

	^Gradient of: self withRespectTo: aVariable product: aCotangent
]
