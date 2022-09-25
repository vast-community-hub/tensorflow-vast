Extension {
	#name : 'Number'
}

{ #category : '*TensorFlowOperationMathModelTests',
 #vaCategories : ['Math-Extensions'] }
Number >> sigmoid [

	" sigmoid function "

	^1 / (1 + (self negated exp))
]
