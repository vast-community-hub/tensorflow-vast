Class {
	#name : 'NeuralNetworkTrainerTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'MLTrainingModelTests'
}

{ #category : 'Tests',
  #vaVisibility : 'private' }
NeuralNetworkTrainerTest >> expectedLabels [

	^#(0 1 0 0) asInt32Tensor
]

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
		minimizeSparseCategoricalCrossEntropyUsing: (TFGradientDescent scalingBy: 0.2);
		stopTrainingWhen: (CompletedNumberOfTraining after: 10);
		afterEveryTrainingDo: [:iter :summary |
			runs := runs + 1.
			self assert: summary totalNumberOfEpochs equals: iter];
		train: model toFitPredictionFrom: self logictStatements to: #(0 1 0 0) asInt32Tensor.

	self assert: runs equals: 11
]

{ #category : 'Tests' }
NeuralNetworkTrainerTest >> testCalculateLossAfterTraining [

	| model summary |

	model := self modelWithTwoOutputUnits.
	summary :=
		(NeuralNetworkTrainer on: tf)
			minimizeCategoricalCrossEntropyUsing: (TFGradientDescent scalingBy: 0.2);
			stopTrainingWhen: (CompletedNumberOfTraining after: 1);
			train: model
				toFitPredictionFrom: self logictStatements
				to: self expectedProbabilityByLabel.

	self assert: (model predictFrom: self logictStatements) isLargeIntegerVectorEqualsTo: #(1 1 1 1).
	self
		assert: (
			summary
				accuracyOfPredictionFrom: self logictStatements
				whenExpectedIs: self expectedProbabilityByLabel)
		isFloatScalarCloseTo: 8.46859931945801e-1
]

{ #category : 'Tests' }
NeuralNetworkTrainerTest >> testStopTrainingAfterLossHasNotImprovedADelta [

	| model summary |

	model := self modelWithTwoOutputUnits.
	summary :=
		(NeuralNetworkTrainer on: tf)
			minimizeCategoricalCrossEntropyUsing: (TFGradientDescent scalingBy: 0.2);
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
			minimizeCategoricalCrossEntropyUsing: (TFGradientDescent scalingBy: 0.2);
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
			minimizeSparseCategoricalCrossEntropyUsing: (TFGradientDescent scalingBy: 0.2);
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

{ #category : 'Tests' }
NeuralNetworkTrainerTest >> testTrainMinimizingCategoricalCrossEntropyUsingGradientDescent [

	| model summary |

	model := self modelWithTwoOutputUnits.
	summary :=
		(NeuralNetworkTrainer on: tf)
			minimizeCategoricalCrossEntropyUsing: (TFGradientDescent scalingBy: 0.2);
			stopTrainingWhen: (CompletedNumberOfTraining after: 1);
			train: model
				toFitPredictionFrom: self logictStatements
				to: self expectedProbabilityByLabel.

	self assert: summary totalNumberOfEpochs equals: 1.

	self
		assertOutputOf: (tf operationNamed: 'weight')
		isMatrixCloseTo: #(
			(1.45656336098909e-2 3.54343727231026e-2) (6.45656362175942e-2 -1.45656289532781e-2)
			(4.68484535813332e-2 3.15155694261193e-3)).

	self assert: (model predictFrom: self logictStatements) isLargeIntegerVectorEqualsTo: #(1 1 1 1)
]

{ #category : 'Tests' }
NeuralNetworkTrainerTest >> testTrainMinimizingMeanSquaredErrorUsingGradientDescent [

	| model summary |

	model := self modelWithTwoOutputUnits.
	summary :=
		(NeuralNetworkTrainer on: tf)
			minimizeMeanSquaredErrorUsing: (TFGradientDescent scalingBy: 0.2);
			stopTrainingWhen: (CompletedNumberOfTraining after: 1);
			train: model
				toFitPredictionFrom: self logictStatements
				to: self expectedProbabilityByLabel.
				
	self assert: summary totalNumberOfEpochs equals: 1.
	self
		assertOutputOf: (tf operationNamed: 'weight')
		isMatrixCloseTo: #((0.03 0.02) (0.08 -0.03) (0.07 -0.02)).
	self assertOutputOf: (tf operationNamed: 'bias') isFloatVectorCloseTo: #(0.26 0.79).
	
	self assert: (model predictFrom: self logictStatements) isLargeIntegerVectorEqualsTo: #(1 1 1 1)
]

{ #category : 'Tests' }
NeuralNetworkTrainerTest >> testTrainMinimizingSparseCategoricalCrossEntropyUsingGradientDescent [

	| model summary |

	model := self modelWithTwoOutputUnits.
	summary :=
		(NeuralNetworkTrainer on: tf)
			minimizeSparseCategoricalCrossEntropyUsing: (TFGradientDescent scalingBy: 0.2);
			stopTrainingWhen: (CompletedNumberOfTraining after: 1);
			train: model toFitPredictionFrom: self logictStatements to: self expectedLabels.
			
	self assert: summary totalNumberOfEpochs equals: 1.
	self
		assertOutputOf: (tf operationNamed: 'weight')
		isMatrixCloseTo: #(
			(6.45656362175942e-2 -6.45656287670136e-2) (1.45656336098909e-2 -1.45656289532781e-2)
			(4.68484535813332e-2 -4.68484424054623e-2)).
			
	self assert: (model predictFrom: self logictStatements) isLargeIntegerVectorEqualsTo: #(1 1 1 1)
]
