Class {
	#name : 'PredictionModel',
	#superclass : 'TensorFlowOperationAbstract',
	#category : 'NeuralNetworkLayerModel'
}

{ #category : 'Not categorized' }
PredictionModel >> predictFrom: anInput [

	self subclassResponsibility
]
