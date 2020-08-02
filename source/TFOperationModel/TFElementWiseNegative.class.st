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

	^self named: self operationType negativeOf: anOperand
]

{ #category : 'Instance Creation',
  #vaVisibility : 'private' }
TFElementWiseNegative class >> operationType [

	^'Neg'
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFElementWiseNegative >> initializeNamed: anOperationName negativeOf: anOperand [

	operandToNegate := anOperand.
	value :=
		operandToNegate currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			with: operandToNegate
]

{ #category : 'Printing' }
TFElementWiseNegative >> printOn: aStream [

	aStream nextPutAll: '(- '.
	self print: operandToNegate formattedOn: aStream.
	aStream nextPutAll: ')'
]
