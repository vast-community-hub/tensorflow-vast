Class {
	#name : 'TFReciprocal',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'operationName',
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

	^self named: 'Reciprocal' of: anOperation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFReciprocal >> calculateValue [

	^self unaryOperation: 'Reciprocal' with: operation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFReciprocal >> initializeNamed: aName of: anOperation [

	operationName := aName.
	operation := anOperation.
	value := self calculateValue
]

{ #category : 'Accessing' }
TFReciprocal >> operationName [
	
	^operationName
]
