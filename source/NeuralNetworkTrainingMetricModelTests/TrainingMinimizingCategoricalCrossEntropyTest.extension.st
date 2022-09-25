Extension {
	#name : 'TrainingMinimizingCategoricalCrossEntropyTest'
}

{ #category : '*NeuralNetworkTrainingMetricModelTests',
 #vaCategories : ['Accessing'],
  #vaVisibility : 'private' }
TrainingMinimizingCategoricalCrossEntropyTest >> expectedAccuracyAfterOneEpoch [

	^#(0.5)
]

{ #category : '*NeuralNetworkTrainingMetricModelTests',
 #vaCategories : ['Accessing'],
  #vaVisibility : 'private' }
TrainingMinimizingCategoricalCrossEntropyTest >> expectedAccuracyThroughTenEpochs [

	^#(0.5 0.5 0.5 0.5 0.5 0.5 0.75 0.75 0.75 0.75)
]
