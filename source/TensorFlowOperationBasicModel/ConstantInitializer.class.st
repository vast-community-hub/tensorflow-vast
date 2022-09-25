Class {
	#name : 'ConstantInitializer',
	#superclass : 'VariableTensorInitializer',
	#instVars : [
		'initialValue'
	],
	#category : 'TensorFlowOperationBasicModel'
}

{ #category : 'Instance Creation' }
ConstantInitializer class >> with: aTensorOrScalar [

	^self new initializeWith: aTensorOrScalar
]

{ #category : 'Instance Creation' }
ConstantInitializer class >> withZeros [

	^self with: 0
]

{ #category : 'Evaluating' }
ConstantInitializer >> applyTo: aVariableTensor [

	aVariableTensor assign: (
		(initialValue isA: TFTensor)
			ifTrue: [initialValue value asOperationOn: aVariableTensor currentComputation]
			ifFalse: [(ConstantTensor like: aVariableTensor filledWith: initialValue) value])
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
ConstantInitializer >> initializeWith: aTensorOrScalar [
	
	initialValue := aTensorOrScalar
]
