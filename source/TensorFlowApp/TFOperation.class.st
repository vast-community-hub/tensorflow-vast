Class {
	#name : 'TFOperation',
	#superclass : 'TFStructure',
	#instVars : [
		'graph',
		'output'
	],
	#category : 'TensorFlowApp'
}

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFOperation class >> initializeAfterLoad [
	"Set an opaque layout."

	self initializeOpaqueLayout
]
