Class {
	#name : 'TFConstantInitializer',
	#superclass : 'TFVariableInitializer',
	#instVars : [
		'initialValue'
	],
	#category : 'TFVariableSpecificationModel'
}

{ #category : 'Instance Creation' }
TFConstantInitializer class >> with: aTFTensor [

	^self new initializeWith: aTFTensor
]

{ #category : 'Evaluating' }
TFConstantInitializer >> applyTo: aTFVariable [

	aTFVariable assign: (initialValue asOperationOn: aTFVariable graph)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFConstantInitializer >> initializeWith: aTFTensor [

	
	initialValue := aTFTensor 
]
