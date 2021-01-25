Extension {
	#name : 'Float'
}

{ #category : '*TensorFlowCore',
 #vaCategories : ['TensorFlow-Kernel'] }
Float >> asTensor [
	^ self asFloatTensor
]
