Extension {
	#name : 'ScaledDecimal'
}

{ #category : '*TensorFlowCore',
 #vaCategories : ['Converting'] }
ScaledDecimal >> asTensor [

	^self asFloatTensor
]
