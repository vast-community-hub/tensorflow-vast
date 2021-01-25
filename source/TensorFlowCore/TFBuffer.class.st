Class {
	#name : 'TFBuffer',
	#superclass : 'TFStructure',
	#category : 'TensorFlowCore'
}

{ #category : 'field definition' }
TFBuffer class >> fields [
	"self initialize.
	self defineFields"

	^ #(#(data 'void*') #(length 'ulonglong') #(deallocator 'void*'))
]

{ #category : 'instance creation' }
TFBuffer class >> fromFileNamed: aString [
	| fileContents |
	
	aString asPath readStreamDo: [:strm |
		fileContents := strm contents].
	^ self fromString: fileContents
]

{ #category : 'instance creation' }
TFBuffer class >> fromString: aString [
	| answer |
	answer := TensorFlowCAPI current
		newBufferFromString: aString
		size: aString size.
	^ answer
]

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFBuffer class >> initializeAfterLoad [
	"Set layout."

	self members: #(data length data_deallocator) types: #(pointer usize pointer)
]

{ #category : 'instance creation' }
TFBuffer class >> new [
	"Answer a new buffer
	 
	 Answers:
		<TFBuffer>"

	| result |

	result := self address: (self dispatcher callTF_NewBuffer).
	result isNull ifTrue: [^nil].
	^result
]

{ #category : 'release' }
TFBuffer >> basicDelete [
	^ self library deleteBuffer: self
]

{ #category : 'Accessing' }
TFBuffer >> data [

	^OSVoid address: (self pointerAt: #data)
]

{ #category : 'accessing' }
TFBuffer >> data: anObject [
"The following source failed to compile (all double quotes have been doubled):
	""This method was automatically generated. See TFBuffer class>>fields.""

	handle longPointerAt: 1 put: anObject getHandle
"

	^ self halt: 'The source for this method failed to compile'
]

{ #category : 'accessing' }
TFBuffer >> dataBytes [
	^ self data byteArrayAt: 0 size: self length
]

{ #category : 'accessing' }
TFBuffer >> deallocator [
"The following source failed to compile (all double quotes have been doubled):
	""This method was automatically generated. See TFBuffer class>>fields.""

	^ ExternalData
		fromHandle: (handle longPointerAt: 17)
		type: ExternalType void asPointerType
"

	^ self halt: 'The source for this method failed to compile'
]

{ #category : 'accessing' }
TFBuffer >> deallocator: anObject [
"The following source failed to compile (all double quotes have been doubled):
	""This method was automatically generated. See TFBuffer class>>fields.""

	handle longPointerAt: 17 put: anObject getHandle
"

	^ self halt: 'The source for this method failed to compile'
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

{ #category : 'accessing' }
TFBuffer >> length: anObject [
"The following source failed to compile (all double quotes have been doubled):
	""This method was automatically generated. See TFBuffer class>>fields.""

	handle unsignedLongLongAt: 9 put: anObject
"

	^ self halt: 'The source for this method failed to compile'
]
