Class {
	#name : 'Sum',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'operands'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
Sum class >> named: anOperationName of: aLeftOperand plus: aRightOperand [

	^self named: anOperationName ofAll: (Array with: aLeftOperand with: aRightOperand)
]

{ #category : 'Instance Creation' }
Sum class >> named: anOperationName ofAll: nodeCollection [

	^self new initializeNamed: anOperationName ofAll: nodeCollection
]

{ #category : 'Instance Creation' }
Sum class >> of: aLeftOperand plus: aRightOperand [

	^self named: 'Add' of: aLeftOperand plus: aRightOperand
]

{ #category : 'Instance Creation' }
Sum class >> ofAll: nodeCollection [

	^self named: 'AddN' ofAll: nodeCollection
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Sum >> initializeNamed: anOperationName ofAll: nodes [

	| tf |

	operands := nodes.
	tf := operands first currentComputation.
	value :=
		operands size = 2
			ifTrue: [
				tf
					newOperationOf: 'Add'
					namePrefixed: anOperationName
					with: operands first
					with: operands second]
			ifFalse: [tf newOperationOf: 'AddN' namePrefixed: anOperationName withList: operands]
]

{ #category : 'Initialization' }
Sum >> printOn: aStream [

	operands doWithIndex: [:each :index |
		aStream print: each.
		index < operands size ifTrue: [aStream nextPutAll: ' + ']]
]
