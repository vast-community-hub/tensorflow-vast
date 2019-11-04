Class {
	#name : 'TFImportGraphDefOptions',
	#superclass : 'TFStructure',
	#category : 'TensorFlowApp'
}

{
	#category : 'Startup/Shutdown',
	#vaVisibility : 'private'
}
TFImportGraphDefOptions class >> initializeAfterLoad [
	"Set an opaque layout."

	self initializeOpaqueLayout
]
