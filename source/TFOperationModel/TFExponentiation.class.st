Class {
	#name : 'TFExponentiation',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'base',
		'exponent'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFExponentiation class >> named: aName of: aBased raisedTo: theNthPower [

	^self new initializeNamed: aName of: aBased raisedTo: theNthPower
]

{ #category : 'Instance Creation' }
TFExponentiation class >> of: aBased raisedTo: theNthPower [

	^self named: self operationType of: aBased raisedTo: theNthPower
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFExponentiation class >> operationType [

	^'Pow'
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFExponentiation >> initializeNamed: aName of: aBase raisedTo: theNthPower [

	base := aBase.
	exponent := theNthPower.
	value :=
		aBase currentComputation
			newOperationOf: self class operationType
			namePrefixed: aName
			with: base
			with: exponent
]

{ #category : 'Initialization' }
TFExponentiation >> printOn: aStream [

	aStream nextPutAll: ('<1p>^<2p>' expandMacrosWith: base with: exponent)
]
