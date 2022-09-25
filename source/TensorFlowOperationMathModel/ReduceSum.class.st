Class {
	#name : 'ReduceSum',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'axis',
		'tensor'
	],
	#category : 'TensorFlowOperationMathModel'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
ReduceSum class >> allAxisOf: aTFOperation [

	^(1 to: aTFOperation value outputDimensions) collect: [:axis | axis - 1]
]

{ #category : 'Instance Creation' }
ReduceSum class >> named: anOperationName valuesIn: aTFOperation [

	^self named: anOperationName valuesIn: aTFOperation alongside: (self allAxisOf: aTFOperation)
]

{ #category : 'Instance Creation' }
ReduceSum class >> named: anOperationName valuesIn: aTensor alongside: anAxis [

	^self new initializeNamed: anOperationName sumValuesIn: aTensor alongside: anAxis
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
ReduceSum class >> operationType [

	^'Sum'
]

{ #category : 'Instance Creation' }
ReduceSum class >> valuesIn: aTFOperation [

	^self valuesIn: aTFOperation alongside: (self allAxisOf: aTFOperation)
]

{ #category : 'Instance Creation' }
ReduceSum class >> valuesIn: aTensor alongside: anAxis [

	^self named: self operationType valuesIn: aTensor alongside: anAxis
]

{ #category : 'Accessing' }
ReduceSum >> currentComputation [

	^tensor currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
ReduceSum >> initializeNamed: anOperationName sumValuesIn: aTensor alongside: anAxis [

	tensor := aTensor.
	axis := anAxis.
	value :=
		self currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			with: tensor
			with: axis asInt32Tensor
]
