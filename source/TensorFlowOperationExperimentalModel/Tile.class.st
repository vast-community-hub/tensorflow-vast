Class {
	#name : 'Tile',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'input',
		'multipleTimes'
	],
	#category : 'TensorFlowOperationExperimentalModel'
}

{ #category : 'Instance Creation' }
Tile class >> named: aName replicating: aTensor by: aMultipleTimes [

	^self new initializeNamed: aName replicating: aTensor by: aMultipleTimes
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
Tile class >> operationType [

	^'Tile'
]

{ #category : 'Instance Creation' }
Tile class >> replicating: aTensor by: aMultipleTimes [

	^self named: self operationType replicating: aTensor by: aMultipleTimes
]

{ #category : 'Accessing' }
Tile >> currentComputation [

	^input currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Tile >> initializeNamed: aName replicating: anInput by: aMultipleTimes [

	input := anInput.
	multipleTimes := aMultipleTimes.
	value :=
		self currentComputation
			newOperationOf: self class operationType
			namePrefixed: aName
			with: input
			with: multipleTimes
]
