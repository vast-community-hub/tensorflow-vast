Class {
	#name : 'TFAddBias',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'addend',
		'bias',
		'operationName'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFAddBias class >> to: aTensorOrOperation with: aBias [

	^self new initializeTo: aTensorOrOperation with: aBias
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFAddBias >> calculateValue [

	^self binaryOperation: 'BiasAdd' between: addend and: bias
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFAddBias >> initializeTo: aTensorOrOperation with: aBias [
	
	operationName := aTensorOrOperation value graph nameFor: 'BiasAdd'.
	addend := aTensorOrOperation.
	bias := aBias.
	value := self calculateValue
]

{ #category : 'Accessing' }
TFAddBias >> operationName [

	^operationName
]
