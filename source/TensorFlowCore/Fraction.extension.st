Extension {
	#name : 'Fraction'
}

{ #category : '*TensorFlowCore',
 #vaCategories : ['TensorFlow-Kernel'] }
Fraction >> asTensor [
	^ TFTensor fromFloats: self
]
