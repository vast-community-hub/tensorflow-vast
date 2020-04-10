Class {
	#name : 'TFElementWiseNegative',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'operationName',
		'operandToNegate'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFElementWiseNegative class >> named: aString negativeOf: aTFOperation [

	^self new initializeNamed: aString negativeOf: aTFOperation
]

{ #category : 'Instance Creation' }
TFElementWiseNegative class >> negativeOf: anOperand [

	^self named: (anOperand value nameFor: 'Neg') negativeOf: anOperand
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFElementWiseNegative >> calculateValue [

	^self unaryOperation: 'Neg' with: operandToNegate
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFElementWiseNegative >> initializeNamed: anOperationName negativeOf: anOperand [

	operationName := anOperationName.
	operandToNegate := anOperand.
	value := self calculateValue
]

{ #category : 'Accessing' }
TFElementWiseNegative >> operationName [

	^operationName
]

{ #category : 'Printing' }
TFElementWiseNegative >> printOn: aStream [

	aStream nextPutAll: '(- '.
	self print: operandToNegate formattedOn: aStream.
	aStream nextPutAll: ')'
]
