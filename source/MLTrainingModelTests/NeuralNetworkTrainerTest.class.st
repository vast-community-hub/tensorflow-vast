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
		minimizeSparseCategoricalCrossEntropyUsing: (GradientDescent scalingBy: 0.2);
		stopTrainingWhen: (CompletedNumberOfTraining after: 10);
		afterEveryTrainingDo: [:iter :summary |
			runs := runs + 1.
			self assert: summary totalNumberOfEpochs equals: iter];
		train: model toFitPredictionFrom: self logictStatements to: #(0 1 0 0) asInt32Tensor.

	self assert: runs equals: 11
]

{ #category : 'Tests' }
NeuralNetworkTrainerTest >> testCalculateCategoricalCrossEntropyAfterTraining [

	| model summary |

	model := self modelWithTwoOutputUnits.
	summary :=
		(NeuralNetworkTrainer on: tf)
			minimizeCategoricalCrossEntropyUsing: (GradientDescent scalingBy: 0.2);
			stopTrainingWhen: (CompletedNumberOfTraining after: 1);
			train: model
				toFitPredictionFrom: self logictStatements
				to: self expectedProbabilityByLabel.

	self
		assertOutputOf: model trainableVariables first
		isMatrixCloseTo: #(
			(0.01456563 0.03543437) (0.06456564 -0.01456563) (0.04684845 0.00315156)).
	self
		assert: (
			model logits computeWith: (
				Dictionary new
					at: 'input' put: self logictStatements;
					yourself))
		isMatrixCloseTo: #(
			(0.27597973 0.82402027) (0.34054536 0.8094547) (0.2436969 0.8563031)
			(0.355111 0.84488904)).
	self
		assertOutputOf: (
			summary
				accuracyOfPredictionFrom: self logictStatements
				whenExpectedIs: self expectedProbabilityByLabel)
		isFloatScalarCloseTo: 0.822440
]

{ #category : 'Tests' }
NeuralNetworkTrainerTest >> testCalculateMeanSquaredErrorAfterTraining [

	| model summary |

	model := self modelWithTwoOutputUnits.
	summary :=
		(NeuralNetworkTrainer on: tf)
			minimizeMeanSquaredErrorUsing: (GradientDescent scalingBy: 0.2);
			stopTrainingWhen: (CompletedNumberOfTraining after: 1);
			train: model
				toFitPredictionFrom: self logictStatements
				to: self expectedProbabilityByLabel.

	self
		assertOutputOf: model trainableVariables first
		isMatrixCloseTo: #((0.03 0.02) (0.08000001 -0.03) (0.07000001 -0.02)).
	self
		assert: (
			model logits computeWith: (
				Dictionary new
					at: 'input' put: self logictStatements;
					yourself))
		isMatrixCloseTo: #((0.32999998 0.77000004) (0.41 0.74) (0.29 0.81) (0.44 0.76)).
	self
		assertOutputOf: (
			summary
				accuracyOfPredictionFrom: self logictStatements
				whenExpectedIs: self expectedProbabilityByLabel)
		isFloatScalarCloseTo: 0.193613.
	
]

{ #category : 'Tests' }
NeuralNetworkTrainerTest >> testCalculateSparseCategoricalCrossEntropyAfterTraining [

	| model summary |

	model := self modelWithTwoOutputUnits.
	summary :=
		(NeuralNetworkTrainer on: tf)
			minimizeSparseCategoricalCrossEntropyUsing: (GradientDescent scalingBy: 0.2);
			stopTrainingWhen: (CompletedNumberOfTraining after: 1);
			train: model toFitPredictionFrom: self logictStatements to: self expectedLabels.

	self
		assertOutputOf: model trainableVariables first
		isMatrixCloseTo: #(
			(0.06456564 -0.06456563) (0.01456563 -0.01456563) (0.04684845 -0.04684844)).
	self
		assert: (
			model logits computeWith: (
				Dictionary new
					at: 'input' put: self logictStatements;
					yourself))
		isMatrixCloseTo: #(
			(0.3259797 0.67402035) (0.34054536 0.6594547) (0.3436969 0.65630317)
			(0.40511099 0.59488904)).
	self
		assertOutputOf: (
			summary
				accuracyOfPredictionFrom: self logictStatements
				whenExpectedIs: self expectedLabels)
		isFloatScalarCloseTo: 0.770683
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

{ #category : 'Tests' }
NeuralNetworkTrainerTest >> testTrainMinimizingCategoricalCrossEntropyUsingGradientDescent [

	| model summary |

	model := self modelWithTwoOutputUnits.
	summary :=
		(NeuralNetworkTrainer on: tf)
			minimizeCategoricalCrossEntropyUsing: (GradientDescent scalingBy: 0.2);
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
			minimizeMeanSquaredErrorUsing: (GradientDescent scalingBy: 0.2);
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
			minimizeSparseCategoricalCrossEntropyUsing: (GradientDescent scalingBy: 0.2);
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
