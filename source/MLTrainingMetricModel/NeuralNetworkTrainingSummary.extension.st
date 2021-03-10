Extension {
	#name : 'NeuralNetworkTrainingSummary'
}

{ #category : '*MLTrainingMetricModel',
 #vaCategories : ['Accessing'] }
NeuralNetworkTrainingSummary >> historicalTrainingAccuracy [

	^self trainingMetricKnownAs: CategoricalPredictionAccuracyTracker metricKey
]

{ #category : '*MLTrainingMetricModel',
 #vaCategories : ['Accessing'] }
NeuralNetworkTrainingSummary >> trainingMetricKnownAs: aMetricKey [

	^trainingContext trainingMetricKnownAs: aMetricKey
]

{ #category : '*MLTrainingMetricModel',
 #vaCategories : ['Accessing'] }
NeuralNetworkTrainingSummary >> validationMetricKnownAs: aMetricKey [

	^trainingContext validationMetricKnownAs: aMetricKey
]
