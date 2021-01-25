Class {
	#name : 'TFAttrMetadata',
	#superclass : 'TFStructure',
	#category : 'TensorFlowCore'
}

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFAttrMetadata class >> initializeAfterLoad [
	"Set layout"

	self members: #(is_list list_size type total_size) types: #(uint8 int64 uint32 int64)
]

{ #category : 'accessing' }
TFAttrMetadata >> _type [
	^ self uint32At: #type
]

{ #category : 'types' }
TFAttrMetadata >> isBoolean [
	^ self type = 3
]

{ #category : 'types' }
TFAttrMetadata >> isFloat [
	^ self type = 2
]

{ #category : 'types' }
TFAttrMetadata >> isFunc [
	^ self type = 8
]

{ #category : 'types' }
TFAttrMetadata >> isInt [
	^ self type = 1
]

{ #category : 'accessing' }
TFAttrMetadata >> isList [

	^self bool8At: #is_list
]

{ #category : 'types' }
TFAttrMetadata >> isPlaceholder [
	^ self type = 7
]

{ #category : 'types' }
TFAttrMetadata >> isShape [
	^ self type = 5
]

{ #category : 'types' }
TFAttrMetadata >> isString [
	^ self type = 0
]

{ #category : 'types' }
TFAttrMetadata >> isTensor [
	^ self type = 6
]

{ #category : 'types' }
TFAttrMetadata >> isType [
	^ self type = 4
]

{ #category : 'accessing' }
TFAttrMetadata >> listSize [
	^ self int64At: #list_size
]

{ #category : 'accessing' }
TFAttrMetadata >> totalSize [
	^ self int64At: #total_size
]

{ #category : 'accessing' }
TFAttrMetadata >> type [
	"This method was automatically generated. See TFAttrMetadata class>>fields."

	^ self _type \\ 256
]
