Class {
	#name : 'TFIndexWithMaximum',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'tensor',
		'axis'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFIndexWithMaximum class >> in: aTensor across: anAxis [

	^self named: self operationType in: aTensor across: anAxis
]

{ #category : 'Instance Creation' }
TFIndexWithMaximum class >> named: anOperationName in: aTensor across: anAxis [

	^self new initializeNamed: anOperationName in: aTensor across: anAxis
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFIndexWithMaximum class >> operationType [

	^'ArgMax'
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFIndexWithMaximum >> initializeNamed: anOperationName in: aTensor across: anAxis [

	tensor := aTensor.
	axis := anAxis.
	value :=
		tensor currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			with: tensor
			with: axis asInt32Tensor
]
