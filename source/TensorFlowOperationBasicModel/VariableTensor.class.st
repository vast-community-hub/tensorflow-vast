Class {
	#name : 'VariableTensor',
	#superclass : 'VariableTensorAbstract',
	#instVars : [
		'currentComputation',
		'currentValueAssigned'
	],
	#category : 'TensorFlowOperationBasicModel'
}

{ #category : 'Instance Creation' }
VariableTensor class >> on: aComputation named: aName filledWithZerosLike: anOperation [

	^self
		on: aComputation
		named: aName
		of: anOperation value outputType
		shaped: anOperation value outputShape
		initializedWith: ConstantInitializer withZeros
]

{ #category : 'Instance Creation' }
VariableTensor class >> on: aComputation named: aName forFloatsShaped: aShape initializedWith: aVariableInitializer [

	^self
		on: aComputation
		named: aName
		of: FloatDataType new
		shaped: aShape
		initializedWith: aVariableInitializer
]

{ #category : 'Instance Creation' }
VariableTensor class >> on: aComputation named: aName with: aTensor [

	^self
		on: aComputation
		named: aName
		of: aTensor type
		shaped: aTensor shape
		initializedWith: (ConstantInitializer with: aTensor)
]

{ #category : 'Configuring' }
VariableTensor >> assign: anOperation [

	currentValueAssigned :=
		currentComputation
			newOperationOf: 'Assign'
			namePrefixed: self operationName , '_initializer'
			with: self
			with: anOperation
]

{ #category : 'Accessing' }
VariableTensor >> currentComputation [

	^currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
VariableTensor >> initializeOn: aTensorFlowComputation named: aName of: aType shaped: aShape initializedWith: aVariableInitializer [

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
VariableTensor >> operationType [

	^'VariableV2'
]
