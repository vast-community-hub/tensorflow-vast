Extension {
	#name : 'NeuralNetworkTrainingContext'
}

{ #category : '*MLTrainingMetricModel',
 #vaCategories : ['Building'] }
NeuralNetworkTrainingContext >> buildCategoricalPredictionAccuracy [

	^CategoricalPredictionAccuracy
		of: modelToTrain
		whenExpectedIs: optimization lossToMinimize targetInputAsLabels
]
