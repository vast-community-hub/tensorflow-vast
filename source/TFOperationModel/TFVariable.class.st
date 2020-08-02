Class {
	#name : 'TFVariable',
	#superclass : 'TFOperationAbstract',
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFVariable class >> on: aComputation named: aName forFloatsShaped: aShape initializedWith: aVariableInitializer [

	^self
		on: aComputation
		named: aName
		of: TFTensor typeFloat
		shaped: aShape
		initializedWith: aVariableInitializer
]

{ #category : 'Instance Creation' }
TFVariable class >> on: aComputation named: aName of: aType shaped: aShape initializedWith: aVariableInitializer [

	^self new
		initializeOn: aComputation
		named: aName
		of: aType
		shaped: aShape
		initializedWith: aVariableInitializer
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFVariable >> initializeOn: aTensorFlowComputation named: aName of: aType shaped: aShape initializedWith: aVariableInitializer [

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
TFVariable >> operationType [

	^'Variable'
]
