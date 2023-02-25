Extension {
	#name : 'TrainingMinimizingMeanSquaredErrorTest'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingMeanSquaredErrorTest >> expectedAccuracyAfterOneEpoch [

	^#(0.5)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingMeanSquaredErrorTest >> expectedAccuracyThroughTenEpochs [

	^#(0.5 0.5 0.5 0.75 1 1 1 1 1 1)
]
