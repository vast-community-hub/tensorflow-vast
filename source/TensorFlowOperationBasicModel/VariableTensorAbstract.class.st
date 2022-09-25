Class {
	#name : 'VariableTensorAbstract',
	#superclass : 'TensorFlowOperationAbstract',
	#category : 'TensorFlowOperationBasicModel'
}

{ #category : 'Instance Creation' }
VariableTensorAbstract class >> on: aComputation named: aName of: aType shaped: aShape initializedWith: aVariableInitializer [

	^self new
		initializeOn: aComputation
		named: aName
		of: aType
		shaped: aShape
		initializedWith: aVariableInitializer
]

{ #category : 'Accessing' }
VariableTensorAbstract >> assign: anOperation [

	self subclassResponsibility
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
VariableTensorAbstract >> initializeOn: aTensorFlowComputation named: aName of: aType shaped: aShape initializedWith: aVariableInitializer [
	
	self subclassResponsibility
]
