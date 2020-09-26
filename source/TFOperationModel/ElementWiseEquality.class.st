Class {
	#name : 'ElementWiseEquality',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'currentComputation'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
ElementWiseEquality class >> between: aTensor and: anExpectedTensor [

	^self named: self operationType between: aTensor and: anExpectedTensor
]

{ #category : 'Instance Creation' }
ElementWiseEquality class >> named: anOperationName between: aTensor and: anExpectedTensor [

	^self new initializeNamed: anOperationName between: aTensor and: anExpectedTensor
]

{ #category : 'Instance Creation',
  #vaVisibility : 'private' }
ElementWiseEquality class >> operationType [

	^'Equal'
]

{ #category : 'Accessing' }
ElementWiseEquality >> currentComputation [

	^currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
ElementWiseEquality >> initializeNamed: anOperationName between: aTensor and: anExpectedTensor [

	currentComputation := aTensor currentComputation.
	value :=
		self currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			with: aTensor
			with: anExpectedTensor
]
