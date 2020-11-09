Class {
	#name : 'TFGraph',
	#superclass : 'TFStructure',
	#instVars : [
		'context'
	],
	#category : 'TensorFlowApp'
}

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFGraph class >> initializeAfterLoad [
	"Set an opaque layout."

	self initializeOpaqueLayout
]
