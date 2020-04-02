Class {
	#name : 'TFAttrMetadata',
	#superclass : 'TFStructure',
	#category : 'TensorFlowApp'
}

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFAttrMetadata class >> initializeAfterLoad [
	"Set layout"

	self members: #(is_list list_size type total_size) types: #(uint8 int64 uint32 int64)
]
