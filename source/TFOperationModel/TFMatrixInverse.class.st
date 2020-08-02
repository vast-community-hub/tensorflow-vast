Class {
	#name : 'TFMatrixInverse',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'tensor'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFMatrixInverse class >> named: anOperationName of: aTensor [

	^self new initializeNamed: anOperationName of: aTensor
]

{ #category : 'Instance Creation' }
TFMatrixInverse class >> of: aTensorOrFormula [

	^self named: self operationType of: aTensorOrFormula
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFMatrixInverse class >> operationType [

	^'MatrixInverse'
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFMatrixInverse >> initializeNamed: anOperationName of: aTensor [

	tensor := aTensor.
	value :=
		tensor currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			with: tensor
]
