Class {
	#name : 'MatrixInverse',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'tensor'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
MatrixInverse class >> named: anOperationName of: aTensor [

	^self new initializeNamed: anOperationName of: aTensor
]

{ #category : 'Instance Creation' }
MatrixInverse class >> of: aTensorOrFormula [

	^self named: self operationType of: aTensorOrFormula
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
MatrixInverse class >> operationType [

	^'MatrixInverse'
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
MatrixInverse >> initializeNamed: anOperationName of: aTensor [

	tensor := aTensor.
	value :=
		tensor currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			with: tensor
]
