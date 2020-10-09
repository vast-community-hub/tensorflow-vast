Class {
	#name : 'NeuralNetworkTrainerTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'MLTrainingModelTests'
}

{ #category : 'Tests',
  #vaVisibility : 'private' }
NeuralNetworkTrainerTest >> expectedProbabilityByLabel [

	^#((0 1) (1 0) (0 1) (1 1)) asFloatTensor
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
NeuralNetworkTrainerTest >> logictStatements [

	^#((0 0 1) (0 1 1) (1 0 0) (1 1 1)) asFloatTensor
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
NeuralNetworkTrainerTest >> modelWithTwoOutputUnits [

	^(SequentialModelBuilder on: tf)
		addDenseLayerSized: 2
			builtWith: [:layer |
				layer
					inputSize: 3;
					weightInitializedToZero;
					biasInitializedTo: #(0.2 0.8)];
		buildApplyingToLogits: [:logits | logits argMaxOnRows]
]

{ #category : 'Tests' }
NeuralNetworkTrainerTest >> testAfterTrainingCallback [

	| model runs |

	runs := 0.
	model := self modelWithTwoOutputUnits.

	(NeuralNetworkTrainer on: tf)
		minimizeSparseCategoricalCrossEntropyUsing: (GradientDescent scalingBy: 0.2);
		stopTrainingWhen: (CompletedNumberOfTraining after: 10);
		afterEveryTrainingDo: [:iter :summary |
			runs := runs + 1.
			self assert: summary totalNumberOfEpochs equals: iter];
		train: model toFitPredictionFrom: self logictStatements to: #(0 1 0 0) asInt32Tensor.

	self assert: runs equals: 11
]

{ #category : 'Tests' }
NeuralNetworkTrainerTest >> testStopTrainingAfterLossHasNotImprovedADelta [

	| model summary |

	model := self modelWithTwoOutputUnits.
	summary :=
		(NeuralNetworkTrainer on: tf)
			minimizeCategoricalCrossEntropyUsing: (GradientDescent scalingBy: 0.2);
			stopTrainingWhen: (LossHasNotImproved moreThan: 0.005);
			train: model
				toFitPredictionFrom: self logictStatements
				to: self expectedProbabilityByLabel.
				
	self assert: summary totalNumberOfEpochs equals: 25
]

{ #category : 'Tests' }
NeuralNetworkTrainerTest >> testStopTrainingAfterLossReachedAMinimum [

	| model summary |

	model := self modelWithTwoOutputUnits.
	summary :=
		(NeuralNetworkTrainer on: tf)
			minimizeCategoricalCrossEntropyUsing: (GradientDescent scalingBy: 0.2);
			stopTrainingWhen: (LossReachedMinimum lowerThan: 0.5);
			train: model
				toFitPredictionFrom: self logictStatements
				to: self expectedProbabilityByLabel.
				
	self assert: summary totalNumberOfEpochs equals: 67.
	self assert: (summary historicalTrainingLoss at: 66) > 0.5.
	self assert: (summary historicalTrainingLoss at: 67) <= 0.5
]

{ #category : 'Tests' }
NeuralNetworkTrainerTest >> testSummaryPrintString [

	| model summary |

	model := self modelWithTwoOutputUnits.

	summary :=
		(NeuralNetworkTrainer on: tf)
			minimizeSparseCategoricalCrossEntropyUsing: (GradientDescent scalingBy: 0.2);
			stopTrainingWhen: (CompletedNumberOfTraining after: 10);
			train: model toFitPredictionFrom: self logictStatements to: #(0 1 0 0) asInt32Tensor.

	self assert: summary printString equals: '== Model To Train ==
Sequential Model with 1 layer
Dense Layer[3 -> 2]
=====
Loss: Sparse Categorical Cross Entropy (Reduced to scalar with mean)
Optimization Algorithm: Gradient Descent (learning rate: 0.2)
Stop Condition: Stop training after 10 epochs
Current number of epochs run: 10'
]
