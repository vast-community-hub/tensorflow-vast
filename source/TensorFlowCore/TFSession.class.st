Class {
	#name : 'TFSession',
	#superclass : 'TFStructure',
	#category : 'TensorFlowCore'
}

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFSession class >> initializeAfterLoad [
	"Set an opaque layout."

	self initializeOpaqueLayout
]

{ #category : 'instance creation' }
TFSession class >> new [

	^super new initialize
]

{ #category : 'instance creation' }
TFSession class >> on: aTFGraph [

	^ TensorFlowCAPI current newAutoreleaseSessionOn: aTFGraph
]

{ #category : 'release' }
TFSession >> basicDelete [
	
	self close.
	self library deleteSession: self
	
]

{ #category : 'release' }
TFSession >> close [

	self library closeSession: self
]

{ #category : 'running' }
TFSession >> devices [
	^ (TFDeviceList on: self) devices
]

{ #category : 'running' }
TFSession >> run [

	self library runSession: self
]

{ #category : 'running' }
TFSession >> runInputs: inArrayOfTFInputs values: inArrayOfTFTensor outputs: outArrayOfTFOutputs [
	
	^ self library runSession: self inputs: inArrayOfTFInputs values: inArrayOfTFTensor outputs: outArrayOfTFOutputs
]

{ #category : 'running' }
TFSession >> runOperation: aTFOperation [
	^ self runOperations: (Array with: aTFOperation)
]

{ #category : 'running' }
TFSession >> runOperation: aTFOperation output: aTFOutput [

	^ self library runSession: self operation: aTFOperation output: aTFOutput
]

{ #category : 'running' }
TFSession >> runOperations: anArrayOfTFOperations [
	
	^ self library runSession: self operations: anArrayOfTFOperations
]

{ #category : 'running' }
TFSession >> runOutput: aTFOutput [
	| results |
	results := self
		runOutputs:
			((Array new: 1)
				at: 1 put: aTFOutput;
				yourself).
	^ results first
]

{ #category : 'running' }
TFSession >> runOutputs: anArrayOfTFOutputs [

	^self library runSession: self outputs: anArrayOfTFOutputs
]
