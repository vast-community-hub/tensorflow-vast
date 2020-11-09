Extension {
	#name : 'SequenceableCollection'
}

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['TensorFlow-Kernel'] }
SequenceableCollection >> asBooleanTensor [
	^ TFTensor fromBooleans: self
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['TensorFlow-Kernel'] }
SequenceableCollection >> asFloatTensor [
	^ TFTensor fromFloats: self
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['TensorFlow-Kernel'] }
SequenceableCollection >> asInt32Tensor [
	^ TFTensor fromInt32s: self
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['TensorFlow-Kernel'] }
SequenceableCollection >> asInt64Tensor [
	^ TFTensor fromInt64s: self
]
