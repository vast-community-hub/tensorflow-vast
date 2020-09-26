Class {
	#name : 'Exponentiation',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'base',
		'exponent'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
Exponentiation class >> named: aName of: aBased raisedTo: theNthPower [

	^self new initializeNamed: aName of: aBased raisedTo: theNthPower
]

{ #category : 'Instance Creation' }
Exponentiation class >> of: aBased raisedTo: theNthPower [

	^self named: self operationType of: aBased raisedTo: theNthPower
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
Exponentiation class >> operationType [

	^'Pow'
]

{ #category : 'Accessing' }
Exponentiation >> currentComputation [

	^base currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Exponentiation >> initializeNamed: aName of: aBase raisedTo: theNthPower [

	base := aBase.
	exponent := theNthPower.
	value :=
		self currentComputation
			newOperationOf: self class operationType
			namePrefixed: aName
			with: base
			with: exponent
]

{ #category : 'Initialization' }
Exponentiation >> printOn: aStream [

	aStream nextPutAll: ('<1p>^<2p>' expandMacrosWith: base with: exponent)
]
