Extension {
	#name : 'TrainingMinimizingMeanSquaredErrorTest'
}

{ #category : '*NeuralNetworkTrainingMetricModelTests',
 #vaCategories : ['Accessing'],
  #vaVisibility : 'private' }
TrainingMinimizingMeanSquaredErrorTest >> expectedAccuracyAfterOneEpoch [

	^#(0.5)
]

{ #category : '*NeuralNetworkTrainingMetricModelTests',
 #vaCategories : ['Accessing'],
  #vaVisibility : 'private' }
TrainingMinimizingMeanSquaredErrorTest >> expectedAccuracyThroughTenEpochs [

	^#(0.5 0.5 0.5 0.75 1 1 1 1 1 1)
]
