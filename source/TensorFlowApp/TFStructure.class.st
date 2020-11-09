Class {
	#name : 'TFStructure',
	#superclass : 'OSStructure',
	#pools : [
		'TensorFlowConstants'
	],
	#category : 'TensorFlowApp'
}

{ #category : 'Accessing' }
TFStructure class >> dispatcher [
	"Get a handle on the dispatcher"

	^TFLibraryDispatcher default
]

{ #category : 'Instance Creation' }
TFStructure class >> externalNew [
	^ self calloc
]

{ #category : 'instance creation' }
TFStructure class >> externalNew: count [
	^ self calloc: count
]

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFStructure class >> initializeOpaqueLayout [
	"Initialize Opaque Layout"

	^self members: #() types: #()
]

{ #category : 'Finalization' }
TFStructure >> basicDelete [
	self free
]

{ #category : 'Finalization' }
TFStructure >> delete [
	self ignoreFinalization.
	self isNull
		ifFalse: [ self basicDelete ].
	self makeNull
]

{ #category : 'Accessing' }
TFStructure >> dispatcher [
	"Get a handle on the dispatcher"

	^self class dispatcher
]

{ #category : 'initialize-release' }
TFStructure >> finalize [
	[ self delete ]
		on: Error
		do: [ Transcript
				newLine;
				print: 'Error finalizing ';
				show: self class name] 
				
]

{ #category : 'Finalization' }
TFStructure >> ignoreFinalization [
	self removeToBeFinalized
]

{ #category : 'Accessing' }
TFStructure >> library [
	^ TensorFlowCAPI current
]

{ #category : 'Finalization' }
TFStructure >> useFinalization [
	self onFinalizeDo: #finalize
]
