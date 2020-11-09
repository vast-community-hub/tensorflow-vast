Class {
	#name : 'TFTensor',
	#superclass : 'TFStructure',
	#category : 'TensorFlowApp'
}

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFTensor class >> initializeAfterLoad [
	"Set an opaque layout."

	self initializeOpaqueLayout
]

{ #category : 'Accessing' }
TFTensor >> data [
	"Answers the size of the underlying data in bytes.
	 
	 Answers:
		<OSVoid>"

	^OSPtr address: (self dispatcher callTF_TensorDataWith: self)
]

{ #category : 'Memory Management' }
TFTensor >> free [
	"Destroy a Tensor"

	self dispatcher callTF_DeleteTensorWith: self.
	self makeUndefined
]

{ #category : 'Accessing' }
TFTensor >> numBytes [
	"Answers the size of the underlying data in bytes.
	 
	 Answers:
		<Integer>"

	^self dispatcher callTF_TensorByteSizeWith: self
]

{ #category : 'Accessing' }
TFTensor >> numDims [
	"Answers the number of dimensions that the tensor has.
	 
	 Answers:
		<Integer>"

	^self dispatcher callTF_NumDimsWith: self
]

{ #category : 'Accessing' }
TFTensor >> type [
	"Answers the type of a tensor element.
	 
	 Answers:
		<Integer>"

	^self dispatcher callTF_TensorTypeWith: self
]
