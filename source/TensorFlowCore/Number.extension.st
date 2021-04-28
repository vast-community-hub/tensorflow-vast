Extension {
	#name : 'Number'
}

{ #category : '*TensorFlowCore',
 #vaCategories : ['TensorFlow-Kernel'] }
Number >> asFloatTensor [
	^ TFTensor fromFloats: self
]

{ #category : '*TensorFlowCore',
 #vaCategories : ['TensorFlow-Kernel'] }
Number >> asInt32Tensor [
	^ TFTensor fromInt32s: self
]

{ #category : '*TensorFlowCore',
 #vaCategories : ['TensorFlow-Kernel'] }
Number >> asInt64Tensor [
	^ TFTensor fromInt64s: self
]

{ #category : '*TensorFlowCore',
 #vaCategories : ['Converting'] }
Number >> asTensor [

	^self subclassResponsibility
]
