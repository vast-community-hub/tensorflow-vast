Class {
	#name : 'TFStatus',
	#superclass : 'TFStructure',
	#category : 'TensorFlowCore'
}

{ #category : 'instance creation' }
TFStatus class >> create [
	| answer |
	answer := self persistent.
	answer useFinalization.
	^ answer
]

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFStatus class >> initializeAfterLoad [
	"Set an opaque layout."

	self initializeOpaqueLayout
]

{ #category : 'Creation' }
TFStatus class >> new [
	"Answer a new status object
	 
	 Answers:
		<TFStatus>"

	^ self persistent
]

{ #category : 'instance creation' }
TFStatus class >> persistent [
	^ TensorFlowCAPI current newStatus
]

{ #category : 'initialize-release' }
TFStatus >> basicDelete [
	^ self library deleteStatus: self
]

{ #category : 'testing' }
TFStatus >> check [
	self isOk
		ifFalse: [ Error signal: self codeText , ': ' , self message ]
]

{ #category : 'API' }
TFStatus >> code [
	"Return the code record in this status

	Answers
		<Integer> - status code"

	^self library getCode: self
]

{ #category : 'accessing' }
TFStatus >> code: aTF_Code message: aString [
	| externalized |
	self assert: aTF_Code ~= 0.
	externalized := self library externalizeString: aString.
	self library setStatus: self code: aTF_Code message: externalized
]

{ #category : 'accessing' }
TFStatus >> codeText [
	^ self codeTexts at: self code + 1
]

{ #category : 'accessing' }
TFStatus >> codeTexts [
	"self new codeTexts"

	^ #('OK' 'CANCELLED' 'UNKNOWN' 'INVALID_ARGUMENT' 'DEADLINE_EXCEEDED' 'NOT_FOUND' 'ALREADY_EXISTS' 'PERMISSION_DENIED' 'RESOURCE_EXHAUSTED' 'FAILED_PRECONDITION' 'ABORTED' 'OUT_OF_RANGE' 'UNIMPLEMENTED' 'INTERNALt' 'UNAVAILABLE' 'DATA_LOSS' 'UNAUTHENTICATED')	"0"	"1"	"2"	"3"	"4"	"5"	"6"	"7"	"8"	"9"	"10"	"11"	"12"	"13"	"14"	"15"	"16"
]

{ #category : 'Memory Management' }
TFStatus >> free [
	"Delete a previously created status object."

	self delete.
	self makeUndefined
]

{ #category : 'API' }
TFStatus >> isOk [
	"Answer true if status code is ok"

	^self code = TF_OK
]

{ #category : 'API' }
TFStatus >> message [
	"Answer a <String> to the error message in this status.
	 Answers empty string if TF_OK status code

	Answers
		<String> - status message"

	^ self library message: self
]

{ #category : 'printing' }
TFStatus >> printOn: strm [
	super printOn: strm.
	self isNull
		ifFalse: [ strm
				space;
				print: self code;
				space;
				print: self message ]
]
