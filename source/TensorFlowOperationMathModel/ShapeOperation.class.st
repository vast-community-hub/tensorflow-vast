Class {
	#name : 'ShapeOperation',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'tensor'
	],
	#category : 'TensorFlowOperationMathModel'
}

{ #category : 'Instance Creation' }
ShapeOperation class >> named: anOperationName of: anOperationNode [

	^self new initializeNamed: anOperationName of: anOperationNode
]

{ #category : 'Instance Creation' }
ShapeOperation class >> of: anOperationNode [

	^self named: self operationType of: anOperationNode
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
ShapeOperation class >> operationType [

	^'Shape'
]

{ #category : 'Accessing' }
ShapeOperation >> currentComputation [

	^tensor currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
ShapeOperation >> initializeNamed: anOperationName of: anOperationNode [

	tensor := anOperationNode.
	value :=
		self currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			with: anOperationNode
]
