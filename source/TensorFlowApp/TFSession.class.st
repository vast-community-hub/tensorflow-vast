Class {
	#name : 'TFSession',
	#superclass : 'TFStructure',
	#category : 'TensorFlowApp'
}

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFSession class >> initializeAfterLoad [
	"Set an opaque layout."

	self initializeOpaqueLayout
]
