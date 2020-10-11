Class {
	#name : 'AbsoluteValue',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'originalValue'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
AbsoluteValue class >> named: aName of: anOperation [

	^self new initializeNamed: aName of: anOperation
]

{ #category : 'Instance Creation' }
AbsoluteValue class >> of: anOperation [

	^self named: self operationType of: anOperation
]

{ #category : 'Instance Creation',
  #vaVisibility : 'private' }
AbsoluteValue class >> operationType [

	^'Abs'
]

{ #category : 'Accessing' }
AbsoluteValue >> currentComputation [

	^value currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
AbsoluteValue >> initializeNamed: aName of: anOperation [

	originalValue := anOperation.
	value :=
		originalValue currentComputation
			newOperationOf: self class operationType
			namePrefixed: aName
			with: originalValue
]

{ #category : 'Printing' }
AbsoluteValue >> printOn: aStream [


	aStream nextPutAll: ('abs(<1p>)' expandMacrosWith: originalValue)

]
