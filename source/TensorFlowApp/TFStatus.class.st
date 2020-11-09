Class {
	#name : 'TFStatus',
	#superclass : 'TFStructure',
	#category : 'TensorFlowApp'
}

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

{ #category : 'API' }
TFStatus >> code [
	"Return the code record in this status

	Answers
		<Integer> - status code"

	^self library getCode: self
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
