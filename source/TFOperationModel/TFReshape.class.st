Class {
	#name : 'TFReshape',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'operationName',
		'operand',
		'newShape'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFReshape class >> named: aName of: aTFOperation to: aNewShape [

	^self new initiailizeNamed: aName of: aTFOperation to: aNewShape
]

{ #category : 'Instance Creation' }
TFReshape class >> of: aTFOperation to: aNewShape [

	^self named: (aTFOperation value nameFor: 'Reshape') of: aTFOperation to: aNewShape
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFReshape >> calculateValue [

	^self binaryOperation: 'Reshape' between: operand and: newShape
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFReshape >> initiailizeNamed: aName of: aTFOperation to: aNewShape [

	operationName := aName.
	operand := aTFOperation.
	newShape := aNewShape.
	value := self calculateValue
]

{ #category : 'Accessing' }
TFReshape >> operationName [

	^operationName
]
