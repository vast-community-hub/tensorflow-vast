Extension {
	#name : 'TFOutput'
}

{
	#category : '*TensorFlowKernelApp',
	#vaCategories : ['field definition']
}
TFOutput class >> fields [
	"self initialize.
	self defineFields"

	^ #(#(operation 'TFOperation*') #(index 'long') #(pad 'long'))
]

{
	#category : '*TensorFlowKernelApp',
	#vaCategories : ['instance creation']
}
TFOutput class >> new [

	^super new initialize
]

{
	#category : '*TensorFlowKernelApp',
	#vaCategories : ['instance creation']
}
TFOutput class >> onOperation: aTFOperation index: anInteger [
	^ self externalNew
		operation: aTFOperation;
		index: anInteger
]

{
	#category : '*TensorFlowKernelApp',
	#vaCategories : ['accessing']
}
TFOutput >> index [
	^ self int32At: #index
]

{
	#category : '*TensorFlowKernelApp',
	#vaCategories : ['accessing']
}
TFOutput >> index: anObject [
	self int32At: #index put: anObject
]

{
	#category : '*TensorFlowKernelApp',
	#vaCategories : ['accessing']
}
TFOutput >> operation [
	^ TFOperation address: (self pointerAt: #operation)
]

{
	#category : '*TensorFlowKernelApp',
	#vaCategories : ['accessing']
}
TFOutput >> operation: anObject [
	^ self pointerAt: #operation put: anObject

]

{
	#category : '*TensorFlowKernelApp',
	#vaCategories : ['accessing']
}
TFOutput >> operationOn: aTFGraph [
"The following source failed to compile (all double quotes have been doubled):
	| answer |
	answer := TFOperation fromHandle: (handle longPointerAt: 1).
	answer graph: aTFGraph.
	^ answer
"

	^ self halt: 'The source for this method failed to compile'
]

{
	#category : '*TensorFlowKernelApp',
	#vaCategories : ['accessing']
}
TFOutput >> type [
	^ self library operationOutputType: self
]
