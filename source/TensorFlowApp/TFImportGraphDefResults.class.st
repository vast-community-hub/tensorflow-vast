Class {
	#name : 'TFImportGraphDefResults',
	#superclass : 'TFStructure',
	#category : 'TensorFlowApp'
}

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFImportGraphDefResults class >> initializeAfterLoad [
	"Set an opaque layout."

	self initializeOpaqueLayout
]
