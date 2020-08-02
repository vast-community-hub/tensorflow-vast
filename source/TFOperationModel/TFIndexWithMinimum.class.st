Class {
	#name : 'TFIndexWithMinimum',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'tensor',
		'axis'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFIndexWithMinimum class >> in: aTensor across: anAxis [

	^self named: self operationType in: aTensor across: anAxis
]

{ #category : 'Instance Creation' }
TFIndexWithMinimum class >> named: anOperationName in: aTensor across: anAxis [

	^self new initializeNamed: anOperationName in: aTensor across: anAxis
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFIndexWithMinimum class >> operationType [

	^'ArgMin'
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFIndexWithMinimum >> initializeNamed: anOperationName in: aTensor across: anAxis [

	tensor := aTensor.
	axis := anAxis.
	value :=
		tensor currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			with: tensor
			with: axis asInt32Tensor
]
