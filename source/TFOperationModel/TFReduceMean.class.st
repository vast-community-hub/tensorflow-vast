Class {
	#name : 'TFReduceMean',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'axis',
		'tensor'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFReduceMean class >> allAxisOf: aTFOperation [

	^(1 to: aTFOperation value outputDimensions) collect: [:axis | axis - 1]
]

{ #category : 'Instance Creation' }
TFReduceMean class >> named: aName ofValuesIn: aTFOperation [

	^self named: aName ofValuesIn: aTFOperation alongside: (self allAxisOf: aTFOperation)
]

{ #category : 'Instance Creation' }
TFReduceMean class >> named: anOperationName ofValuesIn: aTensor alongside: anAxis [

	^self new initializeNamed: anOperationName ofValuesIn: aTensor alongside: anAxis
]

{ #category : 'Instance Creation' }
TFReduceMean class >> ofValuesIn: aTFOperation [

	^self ofValuesIn: aTFOperation alongside: (self allAxisOf: aTFOperation)
]

{ #category : 'Instance Creation' }
TFReduceMean class >> ofValuesIn: aTensor alongside: anAxis [

	^self named: self operationType ofValuesIn: aTensor alongside: anAxis
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFReduceMean class >> operationType [

	^'Mean'
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFReduceMean >> initializeNamed: anOperationName ofValuesIn: aTensor alongside: anAxis [

	tensor := aTensor.
	axis := anAxis.
	value :=
		tensor currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			with: tensor
			with: axis asInt32Tensor
]
