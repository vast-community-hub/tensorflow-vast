Class {
	#name : 'ResourceVariableNode',
	#superclass : 'VariableNodeAbstract',
	#instVars : [
		'currentComputation',
		'currentValueAssigned',
		'dataType',
		'resource',
		'variableReader'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Accessing' }
ResourceVariableNode >> assign: anOperation [

	currentValueAssigned :=
		currentComputation
			newOperationOf: 'AssignVariableOp'
			namePrefixed: self operationName , '_initializer'
			with: self
			with: anOperation
]

{ #category : 'Accessing' }
ResourceVariableNode >> assignedValue [

	^variableReader
]

{ #category : 'Accessing' }
ResourceVariableNode >> currentComputation [

	^currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
ResourceVariableNode >> initializeOn: aTensorFlowComputation named: aName of: aType shaped: aShape initializedWith: aVariableInitializer [

	currentComputation := aTensorFlowComputation.
	value :=
		currentComputation
			newOperationOf: 'VarHandleOp'
			namePrefixed: aName
			withAll: #()
			describedBy: [:description |
				description
					atDataTypePut: aType;
					atShapePut: aShape;
					at: 'shared_name' putString: aName].
	variableReader :=
		self currentComputation
			newOperationOf: 'ReadVariableOp'
			namePrefixed: self operationName , 'reader'
			withAll: { value }
			describedBy: [:description | description atDataTypePut: aType].
	aVariableInitializer ifNotNil: [aVariableInitializer applyTo: self]
]

{ #category : 'Accessing' }
ResourceVariableNode >> operationName [

	^value operationName
]
