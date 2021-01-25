Extension {
	#name : 'Boolean'
}

{ #category : '*TensorFlowCore',
 #vaCategories : ['TensorFlow-Kernel'] }
Boolean >> asBooleanTensor [
	^ TFTensor fromBooleans: self
]

{ #category : '*TensorFlowCore',
 #vaCategories : ['TensorFlow-Kernel'] }
Boolean >> asTensor [
	^ self asBooleanTensor
]
