Extension {
	#name : 'TFElementWiseSquare'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFElementWiseSquare >> partialDerivativeWithRespectTo: aVariable [

	| two |

	two := value currentComputation defineFloatTensorWith: 2.
	^TFElementWiseMultiplication
		of: (TFElementWiseMultiplication of: two and: operand)
		and: (operand partialDerivativeWithRespectTo: aVariable)
]
