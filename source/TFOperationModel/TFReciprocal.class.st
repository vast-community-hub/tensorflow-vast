Class {
	#name : 'TFReciprocal',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'operation'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFReciprocal class >> named: aName of: anOperation [

	^self new initializeNamed: aName of: anOperation
]

{ #category : 'Instance Creation' }
TFReciprocal class >> of: anOperation [

	^self named: self operationType of: anOperation
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFReciprocal class >> operationType [

	^'Reciprocal'
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFReciprocal >> initializeNamed: aName of: anOperation [

	operation := anOperation.
	value :=
		operation currentComputation
			newOperationOf: self class operationType
			namePrefixed: aName
			with: operation
]

{ #category : 'Printing' }
TFReciprocal >> printOn: aStream [

	aStream nextPutAll: ('1 / (<1p>)' expandMacrosWith: operation)
]
