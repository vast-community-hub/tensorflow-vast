Extension {
	#name : 'TrainingMinimizingSparseCategoricalCrossEntropyTest'
}

{ #category : 'Accessing' }
TrainingMinimizingSparseCategoricalCrossEntropyTest >> accuracyTracker [

	^SparseCategoricalPredictionAccuracyTracker new
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingSparseCategoricalCrossEntropyTest >> expectedAccuracyAfterOneEpoch [

	^#(0.25)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingSparseCategoricalCrossEntropyTest >> expectedAccuracyThroughTenEpochs [

	^#(0.25 0.5 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75)
]
