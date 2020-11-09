Extension {
	#name : 'Fraction'
}

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['TensorFlow-Kernel'] }
Fraction >> asTensor [
	^ TFTensor fromFloats: self
]
