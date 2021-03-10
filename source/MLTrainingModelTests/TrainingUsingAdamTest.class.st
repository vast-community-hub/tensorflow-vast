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

{ #category : 'Accessing' }
TrainingUsingAdamTest >> expectedLossWhenMinimizingCategoricalCrossEntropyInBatches [

	^#(0.846602 0.845378 0.844389 0.84345 0.842537)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingAdamTest >> expectedLossWhenMinimizingMeanSquaredError [

	^#(0.265 0.263406 0.261825 0.260258 0.258703)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingAdamTest >> expectedLossWhenMinimizingMeanSquaredErrorInBatches [

	^#(0.264653 0.261752 0.259041 0.256396 0.253798)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingAdamTest >> expectedLossWhenMinimizingSparseCategoricalCrossEntropy [

	^#(0.887488 0.885441 0.883401 0.881369 0.879346)
]

{ #category : 'Accessing' }
TrainingUsingAdamTest >> expectedLossWhenMinimizingSparseCategoricalCrossEntropyInBatches [

	^#(0.886843 0.883549 0.880392 0.87724 0.874098)
]

{ #category : 'Accessing' }
TrainingUsingAdamTest >> expectedValidationLossWhenMinimizingMeanSquaredErrorInBatches [

	^#(4.38309023777644e-1 0.43689235051473 4.35552855332692e-1 4.34258788824081e-1
	4.32999461889267e-1)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingAdamTest >> optimizationAlgorithm [

	^AdaptiveMomentEstimation new
]
