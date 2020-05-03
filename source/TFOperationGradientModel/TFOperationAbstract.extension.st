Extension {
	#name : 'TFOperationAbstract'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFOperationAbstract >> derivativeWithRespectTo: aVariable [

	self subclassResponsibility
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Accessing'] }
TFOperationAbstract >> inputsDo: aBlock [


	self subclassResponsibility
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFOperationAbstract >> partialDerivativeWithRespectTo: aVariable [

	self subclassResponsibility
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFOperationAbstract >> raiseIsNotDifferentiableRespectTo: aVariable [

	NotDifferentiable
		signal: ('%1 is not differentiable respect to %2' bindWith: self with: aVariable)
]
