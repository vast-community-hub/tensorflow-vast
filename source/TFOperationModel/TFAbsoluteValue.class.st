Class {
	#name : 'TFAbsoluteValue',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'originalValue'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFAbsoluteValue class >> named: aName of: anOperation [

	^self new initializeNamed: aName of: anOperation
]

{ #category : 'Instance Creation' }
TFAbsoluteValue class >> of: anOperation [

	^self named: self operationType of: anOperation
]

{ #category : 'Instance Creation',
  #vaVisibility : 'private' }
TFAbsoluteValue class >> operationType [

	^'Abs'
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFAbsoluteValue >> initializeNamed: aName of: anOperation [

	originalValue := anOperation.
	value :=
		originalValue currentComputation
			newOperationOf: self class operationType
			namePrefixed: aName
			with: originalValue
]

{ #category : 'Printing' }
TFAbsoluteValue >> printOn: aStream [


	aStream nextPutAll: ('abs(<1p>)' expandMacrosWith: originalValue)

]
