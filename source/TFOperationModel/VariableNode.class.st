Class {
	#name : 'VariableNode',
	#superclass : 'TensorFlowOperationAbstract',
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

{ #category : 'Initialization',
  #vaVisibility : 'private' }
VariableNode >> initializeOn: aTensorFlowComputation named: aName of: aType shaped: aShape initializedWith: aVariableInitializer [

	value :=
		aTensorFlowComputation
			newOperationOf: self operationType
			namePrefixed: aName
			withAll: #()
			describedBy: [:description |
				description
					at: TFAttributeName dataType putType: aType;
					at: TFAttributeName shape putShape: aShape].
	aVariableInitializer applyTo: value
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
VariableNode >> operationType [

	^'Variable'
]
