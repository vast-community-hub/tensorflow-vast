Class {
	#name : 'TrainingUsingAdamTest',
	#superclass : 'TrainingUsingOptimizationTest',
	#category : 'MLTrainingModelTests'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingAdamTest >> expectedLossWhenMinimizingCategoricalCrossEntropy [

	^#(0.84686 0.846392 0.845924 0.845458 0.844992)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingAdamTest >> expectedLossWhenMinimizingMeanSquaredError [

	^#(0.265 0.263406 0.261825 0.260258 0.258703)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingAdamTest >> expectedLossWhenMinimizingSparseCategoricalCrossEntropy [

	^#(0.887488 0.885441 0.883401 0.881369 0.879346)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingAdamTest >> optimizationAlgorithm [

	^AdaptiveMomentEstimation new
]
