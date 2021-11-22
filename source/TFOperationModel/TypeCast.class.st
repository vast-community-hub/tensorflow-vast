Class {
	#name : 'TypeCast',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'castedTensor',
		'targetType'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TypeCast class >> named: anOperationName of: anOperation to: aDataType [

	^self new initializeNamed: anOperationName of: anOperation to: aDataType
]

{ #category : 'Instance Creation' }
TypeCast class >> of: anOperation to: aDataType [

	^self named: self operationType of: anOperation to: aDataType
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TypeCast class >> operationType [

	^'Cast'
]

{ #category : 'Accessing' }
TypeCast >> currentComputation [

	^castedTensor currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TypeCast >> initializeNamed: anOperationName of: anOperation to: aDataType [

	castedTensor := anOperation.
	targetType := aDataType.

	value :=
		self currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			withAll: (Array with: castedTensor)
			describedBy: [:description | description at: 'DstT' putType: targetType]


]

{ #category : 'Printing' }
TypeCast >> printOn: aStream [

	aStream nextPutAll:
		('<1p> casted to <2s>' expandMacrosWith: castedTensor with: targetType description)
]
