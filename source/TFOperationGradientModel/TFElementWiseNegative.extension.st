Extension {
	#name : 'TFElementWiseNegative'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFElementWiseNegative >> derivativeWithRespectTo: aVariable [

	aVariable = operandToNegate ifTrue: [^TFConstant like: self filledWith: -1].

	self raiseIsNotDifferentiableRespectTo: aVariable
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Accessing'] }
TFElementWiseNegative >> inputsDo: aBlock [

	aBlock value: operandToNegate
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFElementWiseNegative >> partialDerivativeWithRespectTo: aVariable [

	^(operandToNegate partialDerivativeWithRespectTo: aVariable) negated
]
