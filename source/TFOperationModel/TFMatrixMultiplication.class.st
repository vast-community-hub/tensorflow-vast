Class {
	#name : 'TFMatrixMultiplication',
	#superclass : 'TFOperationAbstract',
	#instVars : [
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

	^self named: self operationType of: aLeftOperand and: aRightOperand
]

{ #category : 'Instance Creation' }
TFMatrixMultiplication class >> of: aLeftOperand andTransposed: aRightOperand [

	^self
		named: self operationType
		of: aLeftOperand
		and: aRightOperand
		customizedBy: [:d | d at: TFAttributeName transposeB putBoolean: true]
]

{ #category : 'Instance Creation' }
TFMatrixMultiplication class >> ofTransposed: aLeftOperand and: aRightOperand [

	^self
		named: self operationType
		of: aLeftOperand
		and: aRightOperand
		customizedBy: [:d | d at: TFAttributeName transposeA putBoolean: true]
]

{ #category : 'Instance Creation' }
TFMatrixMultiplication class >> ofTransposed: aLeftOperand andTransposed: aRightOperand [

	^self
		named: self operationType
		of: aLeftOperand
		and: aRightOperand
		customizedBy: [:d |
			d
				at: TFAttributeName transposeA putBoolean: true;
				at: TFAttributeName transposeB putBoolean: true]
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFMatrixMultiplication class >> operationType [

	^'MatMul'
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFMatrixMultiplication >> initializeNamed: anOperationName of: aLeftOperand and: aRightOperand customizedBy: aDescription [

	leftOperand := aLeftOperand.
	rightOperand := aRightOperand.
	customDescription := aDescription.
	value :=
		leftOperand currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			withAll: (Array with: leftOperand with: rightOperand)
			describedBy: customDescription
]

{ #category : 'Accessing' }
TFMatrixMultiplication >> isFirstOperatorTransposed [

	^self value boolAt: TFAttributeName transposeA
]

{ #category : 'Accessing' }
TFMatrixMultiplication >> isSecondOperatorTransposed [

	^self value boolAt: TFAttributeName transposeB
]

{ #category : 'Printing' }
TFMatrixMultiplication >> printOn: aStream [

	aStream nextPutAll: '('.
	self print: leftOperand formattedOn: aStream.
	aStream nextPutAll: ' x '.
	self print: rightOperand formattedOn: aStream.
	aStream nextPutAll: ')'
]
