Class {
	#name : 'TFElementWiseSquare',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'operationName',
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

	^self named: (aTFOperation value nameFor: 'Square') of: aTFOperation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFElementWiseSquare >> calculateValue [

	^self unaryOperation: 'Square' with: operand
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFElementWiseSquare >> initializeNamed: aName of: aTFOperation [

	operationName := aName.
	operand := aTFOperation.
	value := self calculateValue
]

{ #category : 'Accessing' }
TFElementWiseSquare >> operationName [
	
	^operationName
]
