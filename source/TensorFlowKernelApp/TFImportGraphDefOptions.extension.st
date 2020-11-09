Extension {
	#name : 'TFImportGraphDefOptions'
}

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFImportGraphDefOptions class >> create [
	^ TensorFlowCAPI current newImportGraphDefOptions
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFImportGraphDefOptions class >> new [

	^super new initialize
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['release'] }
TFImportGraphDefOptions >> basicDelete [
	^ self library deleteImportGraphDefOptions: self
]
