Class {
	#name : 'TrainingMinimizingMeanSquaredErrorTest',
	#superclass : 'TrainingMinimizingLossFunctionTest',
	#category : 'MLTrainingModelTests'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingMeanSquaredErrorTest >> expectedAccuracyAfterOneEpoch [

	^0.5
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingMeanSquaredErrorTest >> expectedLogitsAfterOneEpoch [

	^#((0.32999998 0.77000004) (0.41 0.74) (0.29 0.81) (0.44 0.76))
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingMeanSquaredErrorTest >> expectedLossAfterOneEpoch [

	^0.193613
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingMeanSquaredErrorTest >> expectedWeightAfterOneEpoch [

	^#((0.03 0.02) (0.08 -0.03) (0.07 -0.02))
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingMeanSquaredErrorTest >> neuralNetworkTrainer [

	^(NeuralNetworkTrainer on: tf)
		minimizeMeanSquaredErrorUsing: (GradientDescent scalingBy: 0.2);
		yourself
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingMeanSquaredErrorTest >> targetTensor [

	^self expectedProbabilityByLabel
]
