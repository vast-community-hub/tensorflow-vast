Extension {
	#name : 'TFElementWiseMultiplication'
}

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
