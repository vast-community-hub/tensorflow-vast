Class {
	#name : 'TFElementWiseDivision',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'operationName',
		'numerator',
		'denominator'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFElementWiseDivision class >> named: anOperationName of: aLeftOperand and: aRightOperand [

	^self new initializeNamed: anOperationName of: aLeftOperand and: aRightOperand
]

{ #category : 'Instance Creation' }
TFElementWiseDivision class >> of: aLeftOperand and: aRightOperand [

	^self named: (aLeftOperand value nameFor: 'Div') of: aLeftOperand and: aRightOperand
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFElementWiseDivision >> calculateValue [

	^self binaryOperation: 'Div' between: numerator and: denominator
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFElementWiseDivision >> initializeNamed: anOperationName of: aLeftOperand and: aRightOperand [

	operationName := anOperationName.
	numerator := aLeftOperand.
	denominator := aRightOperand.
	value := self calculateValue
]

{ #category : 'Accessing' }
TFElementWiseDivision >> operationName [

	^operationName
]

{ #category : 'Accessing' }
TFElementWiseDivision >> printOn: aStream [

	aStream nextPutAll: '('.
	self print: numerator formattedOn: aStream.
	aStream nextPutAll: ' / '.
	self print: denominator formattedOn: aStream.
	aStream nextPutAll: ')'
]
