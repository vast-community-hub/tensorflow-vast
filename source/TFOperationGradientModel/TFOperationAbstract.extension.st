Extension {
	#name : 'TFOperationAbstract'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFOperationAbstract >> partialDerivativeWithRespectTo: aVariable [

	^TFGradient of: self withRespectTo: aVariable
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFOperationAbstract >> partialDerivativeWithRespectTo: aVariable product: aCotangent [

	^TFGradient of: self withRespectTo: aVariable product: aCotangent
]
