Class {
	#name : 'TFOutput',
	#superclass : 'TFStructure',
	#category : 'TensorFlowApp'
}

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFOutput class >> initializeAfterLoad [
	"Set layout."

	self members: #(operation index) types: #(pointer int32) alignmentType: Align16
]
