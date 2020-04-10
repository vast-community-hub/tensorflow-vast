Class {
	#name : 'TFReduceSum',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'operationName',
		'axis',
		'tensor'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFReduceSum class >> named: anOperationName valuesIn: aTensor alongside: anAxis [

	^self new initializeNamed: anOperationName sumValuesIn: aTensor alongside: anAxis
]

{ #category : 'Instance Creation' }
TFReduceSum class >> valuesIn: aTFOperation [

	| allAxis |

	allAxis := (1 to: aTFOperation value outputDimensions) collect: [:axis | axis - 1].

	^self valuesIn: aTFOperation alongside: allAxis
]

{ #category : 'Instance Creation' }
TFReduceSum class >> valuesIn: aTensor alongside: anAxis [

	^self named: (aTensor value nameFor: 'Sum') valuesIn: aTensor alongside: anAxis
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFReduceSum >> calculateValue [

	^self binaryOperation: 'Sum' between: tensor and: axis asInt32Tensor
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFReduceSum >> initializeNamed: anOperationName sumValuesIn: aTensor alongside: anAxis [

	operationName := anOperationName. 
	tensor := aTensor. 
	axis := anAxis. 
	value := self calculateValue
]

{ #category : 'Accessing' }
TFReduceSum >> operationName [

	^operationName
]
