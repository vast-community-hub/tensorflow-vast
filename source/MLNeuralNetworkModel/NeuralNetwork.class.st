Class {
	#name : 'NeuralNetwork',
	#superclass : 'Object',
	#category : 'MLNeuralNetworkModel'
}

{ #category : 'Predicting' }
NeuralNetwork >> predictFrom: aFeaturesCollection [


	self subclassResponsibility
]

{ #category : 'Training' }
NeuralNetwork >> updateWeightsToFitPredictionFrom: aFeaturesCollection to: aTarget [

	self subclassResponsibility
]
