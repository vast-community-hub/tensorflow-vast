Class {
	#name : 'TrainingMinimizingCategoricalCrossEntropyTest',
	#superclass : 'TrainingMinimizingLossFunctionTest',
	#category : 'MLTrainingModelTests'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingCategoricalCrossEntropyTest >> expectedLogitsAfterOneEpoch [

	^#((0.27597973 0.82402027) (0.34054536 0.8094547) (0.2436969 0.8563031) (0.355111 0.84488904))
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingCategoricalCrossEntropyTest >> expectedLossAfterOneEpoch [

	^0.822441
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingCategoricalCrossEntropyTest >> expectedLossValueThroughTenEpochs [

	^#(0.8468599915504456 0.8224405646324158 0.8024106025695801 0.7854786515235901 0.7707569003105164
	0.7576471567153931 0.7457488179206848 0.7347933053970337 0.7245980501174927 0.7150363326072693)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingCategoricalCrossEntropyTest >> expectedWeightAfterOneEpoch [

	^#((0.01456563 0.03543437) (0.06456564 -0.01456563) (0.04684845 0.00315156))
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingCategoricalCrossEntropyTest >> neuralNetworkTrainer [

	^(NeuralNetworkTrainer on: tf)
		minimizeCategoricalCrossEntropyUsing: (GradientDescent scalingBy: 0.2);
		yourself
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingCategoricalCrossEntropyTest >> targetTensor [

	^self expectedProbabilityByLabel
]
