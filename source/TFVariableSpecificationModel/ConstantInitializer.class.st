Class {
	#name : 'ConstantInitializer',
	#superclass : 'VariableNodeInitializer',
	#instVars : [
		'initialValue'
	],
	#category : 'TFVariableSpecificationModel'
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
ConstantInitializer >> applyTo: aTFVariable [

	aTFVariable assign: (
		(initialValue isA: TFTensor)
			ifTrue: [initialValue value asOperationOn: aTFVariable graph]
			ifFalse: [(ConstantNode like: aTFVariable filledWith: initialValue) value])
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
ConstantInitializer >> initializeWith: aTensorOrScalar [
	
	initialValue := aTensorOrScalar
]
