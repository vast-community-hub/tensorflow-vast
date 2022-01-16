Class {
	#name : 'VariableNodeAbstract',
	#superclass : 'TensorFlowOperationAbstract',
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
VariableNodeAbstract class >> on: aComputation named: aName of: aType shaped: aShape initializedWith: aVariableInitializer [

	^self new
		initializeOn: aComputation
		named: aName
		of: aType
		shaped: aShape
		initializedWith: aVariableInitializer
]

{ #category : 'Accessing' }
VariableNodeAbstract >> assign: anOperation [

	self subclassResponsibility
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
VariableNodeAbstract >> initializeOn: aTensorFlowComputation named: aName of: aType shaped: aShape initializedWith: aVariableInitializer [
	
	self subclassResponsibility
]
