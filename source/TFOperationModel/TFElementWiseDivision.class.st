Class {
	#name : 'TFElementWiseDivision',
	#superclass : 'TFOperationAbstract',
	#instVars : [
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

	^self named: self operationType of: aLeftOperand and: aRightOperand
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFElementWiseDivision class >> operationType [

	^'Div'
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFElementWiseDivision >> initializeNamed: anOperationName of: aLeftOperand and: aRightOperand [

	numerator := aLeftOperand.
	denominator := aRightOperand.
	value :=
		numerator currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			with: numerator
			with: denominator
]

{ #category : 'Printing' }
TFElementWiseDivision >> printOn: aStream [

	aStream nextPutAll: '('.
	self print: numerator formattedOn: aStream.
	aStream nextPutAll: ' / '.
	self print: denominator formattedOn: aStream.
	aStream nextPutAll: ')'
]
