Class {
	#name : 'TFAddBias',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'addend',
		'bias'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFAddBias class >> named: anOperationName to: aTensorOrOperation with: aBias [

	^self new initializeNamed: anOperationName to: aTensorOrOperation with: aBias
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFAddBias class >> operationType [

	^'BiasAdd'
]

{ #category : 'Instance Creation' }
TFAddBias class >> to: aTensorOrOperation with: aBias [

	^self named: self operationType to: aTensorOrOperation with: aBias
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFAddBias >> initializeNamed: anOperationName to: aTensorOrOperation with: aBias [

	addend := aTensorOrOperation.
	bias := aBias.
	value :=
		addend currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			with: addend
			with: bias
]

{ #category : 'Printing' }
TFAddBias >> printOn: aStream [

	aStream nextPutAll: ('<1p> + <2p>' expandMacrosWith: addend with: bias)
]
