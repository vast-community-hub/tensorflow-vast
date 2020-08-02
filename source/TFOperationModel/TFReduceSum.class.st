Class {
	#name : 'TFReduceSum',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'axis',
		'tensor'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFReduceSum class >> allAxisOf: aTFOperation [

	^(1 to: aTFOperation value outputDimensions) collect: [:axis | axis - 1]
]

{ #category : 'Instance Creation' }
TFReduceSum class >> named: anOperationName valuesIn: aTFOperation [

	^self named: anOperationName valuesIn: aTFOperation alongside: (self allAxisOf: aTFOperation)
]

{ #category : 'Instance Creation' }
TFReduceSum class >> named: anOperationName valuesIn: aTensor alongside: anAxis [

	^self new initializeNamed: anOperationName sumValuesIn: aTensor alongside: anAxis
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFReduceSum class >> operationType [

	^'Sum'
]

{ #category : 'Instance Creation' }
TFReduceSum class >> valuesIn: aTFOperation [

	^self valuesIn: aTFOperation alongside: (self allAxisOf: aTFOperation)
]

{ #category : 'Instance Creation' }
TFReduceSum class >> valuesIn: aTensor alongside: anAxis [

	^self named: self operationType valuesIn: aTensor alongside: anAxis
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFReduceSum >> initializeNamed: anOperationName sumValuesIn: aTensor alongside: anAxis [

	tensor := aTensor.
	axis := anAxis.
	value :=
		tensor currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			with: tensor
			with: axis asInt32Tensor
]
