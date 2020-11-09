Class {
	#name : 'TFServer',
	#superclass : 'TFStructure',
	#category : 'TensorFlowApp'
}

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFServer class >> initializeAfterLoad [
	"Set an opaque layout."

	self initializeOpaqueLayout
]
