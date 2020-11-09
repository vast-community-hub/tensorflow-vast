Extension {
	#name : 'Integer'
}

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['Converting'] }
Integer >> asTensor [

	^self asInt32Tensor
]
