Class {
	#name : 'Reshape',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'operand',
		'newShape'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
Reshape class >> named: aName of: aTFOperation to: aNewShape [

	^self new initiailizeNamed: aName of: aTFOperation to: aNewShape
]

{ #category : 'Instance Creation' }
Reshape class >> of: aTFOperation to: aNewShape [

	^self named: self operationType of: aTFOperation to: aNewShape
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
Reshape class >> operationType [

	^'Reshape'
]

{ #category : 'Accessing' }
Reshape >> currentComputation [

	^operand currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Reshape >> initiailizeNamed: aName of: aTFOperation to: aNewShape [

	operand := aTFOperation.
	newShape := aNewShape.
	value :=
		self currentComputation
			newOperationOf: self class operationType
			namePrefixed: aName
			with: operand
			with: newShape
]
