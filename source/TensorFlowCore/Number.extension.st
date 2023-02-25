Extension {
	#name : 'Number'
}

{ #category : 'TensorFlow-Kernel' }
Number >> asFloatTensor [
	^ TFTensor fromFloats: self
]

{ #category : 'TensorFlow-Kernel' }
Number >> asInt32Tensor [
	^ TFTensor fromInt32s: self
]

{ #category : 'TensorFlow-Kernel' }
Number >> asInt64Tensor [
	^ TFTensor fromInt64s: self
]

{ #category : 'Converting' }
Number >> asTensor [

	^self subclassResponsibility
]
