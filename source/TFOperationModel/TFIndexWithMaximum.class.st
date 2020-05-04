Class {
	#name : 'TFIndexWithMaximum',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'operationName',
		'tensor',
		'axis'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFIndexWithMaximum class >> in: aTensor across: anAxis [

	^self named: (aTensor value nameFor: 'ArgMin') in: aTensor across: anAxis
]

{ #category : 'Instance Creation' }
TFIndexWithMaximum class >> named: anOperationName in: aTensor across: anAxis [

	^self new initializeNamed: anOperationName in: aTensor across: anAxis
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFIndexWithMaximum >> calculateValue [

	^self binaryOperation: 'ArgMax' between: tensor and: axis asInt32Tensor
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFIndexWithMaximum >> initializeNamed: anOperationName in: aTensor across: anAxis [

	operationName := anOperationName.
	tensor := aTensor.
	axis := anAxis.
	value := self calculateValue.
	" this is because the name desired can be changed with a suffix or preffix when written to graph. 
	 should be a better way to do this" 
	operationName := value operationName 
	
]

{ #category : 'Accessing' }
TFIndexWithMaximum >> operationName [

	^operationName
]
