Class {
	#name : 'TFReduceMean',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'operationName',
		'axis',
		'tensor'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFReduceMean class >> named: anOperationName ofValuesIn: aTensor alongside: anAxis [

	^self new initializeNamed: anOperationName ofValuesIn: aTensor alongside: anAxis
]

{ #category : 'Instance Creation' }
TFReduceMean class >> ofValuesIn: aTFOperation [

	| allAxis |

	allAxis := (1 to: aTFOperation value outputDimensions) collect: [:axis | axis - 1].

	^self ofValuesIn: aTFOperation alongside: allAxis
]

{ #category : 'Instance Creation' }
TFReduceMean class >> ofValuesIn: aTensor alongside: anAxis [

	^self named: (aTensor value graph nameFor: 'Mean') ofValuesIn: aTensor alongside: anAxis
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFReduceMean >> calculateValue [

	^self binaryOperation: 'Mean' between: tensor and: axis asInt32Tensor
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFReduceMean >> initializeNamed: anOperationName ofValuesIn: aTensor alongside: anAxis [

	operationName := anOperationName.
	tensor := aTensor.
	axis := anAxis.
	value := self calculateValue
]

{ #category : 'Accessing' }
TFReduceMean >> operationName [

	^operationName
]
