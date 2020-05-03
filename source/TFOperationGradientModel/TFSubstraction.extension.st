Extension {
	#name : 'TFSubstraction'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFSubstraction >> derivativeWithRespectTo: aVariable [

	aVariable = leftOperand ifTrue: [^TFConstant like: self filledWith: 1].
	aVariable = rightOperand ifTrue: [^TFConstant like: self filledWith: -1].

	self raiseIsNotDifferentiableRespectTo: aVariable
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Accessing'] }
TFSubstraction >> inputsDo: aBlock [

	aBlock value: leftOperand.
	aBlock value: rightOperand
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFSubstraction >> partialDerivativeWithRespectTo: aVariable [

	^TFSubstraction
		of: (leftOperand partialDerivativeWithRespectTo: aVariable)
		minus: (rightOperand partialDerivativeWithRespectTo: aVariable)
]
