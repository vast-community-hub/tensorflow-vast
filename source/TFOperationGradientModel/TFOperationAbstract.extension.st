Extension {
	#name : 'TFOperationAbstract'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFOperationAbstract >> partialDerivativeWithRespectTo: aVariable [

	self subclassResponsibility
]
