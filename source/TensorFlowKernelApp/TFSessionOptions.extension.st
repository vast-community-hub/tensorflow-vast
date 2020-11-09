Extension {
	#name : 'TFSessionOptions'
}

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFSessionOptions class >> create [
	^ TensorFlowCAPI current newSessionOptions useFinalization
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFSessionOptions class >> fromProtoBuf: aString [
	| answer |
	answer := self create.
	answer config: aString.
	^ answer
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFSessionOptions class >> onTarget: aString [
	^ self create target: aString
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['initialize-release'] }
TFSessionOptions >> basicDelete [
	^ self library deleteSessionOptions: self
]
