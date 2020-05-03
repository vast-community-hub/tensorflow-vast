Extension {
	#name : 'TFOperation'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFOperation >> partialDerivativeWithRespectTo: aVariable [

	(#('Variable' 'Placeholder' 'Const') includes: self type)
		ifTrue: [| filledValue |
			filledValue := aVariable = self ifTrue: [1] ifFalse: [0].
			^TFConstant like: self filledWith: filledValue].

	NotDifferentiable signal: ('%1 should implement it''s own gradient function' bindWith: self type)
]
