Class {
	#name : 'TFImportGraphDefOptions',
	#superclass : 'TFStructure',
	#category : 'TensorFlowCore'
}

{ #category : 'instance creation' }
TFImportGraphDefOptions class >> create [
	^ TensorFlowCAPI current newImportGraphDefOptions
]

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFImportGraphDefOptions class >> initializeAfterLoad [
	"Set an opaque layout."

	self initializeOpaqueLayout
]

{ #category : 'instance creation' }
TFImportGraphDefOptions class >> new [

	^super new initialize
]

{ #category : 'release' }
TFImportGraphDefOptions >> basicDelete [
	^ self library deleteImportGraphDefOptions: self
]
