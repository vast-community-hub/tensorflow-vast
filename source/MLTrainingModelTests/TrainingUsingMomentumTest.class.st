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

{ #category : 'Accessing' }
TrainingUsingMomentumTest >> expectedLossWhenMinimizingCategoricalCrossEntropyInBatches [

	^#(0.846796 0.846275 0.845369 0.844159 0.842708)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingMomentumTest >> expectedLossWhenMinimizingMeanSquaredError [

	^#(0.265 0.264560 0.263728 0.262549 0.261064)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingMomentumTest >> expectedLossWhenMinimizingMeanSquaredErrorInBatches [

	^#(0.26488 0.263229 0.260271 0.256324 0.251661)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingMomentumTest >> expectedLossWhenMinimizingSparseCategoricalCrossEntropy [

	^#(0.887488 0.886846 0.885629 0.883899 0.88171)
]

{ #category : 'Accessing' }
TrainingUsingMomentumTest >> expectedLossWhenMinimizingSparseCategoricalCrossEntropyInBatches [

	^#(0.887404 0.884977 0.880603 0.874698 0.867613)
]

{ #category : 'Accessing' }
TrainingUsingMomentumTest >> expectedValidationLossWhenMinimizingMeanSquaredErrorInBatches [

	^#(4.39283033212026e-1 4.37936892112096e-1 4.36114301284154e-1 4.33948844671249e-1
	4.31553939978282e-1)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingMomentumTest >> optimizationAlgorithm [

	^Momentum new
]
