Class {
	#name : 'TFDevice',
	#superclass : 'Object',
	#instVars : [
		'name',
		'type',
		'memory',
		'incarnation'
	],
	#category : 'TensorFlowApp'
}

{ #category : 'Instance Creation' }
TFDevice class >> name: nameString type: typeString memory: memoryInteger incarnation: incarnationInteger [
	^ self new
		name: nameString;
		type: typeString;
		memory: memoryInteger;
		incarnation: incarnationInteger

]

{ #category : 'accessing' }
TFDevice >> incarnation [
	^incarnation
]

{ #category : 'accessing',
  #vaVisibility : 'private' }
TFDevice >> incarnation: anObject [
	incarnation := anObject
]

{ #category : 'accessing' }
TFDevice >> memory [
	^memory
]

{ #category : 'accessing',
  #vaVisibility : 'private' }
TFDevice >> memory: anObject [
	memory := anObject
]

{ #category : 'accessing' }
TFDevice >> name [
	^name
]

{ #category : 'accessing',
  #vaVisibility : 'private' }
TFDevice >> name: anObject [
	name := anObject
]

{ #category : 'Printing' }
TFDevice >> printOn: strm [
	super printOn: strm.
	strm space; nextPut: $(; nextPutAll: self name; nextPut: $)
]

{ #category : 'accessing' }
TFDevice >> type [
	^type
]

{ #category : 'accessing',
  #vaVisibility : 'private' }
TFDevice >> type: anObject [
	type := anObject
]
