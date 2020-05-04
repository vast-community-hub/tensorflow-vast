Class {
	#name : 'TFAbsoluteValue',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'operationName'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFAbsoluteValue class >> named: aName of: anOperation [

	^self new initializeNamed: aName of: anOperation
]

{ #category : 'Instance Creation' }
TFAbsoluteValue class >> of: anOperation [

	^self named: 'Abs' of: anOperation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFAbsoluteValue >> initializeNamed: aName of: anOperation [

	operationName := aName.
	value := self unaryOperation: 'Abs' with: anOperation
]

{ #category : 'Accessing' }
TFAbsoluteValue >> operationName [

	^operationName
]
