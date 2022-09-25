Class {
	#name : 'ResourceVariable',
	#superclass : 'VariableTensorAbstract',
	#instVars : [
		'currentComputation',
		'currentValueAssigned',
		'dataType',
		'resource',
		'variableReader'
	],
	#category : 'TensorFlowOperationBasicModel'
}

{ #category : 'Accessing' }
ResourceVariable >> assign: anOperation [

	currentValueAssigned :=
		currentComputation
			newOperationOf: 'AssignVariableOp'
			namePrefixed: self operationName , '_initializer'
			with: self
			with: anOperation
]

{ #category : 'Accessing' }
ResourceVariable >> assignedValue [

	^variableReader
]

{ #category : 'Accessing' }
ResourceVariable >> currentComputation [

	^currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
ResourceVariable >> initializeOn: aTensorFlowComputation named: aName of: aType shaped: aShape initializedWith: aVariableInitializer [

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
					atSharedNamePut: aName].
	variableReader :=
		self currentComputation
			newOperationOf: 'ReadVariableOp'
			namePrefixed: self operationName , 'reader'
			withAll: { value }
			describedBy: [:description | description atDataTypePut: aType].
	aVariableInitializer ifNotNil: [aVariableInitializer applyTo: self]
]

{ #category : 'Accessing' }
ResourceVariable >> operationName [

	^value operationName
]
