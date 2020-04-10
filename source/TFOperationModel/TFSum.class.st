Class {
	#name : 'TFSum',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'operationName',
		'operands'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFSum class >> named: anOperationName of: aLeftOperand plus: aRightOperand [

	^self named: anOperationName ofAll: (Array with: aLeftOperand with: aRightOperand)
]

{ #category : 'Instance Creation' }
TFSum class >> named: anOperationName ofAll: nodeCollection [

	^self new initializeNamed: anOperationName ofAll: nodeCollection
]

{ #category : 'Instance Creation' }
TFSum class >> of: aLeftOperand plus: aRightOperand [

	^self named: (aLeftOperand value nameFor: 'Add') of: aLeftOperand plus: aRightOperand
]

{ #category : 'Instance Creation' }
TFSum class >> ofAll: nodeCollection [

	^self named: (nodeCollection first value nameFor: 'AddN') ofAll: nodeCollection
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFSum >> calculateValue [

	| tf |

	tf := operands first currentComputation.
	^operands size = 2
		ifTrue: [
			tf
				newOperationOf: 'Add'
				named: self operationName
				with: operands first
				with: operands second]
		ifFalse: [tf newOperationOf: 'AddN' named: self operationName withList: operands]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFSum >> initializeNamed: anOperationName ofAll: nodes [

	operationName := anOperationName.
	operands := nodes.
	value := self calculateValue
]

{ #category : 'Accessing' }
TFSum >> operationName [

	^operationName
]
