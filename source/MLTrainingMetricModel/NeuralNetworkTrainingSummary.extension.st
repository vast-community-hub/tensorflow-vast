Extension {
	#name : 'NeuralNetworkTrainingSummary'
}

{ #category : '*MLTrainingMetricModel',
 #vaCategories : ['Accessing'] }
NeuralNetworkTrainingSummary >> historicalTrainingAccuracy [

	^trainingContext metricKnownAs: CategoricalPredictionAccuracyTracker metricKey
]
