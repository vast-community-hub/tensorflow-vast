Class {
	#name : 'ImportedModel',
	#superclass : 'PredictionModel',
	#instVars : [
		'inputName',
		'currentComputation'
	],
	#category : 'NeuralNetworkLayerModel'
}

{ #category : 'Not categorized' }
ImportedModel class >> on: aTensorFlowComputation loadedFrom: aFileName inputNamed: anInputNodeName outputNamed: anOutputNodesName [

	^self new
		initializeOn: aTensorFlowComputation
		loadedFrom: aFileName
		inputNamed: anInputNodeName
		outputNamed: anOutputNodesName
]

{ #category : 'Not categorized' }
ImportedModel >> currentComputation [

	^currentComputation
]

{ #category : 'Not categorized',
  #vaVisibility : 'private' }
ImportedModel >> initializeOn: aTensorFlowComputation loadedFrom: aFileName inputNamed: anInputNodeName outputNamed: anOutputNodeName [

	currentComputation := aTensorFlowComputation.
	currentComputation importGraphFrom: aFileName.
	inputName := anInputNodeName.
	value := currentComputation operationNamed: anOutputNodeName
]

{ #category : 'Not categorized' }
ImportedModel >> predictFrom: aFeatureTensor [

	^self computeWith: (
		Dictionary new
			at: inputName put: aFeatureTensor;
			yourself)
]
