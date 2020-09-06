Class {
	#name : 'AddBias',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'addend',
		'bias'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
AddBias class >> named: anOperationName to: aTensorOrOperation with: aBias [

	^self new initializeNamed: anOperationName to: aTensorOrOperation with: aBias
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
AddBias class >> operationType [

	^'BiasAdd'
]

{ #category : 'Instance Creation' }
AddBias class >> to: aTensorOrOperation with: aBias [

	^self named: self operationType to: aTensorOrOperation with: aBias
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
AddBias >> initializeNamed: anOperationName to: aTensorOrOperation with: aBias [

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
AddBias >> printOn: aStream [

	aStream nextPutAll: ('<1p> + <2p>' expandMacrosWith: addend with: bias)
]
