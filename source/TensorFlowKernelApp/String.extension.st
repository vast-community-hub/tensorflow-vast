Extension {
	#name : 'String'
}

{
	#category : '*TensorFlowKernelApp',
	#vaCategories : ['TensorFlow-Kernel']
}
String >> asAsciiZ [
	^ self asPSZ
]

{
	#category : '*TensorFlowKernelApp',
	#vaCategories : ['TensorFlow-Kernel']
}
String >> asTensor [
	^ TFTensor fromString: self
]
