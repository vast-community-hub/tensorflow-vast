Class {
	#name : 'MatrixMultiplication',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'leftOperand',
		'rightOperand',
		'customDescription',
		'currentComputation'
	],
	#category : 'TensorFlowOperationMathModel'
}

{ #category : 'Instance Creation' }
MatrixMultiplication class >> named: anOperationName of: aLeftOperand and: aRightOperand [


	^self named: anOperationName of: aLeftOperand and: aRightOperand customizedBy: [:d | ]
]

{ #category : 'Instance Creation' }
MatrixMultiplication class >> named: anOperationName of: aLeftOperand and: aRightOperand customizedBy: aDescription [

	^self new
		initializeNamed: anOperationName
		of: aLeftOperand
		and: aRightOperand
		customizedBy: aDescription
]

{ #category : 'Instance Creation' }
MatrixMultiplication class >> of: aLeftOperand and: aRightOperand [

	^self named: self operationType of: aLeftOperand and: aRightOperand
]

{ #category : 'Instance Creation' }
MatrixMultiplication class >> of: aLeftOperand andTransposed: aRightOperand [

	^self
		named: self operationType
		of: aLeftOperand
		and: aRightOperand
		customizedBy: [:d | d atTransposeBPut: true]
]

{ #category : 'Instance Creation' }
MatrixMultiplication class >> ofTransposed: aLeftOperand and: aRightOperand [

	^self
		named: self operationType
		of: aLeftOperand
		and: aRightOperand
		customizedBy: [:d | d atTransposeAPut: true]
]

{ #category : 'Instance Creation' }
MatrixMultiplication class >> ofTransposed: aLeftOperand andTransposed: aRightOperand [

	^self
		named: self operationType
		of: aLeftOperand
		and: aRightOperand
		customizedBy: [:d |
			d
				atTransposeAPut: true;
				atTransposeBPut: true]
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
MatrixMultiplication class >> operationType [

	^'MatMul'
]

{ #category : 'Accessing' }
MatrixMultiplication >> currentComputation [

	^currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
MatrixMultiplication >> initializeNamed: anOperationName of: aLeftOperand and: aRightOperand customizedBy: aDescription [
	
	currentComputation := aLeftOperand currentComputation.
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
MatrixMultiplication >> isFirstOperatorTransposed [

	^self value boolAt: TFAttributeName transposeA
]

{ #category : 'Accessing' }
MatrixMultiplication >> isSecondOperatorTransposed [

	^self value boolAt: TFAttributeName transposeB
]

{ #category : 'Printing' }
MatrixMultiplication >> printOn: aStream [

	aStream nextPutAll: '('.
	self print: leftOperand formattedOn: aStream.
	self isFirstOperatorTransposed ifTrue: [aStream nextPutAll: '^T'].
	aStream nextPutAll: ' x '.
	self print: rightOperand formattedOn: aStream.
	self isSecondOperatorTransposed ifTrue: [aStream nextPutAll: '^T'].
	aStream nextPutAll: ')'
]
