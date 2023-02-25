Extension {
	#name : 'TensorFlowOperationAbstract'
}

{ #category : 'Gradients' }
TensorFlowOperationAbstract >> partialDerivativeWithRespectTo: aVariable [

	^Gradient of: self withRespectTo: aVariable
]

{ #category : 'Gradients' }
TensorFlowOperationAbstract >> partialDerivativeWithRespectTo: aVariable product: aCotangent [

	^Gradient of: self withRespectTo: aVariable product: aCotangent
]
