Extension {
	#name : 'Float'
}

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['TensorFlow-Kernel'] }
Float >> asTensor [
	^ self asFloatTensor
]
