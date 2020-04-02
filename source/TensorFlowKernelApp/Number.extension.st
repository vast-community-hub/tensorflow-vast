Extension {
	#name : 'Number'
}

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['TensorFlow-Kernel'] }
Number >> asFloatTensor [
	^ TFTensor fromFloats: self
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['TensorFlow-Kernel'] }
Number >> asInt32Tensor [
	^ TFTensor fromInt32s: self
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['TensorFlow-Kernel'] }
Number >> asInt64Tensor [
	^ TFTensor fromInt64s: self
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['Converting'] }
Number >> asOperationOn: aGraph [

	^self asTensor asOperationOn: aGraph
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['Converting'] }
Number >> asTensor [

	^self subclassResponsibility
]
