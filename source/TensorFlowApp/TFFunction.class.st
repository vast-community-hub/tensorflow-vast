Class {
	#name : 'TFFunction',
	#superclass : 'TFStructure',
	#category : 'TensorFlowApp'
}

{
	#category : 'Startup/Shutdown',
	#vaVisibility : 'private'
}
TFFunction class >> initializeAfterLoad [
	"Set an opaque layout."

	self initializeOpaqueLayout
]
