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
			newOperationOf: 'Variable'
			named: aName
			withAll: #()
			describedBy: [:description |
				description
					at: 'dtype' putType: aType;
					at: 'shape' putShape: aShape].
	aVariableInitializer applyTo: value
]
