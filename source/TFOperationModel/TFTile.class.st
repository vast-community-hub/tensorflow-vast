Class {
	#name : 'TFTile',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'operationName',
		'input',
		'multipleTimes'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFTile class >> named: aName replicating: aTensor by: aMultipleTimes [

	^self new initializeNamed: aName replicating: aTensor by: aMultipleTimes
]

{ #category : 'Instance Creation' }
TFTile class >> replicating: aTensor by: aMultipleTimes [

	^self named: 'Tile' replicating: aTensor by: aMultipleTimes
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFTile >> calculateValue [

	^self binaryOperation: 'Tile' between: input and: multipleTimes
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFTile >> initializeNamed: aName replicating: anInput by: aMultipleTimes [

	operationName := aName.
	input := anInput.
	multipleTimes := aMultipleTimes.
	value := self calculateValue
]

{ #category : 'Accessing' }
TFTile >> operationName [

	^operationName
]
