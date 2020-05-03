Extension {
	#name : 'TFElementWiseSquare'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFElementWiseSquare >> derivativeWithRespectTo: aVariable [

	aVariable = operand
		ifTrue: [^TFElementWiseMultiplication of: operand and: (TFConstant like: self filledWith: 2)].

	self raiseIsNotDifferentiableRespectTo: aVariable
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Accessing'] }
TFElementWiseSquare >> inputsDo: aBlock [

	aBlock value: operand
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFElementWiseSquare >> partialDerivativeWithRespectTo: aVariable [

	^TFElementWiseMultiplication
		of: (TFElementWiseMultiplication of: operand and: (TFConstant like: self filledWith: 2))
		and: (operand partialDerivativeWithRespectTo: aVariable)
]
