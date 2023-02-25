Extension {
	#name : 'Boolean'
}

{ #category : 'TensorFlow-Kernel' }
Boolean >> asBooleanTensor [
	^ TFTensor fromBooleans: self
]

{ #category : 'TensorFlow-Kernel' }
Boolean >> asTensor [
	^ self asBooleanTensor
]
