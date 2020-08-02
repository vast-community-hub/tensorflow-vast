Class {
	#name : 'TFReshape',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'operand',
		'newShape'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFReshape class >> named: aName of: aTFOperation to: aNewShape [

	^self new initiailizeNamed: aName of: aTFOperation to: aNewShape
]

{ #category : 'Instance Creation' }
TFReshape class >> of: aTFOperation to: aNewShape [

	^self named: self operationType of: aTFOperation to: aNewShape
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFReshape class >> operationType [

	^'Reshape'
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFReshape >> initiailizeNamed: aName of: aTFOperation to: aNewShape [

	operand := aTFOperation.
	newShape := aNewShape.
	value :=
		operand currentComputation
			newOperationOf: self class operationType
			namePrefixed: aName
			with: operand
			with: newShape
]
