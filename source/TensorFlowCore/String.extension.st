Extension {
	#name : 'String'
}

{ #category : '*TensorFlowCore',
 #vaCategories : ['TensorFlow-Kernel'] }
String >> asAsciiZ [
	^ self asPSZ
]

{ #category : '*TensorFlowCore',
 #vaCategories : ['TensorFlow-Kernel'] }
String >> asTensor [
	^ TFTensor fromString: self
]
