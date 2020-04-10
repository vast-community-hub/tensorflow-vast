Class {
	#name : 'TFIndexWithMinimum',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'operationName',
		'tensor',
		'axis'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFIndexWithMinimum class >> in: aTensor across: anAxis [

	^self named: (aTensor value nameFor: 'ArgMin') in: aTensor across: anAxis
]

{ #category : 'Instance Creation' }
TFIndexWithMinimum class >> named: anOperationName in: aTensor across: anAxis [

	^self new initializeNamed: anOperationName in: aTensor across: anAxis
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFIndexWithMinimum >> calculateValue [

	^self binaryOperation: 'ArgMin' between: tensor and: axis asInt32Tensor
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFIndexWithMinimum >> initializeNamed: anOperationName in: aTensor across: anAxis [
	
	operationName := anOperationName. 
	tensor := aTensor. 
	axis := anAxis.
	value := self calculateValue
]

{ #category : 'Accessing' }
TFIndexWithMinimum >> operationName [

	^operationName
]
