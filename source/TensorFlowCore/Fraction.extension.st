Extension {
	#name : 'Fraction'
}

{ #category : 'TensorFlow-Kernel' }
Fraction >> asTensor [
	^ TFTensor fromFloats: self
]
