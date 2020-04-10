Extension {
	#name : 'TFOutput'
}

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['field definition'] }
TFOutput class >> fields [
	"self initialize.
	self defineFields"

	^ #(#(operation 'TFOperation*') #(index 'long') #(pad 'long'))
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFOutput class >> new [

	^super new initialize
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFOutput class >> onOperation: aTFOperation index: anInteger [

	^self externalNew
		operation: aTFOperation;
		index: anInteger;
		graph: aTFOperation graph;
		yourself
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFOutput >> graph [

	^graph
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFOutput >> graph: aTFGraph [

	
	graph := aTFGraph
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFOutput >> index [
	^ self int32At: #index
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFOutput >> index: anObject [
	self int32At: #index put: anObject
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFOutput >> operation [
	^ TFOperation address: (self pointerAt: #operation)
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFOutput >> operation: anObject [
	^ self pointerAt: #operation put: anObject

]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFOutput >> operationOn: aTFGraph [

	| answer |

	answer := self operation.
	answer graph: aTFGraph.
	^answer
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFOutput >> type [
	^ self library operationOutputType: self
]
