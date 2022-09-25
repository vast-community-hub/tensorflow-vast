Class {
	#name : 'NeuralNetworkTrainerTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'NeuralNetworkTrainingModelTests'
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

	| model runs summary |

	runs := 0.
	model := self modelWithTwoOutputUnits.

	summary :=
		(NeuralNetworkTrainer on: tf)
			minimizeSparseCategoricalCrossEntropyUsing: (GradientDescent scalingBy: 0.2);
			stopTrainingWhen: (CompletedNumberOfTraining after: 10);
			afterEveryTrainingDo: [:context |
				runs := runs + 1.
				self assert: context epochsTrained equals: runs];
			train: model toFit: self trainingDatasetWithLabels.

	self assert: runs equals: 11.
	self assert: summary epochsTrained equals: 10
]

{ #category : 'Tests' }
NeuralNetworkTrainerTest >> testNoOptimizationSet [

	| model |

	model := self modelWithTwoOutputUnits.

	self
		should: [
			(NeuralNetworkTrainer on: tf)
				stopTrainingWhen: (LossHasNotImproved moreThan: 0.005);
				train: model toFit: self trainingDatasetWithLabelProbabilities]
		raise: AssertionFailure
		withDescription: 'Need to configure an optimization algorithm before training'
]

{ #category : 'Tests' }
NeuralNetworkTrainerTest >> testStopConditionMustBeSetBeforeTraining [

	| model |

	model := self modelWithTwoOutputUnits.

	self
		should: [
			(NeuralNetworkTrainer on: tf)
				minimizeCategoricalCrossEntropyUsing: (GradientDescent scalingBy: 0.2);
				train: model toFit: self trainingDatasetWithLabelProbabilities]
		raise: AssertionFailure
		withDescription: 'Need to configure a stop condition before training'
]

{ #category : 'Tests' }
NeuralNetworkTrainerTest >> testStopTrainingAfterLossHasNotImprovedADelta [

	| model summary |

	model := self modelWithTwoOutputUnits.
	summary :=
		(NeuralNetworkTrainer on: tf)
			minimizeCategoricalCrossEntropyUsing: (GradientDescent scalingBy: 0.2);
			stopTrainingWhen: (LossHasNotImproved moreThan: 0.005);
			train: model toFit: self trainingDatasetWithLabelProbabilities.

	self assert: summary epochsTrained equals: 25
]

{ #category : 'Tests' }
NeuralNetworkTrainerTest >> testStopTrainingAfterLossReachedAMinimum [

	| model summary |

	model := self modelWithTwoOutputUnits.
	summary :=
		(NeuralNetworkTrainer on: tf)
			minimizeCategoricalCrossEntropyUsing: (GradientDescent scalingBy: 0.2);
			stopTrainingWhen: (LossReachedMinimum lowerThan: 0.5);
			train: model toFit: self trainingDatasetWithLabelProbabilities.

	self assert: summary epochsTrained equals: 67.
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
			train: model toFit: self trainingDatasetWithLabels.

	self
		assert: summary printString
		equals:
			'== Model To Train ==
Sequential Model with 1 layer
Dense Layer[3 -> 2]
=====
Loss: Sparse Categorical Cross Entropy (Reduced to scalar with mean)
Optimization Algorithm: Gradient Descent (learning rate: 0.2)
Stop Condition: Stop training after 10 epochs
Current number of epochs run: 10'
]

{ #category : 'Tests' }
NeuralNetworkTrainerTest >> trainingDatasetWithLabelProbabilities [

	^SampleDataset new
		bindTrainingSetTo: self logictStatements withLabels: self expectedProbabilityByLabel;
		yourself
]

{ #category : 'Tests' }
NeuralNetworkTrainerTest >> trainingDatasetWithLabels [

	^SampleDataset new
		bindTrainingSetTo: self logictStatements withLabels: #(0 1 0 0) asInt32Tensor;
		yourself
]
