Class {
	#name : 'TrainingUsingRMSPropTest',
	#superclass : 'TrainingUsingOptimizationTest',
	#category : 'MLTrainingModelTests'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingRMSPropTest >> expectedLossWhenMinimizingCategoricalCrossEntropy [

	^#(0.846859931945801 0.84538102149963 0.844323873519897 0.84344661235809 0.842673122882843)
]

{ #category : 'Accessing' }
TrainingUsingRMSPropTest >> expectedLossWhenMinimizingCategoricalCrossEntropyInBatches [

	^#(0.84606 0.843515 0.841959 0.840685 0.839558)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingRMSPropTest >> expectedLossWhenMinimizingMeanSquaredError [

	^#(0.265 0.260003 0.256497 0.25363 0.251136)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingRMSPropTest >> expectedLossWhenMinimizingMeanSquaredErrorInBatches [

	^#(0.263918 0.257379 0.252959 0.249319 0.246109)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingRMSPropTest >> expectedLossWhenMinimizingSparseCategoricalCrossEntropy [

	^#(0.887488 0.88104 0.876435 0.872622 0.869269)
]

{ #category : 'Tests' }
TrainingUsingRMSPropTest >> expectedLossWhenMinimizingSparseCategoricalCrossEntropyInBatches [

	^#(0.885448 0.877409 0.872078 0.867611 0.863616)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingRMSPropTest >> optimizationAlgorithm [

	^RootMeanSquaredPropagation new
]
