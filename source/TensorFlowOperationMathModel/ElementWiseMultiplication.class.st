Class {
	#name : 'ElementWiseMultiplication',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'leftOperand',
		'rightOperand'
	],
	#category : 'TensorFlowOperationMathModel'
}

{ #category : 'Instance Creation' }
ElementWiseMultiplication class >> named: anOperationName of: aLeftOperand and: aRightOperand [

	^self new initializeNamed: anOperationName of: aLeftOperand and: aRightOperand
]

{ #category : 'Instance Creation' }
ElementWiseMultiplication class >> of: aLeftOperand and: aRightOperand [

	^self named: self operationType of: aLeftOperand and: aRightOperand
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
ElementWiseMultiplication class >> operationType [

	^'Mul'
]

{ #category : 'Accessing' }
ElementWiseMultiplication >> currentComputation [

	^leftOperand currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
ElementWiseMultiplication >> initializeNamed: anOperationName of: aLeftOperand and: aRightOperand [

	leftOperand := aLeftOperand.
	rightOperand := aRightOperand.
	value :=
		self currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			with: leftOperand
			with: rightOperand
]

{ #category : 'Printing' }
ElementWiseMultiplication >> printOn: aStream [

	aStream nextPutAll: '('.
	self print: leftOperand formattedOn: aStream.
	aStream nextPutAll: ' x '.
	self print: rightOperand formattedOn: aStream.
	aStream nextPutAll: ')'
]
