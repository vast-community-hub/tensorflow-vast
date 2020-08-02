Class {
	#name : 'TFSubstraction',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'leftOperand',
		'rightOperand'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFSubstraction class >> named: anOperationName of: aLeftOperand minus: aRightOperand [

	^self new initializeNamed: anOperationName of: aLeftOperand minus: aRightOperand
]

{ #category : 'Instance Creation' }
TFSubstraction class >> of: aLeftOperand minus: aRightOperand [

	^self named: self operationType of: aLeftOperand minus: aRightOperand
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFSubstraction class >> operationType [

	^'Sub'
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFSubstraction >> initializeNamed: anOperationName of: aLeftOperand minus: aRightOperand [

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
TFSubstraction >> printOn: aStream [

	aStream nextPutAll: '('. 
	self print: leftOperand formattedOn: aStream. 
	aStream nextPutAll: ' - '. 
	self print: rightOperand formattedOn: aStream. 
	aStream nextPutAll: ')'. 
]
