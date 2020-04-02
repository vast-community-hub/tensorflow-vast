Class {
	#name : 'TFDeprecatedSession',
	#superclass : 'TFStructure',
	#category : 'TensorFlowApp'
}

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFDeprecatedSession class >> initializeAfterLoad [
	"Set an opaque layout."

	self initializeOpaqueLayout
]
