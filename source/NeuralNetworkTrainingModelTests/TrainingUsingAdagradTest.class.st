Class {
	#name : 'TrainingUsingAdagradTest',
	#superclass : 'TrainingUsingOptimizationTest',
	#category : 'NeuralNetworkTrainingModelTests'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingAdagradTest >> expectedLossWhenMinimizingCategoricalCrossEntropy [

	^#(0.846859931945801 0.84655058383941 0.846288204193115 0.84605538845062 0.845843434333801)
]

{ #category : 'Tests' }
TrainingUsingAdagradTest >> expectedLossWhenMinimizingCategoricalCrossEntropyInBatches [

	^#(0.846709 0.846175 0.845769 0.845428 0.845129)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingAdagradTest >> expectedLossWhenMinimizingMeanSquaredError [

	^#(0.265 0.264025 0.263223 0.262523 0.261893)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingAdagradTest >> expectedLossWhenMinimizingMeanSquaredErrorInBatches [

	^#(0.264746 0.263134 0.261926 0.260919 0.260039)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingAdagradTest >> expectedLossWhenMinimizingSparseCategoricalCrossEntropy [

	^#(0.887488 0.886098 0.884969 0.883992 0.883118)
]

{ #category : 'Accessing' }
TrainingUsingAdagradTest >> expectedLossWhenMinimizingSparseCategoricalCrossEntropyInBatches [

	^#(0.887241 0.885236 0.883753 0.88252 0.881443)
]

{ #category : 'Accessing' }
TrainingUsingAdagradTest >> expectedValidationLossWhenMinimizingMeanSquaredErrorInBatches [

	^#(4.39144601424535e-1 4.38521802425385e-1 4.38010483980179e-1 4.37567869822184e-1
	4.37172889709473e-1)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingAdagradTest >> optimizationAlgorithm [

	^Adagrad new
]
