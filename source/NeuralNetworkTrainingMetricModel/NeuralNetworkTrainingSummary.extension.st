Extension {
	#name : 'NeuralNetworkTrainingSummary'
}

{ #category : '*NeuralNetworkTrainingMetricModel',
 #vaCategories : ['Accessing'] }
NeuralNetworkTrainingSummary >> historicalTrainingAccuracy [

	^self trainingMetricKnownAs: CategoricalPredictionAccuracyTracker metricKey
]

{ #category : '*NeuralNetworkTrainingMetricModel',
 #vaCategories : ['Accessing'] }
NeuralNetworkTrainingSummary >> trainingMetricKnownAs: aMetricKey [

	^trainingContext trainingMetricKnownAs: aMetricKey
]

{ #category : '*NeuralNetworkTrainingMetricModel',
 #vaCategories : ['Accessing'] }
NeuralNetworkTrainingSummary >> validationMetricKnownAs: aMetricKey [

	^trainingContext validationMetricKnownAs: aMetricKey
]
