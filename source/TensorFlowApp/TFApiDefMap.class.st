Class {
	#name : 'TFApiDefMap',
	#superclass : 'TFStructure',
	#category : 'TensorFlowApp'
}

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFApiDefMap class >> initializeAfterLoad [
	"Set an opaque layout."

	self initializeOpaqueLayout
]
