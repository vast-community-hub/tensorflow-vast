Class {
	#name : 'NeuralNetwork',
	#superclass : 'Object',
	#category : 'LibTensorFlowExamplesApp'
}

{ #category : 'Predicting' }
NeuralNetwork >> predictFrom: aFeaturesCollection [


	self subclassResponsibility
]

{ #category : 'Training' }
NeuralNetwork >> updateWeightsToFitPredictionFrom: aFeaturesCollection to: aTarget [

	self subclassResponsibility
]
