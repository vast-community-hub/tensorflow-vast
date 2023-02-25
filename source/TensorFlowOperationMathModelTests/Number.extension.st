Extension {
	#name : 'Number'
}

{ #category : 'Math-Extensions' }
Number >> sigmoid [

	" sigmoid function "

	^1 / (1 + (self negated exp))
]
