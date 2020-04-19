Extension {
	#name : 'TFSum'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFSum >> partialDerivativeWithRespectTo: aVariable [

	^TFSum ofAll: (operands collect: [:operand | operand partialDerivativeWithRespectTo: aVariable])
]
