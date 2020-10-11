Extension {
	#name : 'NeuralNetworkTrainingContext'
}

{ #category : '*MLTrainingMetricModel',
 #vaCategories : ['Building'] }
NeuralNetworkTrainingContext >> buildCategoricalPredictionAccuracy [

	^CategoricalPredictionAccuracy
		of: model
		whenExpectedIs: optimization lossToMinimize targetInputAsLabels
]
