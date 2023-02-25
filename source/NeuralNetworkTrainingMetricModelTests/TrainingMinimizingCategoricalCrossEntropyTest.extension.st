Extension {
	#name : 'TrainingMinimizingCategoricalCrossEntropyTest'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingCategoricalCrossEntropyTest >> expectedAccuracyAfterOneEpoch [

	^#(0.5)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingCategoricalCrossEntropyTest >> expectedAccuracyThroughTenEpochs [

	^#(0.5 0.5 0.5 0.5 0.5 0.5 0.75 0.75 0.75 0.75)
]
