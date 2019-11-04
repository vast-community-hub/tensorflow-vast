Extension {
	#name : 'ScaledDecimal'
}

{
	#category : '*TensorFlowKernelApp',
	#vaCategories : ['Converting']
}
ScaledDecimal >> asTensor [

	^self asFloatTensor
]
