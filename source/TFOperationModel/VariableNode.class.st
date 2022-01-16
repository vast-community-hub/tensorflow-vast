Class {
	#name : 'VariableNode',
	#superclass : 'VariableNodeAbstract',
	#instVars : [
		'currentComputation',
		'currentValueAssigned'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
VariableNode class >> on: aComputation named: aName forFloatsShaped: aShape initializedWith: aVariableInitializer [

	^self
		on: aComputation
		named: aName
		of: FloatDataType new
		shaped: aShape
		initializedWith: aVariableInitializer
]

{ #category : 'Configuring' }
VariableNode >> assign: anOperation [

	currentValueAssigned :=
		currentComputation
			newOperationOf: 'Assign'
			namePrefixed: self operationName , '_initializer'
			with: self
			with: anOperation
]

{ #category : 'Accessing' }
VariableNode >> currentComputation [

	^currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
VariableNode >> initializeOn: aTensorFlowComputation named: aName of: aType shaped: aShape initializedWith: aVariableInitializer [

	currentComputation := aTensorFlowComputation.
	value :=
		currentComputation
			createVariableNamed: aName
			of: aType
			shaped: aShape
			initializedWith: aVariableInitializer.
	aVariableInitializer applyTo: self
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
VariableNode >> operationType [

	^'VariableV2'
]
