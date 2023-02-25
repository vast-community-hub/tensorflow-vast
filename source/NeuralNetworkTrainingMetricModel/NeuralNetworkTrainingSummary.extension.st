Extension {
	#name : 'NeuralNetworkTrainingSummary'
}

{ #category : 'Accessing' }
NeuralNetworkTrainingSummary >> historicalTrainingAccuracy [

	^self trainingMetricKnownAs: CategoricalPredictionAccuracyTracker metricKey
]

{ #category : 'Accessing' }
NeuralNetworkTrainingSummary >> trainingMetricKnownAs: aMetricKey [

	^trainingContext trainingMetricKnownAs: aMetricKey
]

{ #category : 'Accessing' }
NeuralNetworkTrainingSummary >> validationMetricKnownAs: aMetricKey [

	^trainingContext validationMetricKnownAs: aMetricKey
]
