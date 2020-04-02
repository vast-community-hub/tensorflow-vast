Extension {
	#name : 'TFStatus'
}

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFStatus class >> create [
	| answer |
	answer := self persistent.
	answer useFinalization.
	^ answer
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFStatus class >> persistent [
	^ TensorFlowCAPI current newStatus
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['initialize-release'] }
TFStatus >> basicDelete [
	^ self library deleteStatus: self
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['testing'] }
TFStatus >> check [
	self isOk
		ifFalse: [ Error signal: self codeText , ': ' , self message ]
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFStatus >> code: aTF_Code message: aString [
	| externalized |
	self assert: aTF_Code ~= 0.
	externalized := self library externalizeString: aString.
	self library setStatus: self code: aTF_Code message: externalized
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFStatus >> codeText [
	^ self codeTexts at: self code + 1
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFStatus >> codeTexts [
	"self new codeTexts"

	^ #('OK' 'CANCELLED' 'UNKNOWN' 'INVALID_ARGUMENT' 'DEADLINE_EXCEEDED' 'NOT_FOUND' 'ALREADY_EXISTS' 'PERMISSION_DENIED' 'RESOURCE_EXHAUSTED' 'FAILED_PRECONDITION' 'ABORTED' 'OUT_OF_RANGE' 'UNIMPLEMENTED' 'INTERNALt' 'UNAVAILABLE' 'DATA_LOSS' 'UNAUTHENTICATED')	"0"	"1"	"2"	"3"	"4"	"5"	"6"	"7"	"8"	"9"	"10"	"11"	"12"	"13"	"14"	"15"	"16"
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['printing'] }
TFStatus >> printOn: strm [
	super printOn: strm.
	self isNull
		ifFalse: [ strm
				space;
				print: self code;
				space;
				print: self message ]
]
