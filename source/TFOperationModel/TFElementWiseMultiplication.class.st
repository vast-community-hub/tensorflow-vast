Class {
	#name : 'TFElementWiseMultiplication',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'operationName',
		'leftOperand',
		'rightOperand'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFElementWiseMultiplication class >> named: anOperationName of: aLeftOperand and: aRightOperand [

	^self new initializeNamed: anOperationName of: aLeftOperand and: aRightOperand
]

{ #category : 'Instance Creation' }
TFElementWiseMultiplication class >> of: aLeftOperand and: aRightOperand [

	^self named: 'Mul' of: aLeftOperand and: aRightOperand
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFElementWiseMultiplication >> calculateValue [

	^self binaryOperation: 'Mul' between: leftOperand and: rightOperand
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFElementWiseMultiplication >> initializeNamed: anOperationName of: aLeftOperand and: aRightOperand [

	operationName := anOperationName.
	leftOperand := aLeftOperand.
	rightOperand := aRightOperand.
	value := self calculateValue
]

{ #category : 'Accessing' }
TFElementWiseMultiplication >> operationName [

	^operationName
]

{ #category : 'Accessing' }
TFElementWiseMultiplication >> printOn: aStream [

	aStream nextPutAll: '('.
	self print: leftOperand formattedOn: aStream.
	aStream nextPutAll: ' x '.
	self print: rightOperand formattedOn: aStream.
	aStream nextPutAll: ')'
]
