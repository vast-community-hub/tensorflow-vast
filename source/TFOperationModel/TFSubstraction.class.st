Class {
	#name : 'TFSubstraction',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'operationName',
		'leftOperand',
		'rightOperand'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFSubstraction class >> named: anOperationName of: aLeftOperand minus: aRightOperand [

	^super new initializeNamed: anOperationName of: aLeftOperand minus: aRightOperand
]

{ #category : 'Instance Creation' }
TFSubstraction class >> of: aLeftOperand minus: aRightOperand [

	^self named: (aLeftOperand value nameFor: 'Sub') of: aLeftOperand minus: aRightOperand
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFSubstraction >> calculateValue [

	^self binaryOperation: 'Sub' between: leftOperand and: rightOperand
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFSubstraction >> initializeNamed: anOperationName of: aLeftOperand minus: aRightOperand [

	operationName := anOperationName.
	leftOperand := aLeftOperand.
	rightOperand := aRightOperand.
	value := self calculateValue
]

{ #category : 'Initialization' }
TFSubstraction >> operationName [

	^operationName
]

{ #category : 'Initialization' }
TFSubstraction >> printOn: aStream [

	aStream nextPutAll: '('. 
	self print: leftOperand formattedOn: aStream. 
	aStream nextPutAll: ' - '. 
	self print: rightOperand formattedOn: aStream. 
	aStream nextPutAll: ')'. 
]
