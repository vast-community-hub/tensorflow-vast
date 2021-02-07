Extension {
	#name : 'NeuralNetworkTrainingSummary'
}

{ #category : '*MLTrainingMetricModel',
 #vaCategories : ['Accessing'] }
NeuralNetworkTrainingSummary >> historicalTrainingAccuracy [

	^self metricKnownAs: CategoricalPredictionAccuracyTracker metricKey
]

{ #category : '*MLTrainingMetricModel',
 #vaCategories : ['Accessing'] }
NeuralNetworkTrainingSummary >> metricKnownAs: aMetricKey [

	^trainingContext metricKnownAs: aMetricKey
]
