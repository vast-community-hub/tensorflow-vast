Extension {
	#name : 'Boolean'
}

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['TensorFlow-Kernel'] }
Boolean >> asBooleanTensor [
	^ TFTensor fromBooleans: self
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['TensorFlow-Kernel'] }
Boolean >> asTensor [
	^ self asBooleanTensor
]
