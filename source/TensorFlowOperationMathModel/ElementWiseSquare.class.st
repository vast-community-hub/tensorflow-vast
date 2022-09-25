Class {
	#name : 'ElementWiseSquare',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'operand'
	],
	#category : 'TensorFlowOperationMathModel'
}

{ #category : 'Instance Creation' }
ElementWiseSquare class >> named: aName of: aTFOperation [

	^self new initializeNamed: aName of: aTFOperation
]

{ #category : 'Instance Creation' }
ElementWiseSquare class >> of: aTFOperation [

	^self named: self operationType of: aTFOperation
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
ElementWiseSquare class >> operationType [

	^'Square'
]

{ #category : 'Initialization' }
ElementWiseSquare >> currentComputation [

	^operand currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
ElementWiseSquare >> initializeNamed: aName of: aTFOperation [

	operand := aTFOperation.
	value :=
		self currentComputation
			newOperationOf: self class operationType
			namePrefixed: aName
			with: operand
]

{ #category : 'Initialization' }
ElementWiseSquare >> printOn: aStream [

	aStream nextPutAll: ('(<1p>)^2' expandMacrosWith: operand)
]
