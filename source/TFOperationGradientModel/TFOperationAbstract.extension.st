Extension {
	#name : 'TFOperationAbstract'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFOperationAbstract >> partialDerivativeWithRespectTo: aVariable [

	^TFGradient of: (Array with: self) withRespectTo: (Array with: aVariable)
]
