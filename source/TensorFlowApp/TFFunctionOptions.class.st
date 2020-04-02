Class {
	#name : 'TFFunctionOptions',
	#superclass : 'TFStructure',
	#category : 'TensorFlowApp'
}

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFFunctionOptions class >> initializeAfterLoad [
	"Set an opaque layout."

	self initializeOpaqueLayout
]
