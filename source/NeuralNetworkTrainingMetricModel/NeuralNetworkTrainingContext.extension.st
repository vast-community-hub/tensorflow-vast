Extension {
	#name : 'NeuralNetworkTrainingContext'
}

{ #category : 'Building' }
NeuralNetworkTrainingContext >> buildCategoricalPredictionAccuracy [

	^CategoricalPredictionAccuracy
		of: modelToTrain
		whenExpectedIs: optimization lossToMinimize targetInputAsLabels
]

{ #category : 'Building' }
NeuralNetworkTrainingContext >> buildSummaryWriterTo: aLogsLocation [

	^SummaryWriter
		on: modelToTrain currentComputation
		writingTo: aLogsLocation
		appendingToName: '.v2'
		queueingUpTo: 10
		flushingEveryMilliseconds: 1
]
