Class {
	#name : 'ElementWiseDivision',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'numerator',
		'denominator'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
ElementWiseDivision class >> named: anOperationName of: aLeftOperand and: aRightOperand [

	^self new initializeNamed: anOperationName of: aLeftOperand and: aRightOperand
]

{ #category : 'Instance Creation' }
ElementWiseDivision class >> of: aLeftOperand and: aRightOperand [

	^self named: self operationType of: aLeftOperand and: aRightOperand
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
ElementWiseDivision class >> operationType [

	^'Div'
]

{ #category : 'Accessing' }
ElementWiseDivision >> currentComputation [

	^numerator currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
ElementWiseDivision >> initializeNamed: anOperationName of: aLeftOperand and: aRightOperand [

	numerator := aLeftOperand.
	denominator := aRightOperand.
	value :=
		self currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			with: numerator
			with: denominator
]

{ #category : 'Printing' }
ElementWiseDivision >> printOn: aStream [

	aStream nextPutAll: '('.
	self print: numerator formattedOn: aStream.
	aStream nextPutAll: ' / '.
	self print: denominator formattedOn: aStream.
	aStream nextPutAll: ')'
]
