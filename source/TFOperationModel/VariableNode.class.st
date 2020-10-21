Class {
	#name : 'VariableNode',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'currentComputation'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
VariableNode class >> on: aComputation named: aName forFloatsShaped: aShape initializedWith: aVariableInitializer [

	^self
		on: aComputation
		named: aName
		of: TFTensor typeFloat
		shaped: aShape
		initializedWith: aVariableInitializer
]

{ #category : 'Instance Creation' }
VariableNode class >> on: aComputation named: aName of: aType shaped: aShape initializedWith: aVariableInitializer [

	^self new
		initializeOn: aComputation
		named: aName
		of: aType
		shaped: aShape
		initializedWith: aVariableInitializer
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
		aTensorFlowComputation
			newOperationOf: self operationType
			namePrefixed: aName
			withAll: #()
			describedBy: [:description |
				description
					atDataTypePut: aType;
					atShapePut: aShape].
	aVariableInitializer applyTo: value
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
VariableNode >> operationType [

	^'Variable'
]
