Class {
	#name : 'TrainingUsingGradientDescentTest',
	#superclass : 'TrainingUsingOptimizationTest',
	#category : 'NeuralNetworkTrainingModelTests'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingGradientDescentTest >> expectedLossWhenMinimizingCategoricalCrossEntropy [

	^#(0.846859931945801 0.845578074455261 0.844308912754059 0.843052387237549 0.841808199882507)
]

{ #category : 'Accessing' }
TrainingUsingGradientDescentTest >> expectedLossWhenMinimizingCategoricalCrossEntropyInBatches [

	^#(0.846232 0.843706 0.841229 0.8388 0.836417)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingGradientDescentTest >> expectedLossWhenMinimizingMeanSquaredError [

	^#(0.265 0.260642 0.256446 0.252405 0.248514)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingGradientDescentTest >> expectedLossWhenMinimizingMeanSquaredErrorInBatches [

	^#(0.263827 0.255408 0.2476 0.240354 0.233622)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingGradientDescentTest >> expectedLossWhenMinimizingSparseCategoricalCrossEntropy [

	^#(0.887488 0.881097 0.874819 0.86865 0.86259)
]

{ #category : 'Accessing' }
TrainingUsingGradientDescentTest >> expectedLossWhenMinimizingSparseCategoricalCrossEntropyInBatches [

	^#(0.88665 0.874014 0.861818 0.850049 0.838693)
]

{ #category : 'Accessing' }
TrainingUsingGradientDescentTest >> expectedValidationLossWhenMinimizingMeanSquaredErrorInBatches [

	^#(4.36017443736394e-1 4.32377288738887e-1 4.29051756858826e-1 4.26015466451645e-1
	4.23245092233022e-1)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingGradientDescentTest >> optimizationAlgorithm [

	^GradientDescent new
]
