Extension {
	#name : 'Number'
}

{ #category : '*MLMathExtensions',
 #vaCategories : ['Math-Extensions'] }
Number >> sigmoid [

	" sigmoid function "

	^1 / (1 + (self negated exp))
]
