Class {
	#name : 'TrainingMinimizingSparseCategoricalCrossEntropyTest',
	#superclass : 'TrainingMinimizingLossFunctionTest',
	#category : 'NeuralNetworkTrainingModelTests'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingSparseCategoricalCrossEntropyTest >> expectedLogitsAfterOneEpoch [

	^#((0.3259797 0.67402035) (0.34054536 0.6594547) (0.3436969 0.65630317) (0.40511099 0.59488904))
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingSparseCategoricalCrossEntropyTest >> expectedLossAfterOneEpoch [

	^0.770683
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingSparseCategoricalCrossEntropyTest >> expectedLossValueThroughTenEpochs [

	^#(0.8874880075454712 0.7706831693649292 0.6920742988586426 0.6382837295532227 0.5999782681465149
	0.571312427520752 0.548761248588562 0.530205249786377 0.5143527388572693 0.5004007816314697)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingSparseCategoricalCrossEntropyTest >> expectedWeightAfterOneEpoch [

	^#((0.06456564 -0.06456563) (0.01456563 -0.01456563) (0.04684845 -0.04684844))
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingSparseCategoricalCrossEntropyTest >> neuralNetworkTrainer [

	^(NeuralNetworkTrainer on: tf)
		minimizeSparseCategoricalCrossEntropyUsing: (GradientDescent scalingBy: 0.2);
		yourself
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingSparseCategoricalCrossEntropyTest >> targetTensor [

	^self expectedLabels
]
