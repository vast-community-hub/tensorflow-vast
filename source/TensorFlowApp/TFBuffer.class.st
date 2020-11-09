Class {
	#name : 'TFBuffer',
	#superclass : 'TFStructure',
	#category : 'TensorFlowApp'
}

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFBuffer class >> initializeAfterLoad [
	"Set layout."

	self members: #(data length data_deallocator) types: #(pointer usize pointer)
]

{ #category : 'Accessing' }
TFBuffer >> data [

	^OSVoid address: (self pointerAt: #data)
]

{ #category : 'Memory Management' }
TFBuffer >> free [
	self delete.
	self makeUndefined
]

{ #category : 'Accessing' }
TFBuffer >> length [

	^self usizeAt: #length
]
