Class {
	#name : 'ReduceMean',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'axis',
		'tensor'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation',
  #vaVisibility : 'private' }
ReduceMean class >> allAxisOf: aTFOperation [

	^(1 to: aTFOperation outputDimensions) collect: [:axis | axis - 1]
]

{ #category : 'Instance Creation' }
ReduceMean class >> named: aName ofValuesIn: aTFOperation [

	^self named: aName ofValuesIn: aTFOperation alongside: (self allAxisOf: aTFOperation)
]

{ #category : 'Instance Creation' }
ReduceMean class >> named: anOperationName ofValuesIn: aTensor alongside: anAxis [

	^self new initializeNamed: anOperationName ofValuesIn: aTensor alongside: anAxis
]

{ #category : 'Instance Creation' }
ReduceMean class >> ofValuesIn: aTFOperation [

	^self ofValuesIn: aTFOperation alongside: (self allAxisOf: aTFOperation)
]

{ #category : 'Instance Creation' }
ReduceMean class >> ofValuesIn: aTensor alongside: anAxis [

	^self named: self operationType ofValuesIn: aTensor alongside: anAxis
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
ReduceMean class >> operationType [

	^'Mean'
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
ReduceMean >> initializeNamed: anOperationName ofValuesIn: aTensor alongside: anAxis [

	tensor := aTensor.
	axis := anAxis.
	value :=
		tensor currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			with: tensor
			with: axis asInt32Tensor
]
