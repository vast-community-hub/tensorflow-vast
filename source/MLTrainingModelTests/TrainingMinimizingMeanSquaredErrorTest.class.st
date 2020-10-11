Class {
	#name : 'TrainingMinimizingMeanSquaredErrorTest',
	#superclass : 'TrainingMinimizingLossFunctionTest',
	#category : 'MLTrainingModelTests'
}

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
TrainingMinimizingMeanSquaredErrorTest >> expectedLossValueThroughTenEpochs [

	^#(0.26500004529953003 0.19361251592636108 0.1633041501045227 0.14681315422058105
	0.13540230691432953 0.12621885538101196 0.11828607320785522 0.11123108863830566
	0.10488058626651764 0.09913133084774017)
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
