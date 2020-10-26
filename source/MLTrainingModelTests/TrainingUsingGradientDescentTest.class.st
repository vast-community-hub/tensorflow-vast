Class {
	#name : 'TrainingUsingGradientDescentTest',
	#superclass : 'TrainingUsingOptimizationTest',
	#category : 'MLTrainingModelTests'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingGradientDescentTest >> expectedLossWhenMinimizingCategoricalCrossEntropy [

	^#(0.846859931945801 0.845578074455261 0.844308912754059 0.843052387237549 0.841808199882507)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingGradientDescentTest >> expectedLossWhenMinimizingMeanSquaredError [

	^#(0.265 0.260642 0.256446 0.252405 0.248514)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingGradientDescentTest >> expectedLossWhenMinimizingSparseCategoricalCrossEntropy [

	^#(0.887488 0.881097 0.874819 0.86865 0.86259)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingGradientDescentTest >> optimizationAlgorithm [

	^GradientDescent new
]
