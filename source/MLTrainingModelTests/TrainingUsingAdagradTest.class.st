Class {
	#name : 'TrainingUsingAdagradTest',
	#superclass : 'TrainingUsingOptimizationTest',
	#category : 'MLTrainingModelTests'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingAdagradTest >> expectedLossWhenMinimizingCategoricalCrossEntropy [

	^#(0.846859931945801 0.84655058383941 0.846288204193115 0.84605538845062 0.845843434333801)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingAdagradTest >> expectedLossWhenMinimizingMeanSquaredError [

	^#(0.265 0.264025 0.263223 0.262523 0.261893)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingAdagradTest >> expectedLossWhenMinimizingSparseCategoricalCrossEntropy [

	^#(0.887488 0.886098 0.884969 0.883992 0.883118)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingAdagradTest >> optimizationAlgorithm [

	^AdaptiveGradient new
]
