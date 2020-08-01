Class {
	#name : 'TFMatrixMultiplication',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'operationName',
		'leftOperand',
		'rightOperand',
		'customDescription'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFMatrixMultiplication class >> named: anOperationName of: aLeftOperand and: aRightOperand [


	^self named: anOperationName of: aLeftOperand and: aRightOperand customizedBy: [:d | ]
]

{ #category : 'Instance Creation' }
TFMatrixMultiplication class >> named: anOperationName of: aLeftOperand and: aRightOperand customizedBy: aDescription [

	^self new
		initializeNamed: anOperationName
		of: aLeftOperand
		and: aRightOperand
		customizedBy: aDescription
]

{ #category : 'Instance Creation' }
TFMatrixMultiplication class >> of: aLeftOperand and: aRightOperand [

	^self named: (aLeftOperand value nameFor: 'MatMul') of: aLeftOperand and: aRightOperand
]

{ #category : 'Instance Creation' }
TFMatrixMultiplication class >> of: aLeftOperand andTransposed: aRightOperand [

	^self
		named: (aLeftOperand value graph nameFor: 'MatMul')
		of: aLeftOperand
		and: aRightOperand
		customizedBy: [:d | d at: 'transpose_b' putBoolean: true]
]

{ #category : 'Instance Creation' }
TFMatrixMultiplication class >> ofTransposed: aLeftOperand and: aRightOperand [

	^self
		named: (aLeftOperand value nameFor: 'MatMul')
		of: aLeftOperand
		and: aRightOperand
		customizedBy: [:d | d at: 'transpose_a' putBoolean: true]
]

{ #category : 'Instance Creation' }
TFMatrixMultiplication class >> ofTransposed: aLeftOperand andTransposed: aRightOperand [

	^self
		named: (aLeftOperand value graph nameFor: 'MatMul')
		of: aLeftOperand
		and: aRightOperand
		customizedBy: [:d |
			d
				at: 'transpose_a' putBoolean: true;
				at: 'transpose_b' putBoolean: true]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFMatrixMultiplication >> calculateValue [

	^leftOperand currentComputation
		newOperationOf: 'MatMul'
		named: self operationName
		withAll: (Array with: leftOperand with: rightOperand)
		describedBy: customDescription
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFMatrixMultiplication >> initializeNamed: anOperationName of: aLeftOperand and: aRightOperand customizedBy: aDescription [

	operationName := anOperationName.
	leftOperand := aLeftOperand.
	rightOperand := aRightOperand.
	customDescription := aDescription.
	value := self calculateValue
]

{ #category : 'Accessing' }
TFMatrixMultiplication >> isFirstOperatorTransposed [

	^self value boolAt: 'transpose_a'
]

{ #category : 'Accessing' }
TFMatrixMultiplication >> isSecondOperatorTransposed [

	^self value boolAt: 'transpose_b'
]

{ #category : 'Accessing' }
TFMatrixMultiplication >> operationName [

	^operationName
]

{ #category : 'Printing' }
TFMatrixMultiplication >> printOn: aStream [

	aStream nextPutAll: '('.
	self print: leftOperand formattedOn: aStream.
	aStream nextPutAll: ' x '.
	self print: rightOperand formattedOn: aStream.
	aStream nextPutAll: ')'
]
