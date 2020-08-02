Class {
	#name : 'TFTile',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'input',
		'multipleTimes'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFTile class >> named: aName replicating: aTensor by: aMultipleTimes [

	^self new initializeNamed: aName replicating: aTensor by: aMultipleTimes
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFTile class >> operationType [

	^'Tile'
]

{ #category : 'Instance Creation' }
TFTile class >> replicating: aTensor by: aMultipleTimes [

	^self named: self operationType replicating: aTensor by: aMultipleTimes
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFTile >> initializeNamed: aName replicating: anInput by: aMultipleTimes [

	input := anInput.
	multipleTimes := aMultipleTimes.
	value :=
		input currentComputation
			newOperationOf: self class operationType
			namePrefixed: aName
			with: input
			with: multipleTimes
]
