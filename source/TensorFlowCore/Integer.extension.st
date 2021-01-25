Extension {
	#name : 'Integer'
}

{ #category : '*TensorFlowCore',
 #vaCategories : ['Converting'] }
Integer >> asTensor [

	^self asInt32Tensor
]
