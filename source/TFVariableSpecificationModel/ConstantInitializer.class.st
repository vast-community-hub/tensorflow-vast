Class {
	#name : 'ConstantInitializer',
	#superclass : 'VariableNodeInitializer',
	#instVars : [
		'initialValue'
	],
	#category : 'TFVariableSpecificationModel'
}

{ #category : 'Instance Creation' }
ConstantInitializer class >> with: aTFTensor [

	^self new initializeWith: aTFTensor
]

{ #category : 'Evaluating' }
ConstantInitializer >> applyTo: aTFVariable [

	aTFVariable assign: (initialValue value asOperationOn: aTFVariable graph)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
ConstantInitializer >> initializeWith: aTFTensor [

	
	initialValue := aTFTensor 
]
