Class {
	#name : 'TFMatrixInverse',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'operationName',
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

	^self named: (aTensorOrFormula value nameFor: 'MatrixInverse') of: aTensorOrFormula
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFMatrixInverse >> calculateValue [

	^self unaryOperation: 'MatrixInverse' with: tensor
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFMatrixInverse >> initializeNamed: anOperationName of: aTensor [

	operationName := anOperationName.
	tensor := aTensor.
	value := self calculateValue
]

{ #category : 'Accessing' }
TFMatrixInverse >> operationName [

	^operationName
]
