Extension {
	#name : 'TFElementWiseMultiplication'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFElementWiseMultiplication >> derivativeWithRespectTo: aVariable [

	aVariable = leftOperand ifTrue: [^rightOperand].
	aVariable = rightOperand ifTrue: [^leftOperand].

	self raiseIsNotDifferentiableRespectTo: aVariable
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Accessing'] }
TFElementWiseMultiplication >> inputsDo: aBlock [

	aBlock value: leftOperand.
	aBlock value: rightOperand
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFElementWiseMultiplication >> partialDerivativeWithRespectTo: aVariable [

	^TFSum
		of: (
			TFElementWiseMultiplication
				of: (leftOperand partialDerivativeWithRespectTo: aVariable)
				and: rightOperand)
		plus: (
			TFElementWiseMultiplication
				of: leftOperand
				and: (rightOperand partialDerivativeWithRespectTo: aVariable))
]
