Class {
	#name : 'TFStructure',
	#superclass : 'OSStructure',
	#pools : [
		'TensorFlowConstants'
	],
	#category : 'TensorFlowCore'
}

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

{ #category : 'initialize-release' }
TFStructure >> finalize [

	[self delete]
		on: Error
		do: [:signal |
			Transcript
				cr;
				nextPutAll: (
					'Error finalizing %1 due to %2'
						bindWith: self class name
						with: signal messageText)]
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
