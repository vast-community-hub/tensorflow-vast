Class {
	#name : 'TFOperationDescription',
	#superclass : 'TFStructure',
	#category : 'TensorFlowApp'
}

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFOperationDescription class >> initializeAfterLoad [
	"Set an opaque layout."

	self initializeOpaqueLayout
]
