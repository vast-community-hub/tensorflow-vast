Class {
	#name : 'TFElementWiseMultiplication',
	#superclass : 'TFOperationAbstract',
	#instVars : [
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

	^self named: self operationType of: aLeftOperand and: aRightOperand
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFElementWiseMultiplication class >> operationType [

	^'Mul'
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFElementWiseMultiplication >> initializeNamed: anOperationName of: aLeftOperand and: aRightOperand [

	leftOperand := aLeftOperand.
	rightOperand := aRightOperand.
	value :=
		leftOperand currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			with: leftOperand
			with: rightOperand
]

{ #category : 'Printing' }
TFElementWiseMultiplication >> printOn: aStream [

	aStream nextPutAll: '('.
	self print: leftOperand formattedOn: aStream.
	aStream nextPutAll: ' x '.
	self print: rightOperand formattedOn: aStream.
	aStream nextPutAll: ')'
]
