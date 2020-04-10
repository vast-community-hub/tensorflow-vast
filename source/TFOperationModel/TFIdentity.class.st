Class {
	#name : 'TFIdentity',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'operationName'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFIdentity class >> of: aTensor evaluatedOnlyAfter: anOperationCollection [

	^self new
		initializeOf: aTensor
		describedBy: [:d |
			anOperationCollection do: [:operation | d addControlInput: operation value]]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFIdentity >> initializeOf: aTensor describedBy: aBlock [

	operationName := aTensor value nameFor: 'Identity'.
	value := aTensor value op: 'Identity' withAll: Array new named: operationName described: aBlock
]

{ #category : 'Initialization' }
TFIdentity >> operationName [

	^operationName
]
