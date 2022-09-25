Extension {
	#name : 'TensorFlowOperationAbstract'
}

{ #category : '*TensorFlowOperationGradientModel',
 #vaCategories : ['Gradients'] }
TensorFlowOperationAbstract >> partialDerivativeWithRespectTo: aVariable [

	^Gradient of: self withRespectTo: aVariable
]

{ #category : '*TensorFlowOperationGradientModel',
 #vaCategories : ['Gradients'] }
TensorFlowOperationAbstract >> partialDerivativeWithRespectTo: aVariable product: aCotangent [

	^Gradient of: self withRespectTo: aVariable product: aCotangent
]
