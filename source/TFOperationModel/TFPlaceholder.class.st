Class {
	#name : 'TFPlaceholder',
	#superclass : 'TFOperationAbstract',
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFPlaceholder class >> on: aComputation named: anInputName of: aType [

	^self new initializeOn: aComputation named: anInputName of: aType
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFPlaceholder >> initializeOn: aTensorFlowComputation named: aName of: aType [

	value :=
		aTensorFlowComputation
			newOperationOf: self operationType
			namePrefixed: aName
			withAll: #()
			describedBy: [:description | description at: TFAttributeName dataType putType: aType]
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFPlaceholder >> operationType [

	^'Placeholder'
]
