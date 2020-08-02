Class {
	#name : 'TFElementWiseSquare',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'operand'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFElementWiseSquare class >> named: aName of: aTFOperation [

	^self new initializeNamed: aName of: aTFOperation
]

{ #category : 'Instance Creation' }
TFElementWiseSquare class >> of: aTFOperation [

	^self named: self operationType of: aTFOperation
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFElementWiseSquare class >> operationType [

	^'Square'
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFElementWiseSquare >> initializeNamed: aName of: aTFOperation [

	operand := aTFOperation.
	value :=
		operand currentComputation
			newOperationOf: self class operationType
			namePrefixed: aName
			with: operand
]

{ #category : 'Initialization' }
TFElementWiseSquare >> printOn: aStream [

	aStream nextPutAll: ('(<1p>)^2' expandMacrosWith: operand)
]
