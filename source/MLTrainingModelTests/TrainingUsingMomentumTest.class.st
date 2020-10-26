Class {
	#name : 'TrainingUsingMomentumTest',
	#superclass : 'TrainingUsingOptimizationTest',
	#category : 'MLTrainingModelTests'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingMomentumTest >> expectedLossWhenMinimizingCategoricalCrossEntropy [

	^#(0.846859931945801 0.84673154354095 0.846487581729889 0.84614038467407 0.845700562000275)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingMomentumTest >> expectedLossWhenMinimizingMeanSquaredError [

	^#(0.265 0.264560 0.263728 0.262549 0.261064)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingMomentumTest >> expectedLossWhenMinimizingSparseCategoricalCrossEntropy [

	^#(0.887488 0.886846 0.885629 0.883899 0.88171)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingMomentumTest >> optimizationAlgorithm [

	^Momentum new
]
