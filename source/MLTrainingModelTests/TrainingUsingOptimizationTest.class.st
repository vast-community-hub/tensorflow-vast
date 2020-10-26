Class {
	#name : 'TrainingUsingOptimizationTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'MLTrainingModelTests'
}

{ #category : 'Accessing' }
TrainingUsingOptimizationTest class >> isAbstract [

	^self sunitName = #TrainingUsingOptimizationTest
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingOptimizationTest >> expectedLabels [

	^#(0 1 0 0) asInt32Tensor
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingOptimizationTest >> expectedLossWhenMinimizingCategoricalCrossEntropy [

	self subclassResponsibility
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingOptimizationTest >> expectedLossWhenMinimizingMeanSquaredError [

	self subclassResponsibility
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingOptimizationTest >> expectedLossWhenMinimizingSparseCategoricalCrossEntropy [

	self subclassResponsibility
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingOptimizationTest >> expectedProbabilityByLabel [

	^#((0 1) (1 0) (0 1) (1 1)) asFloatTensor
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingOptimizationTest >> inputDatasetWithLabels [

	^SampleDataset new
		bindTrainingSetTo: #((0 0 1) (0 1 1) (1 0 0) (1 1 1)) asFloatTensor
			andLabelsTo: self expectedLabels;
		yourself
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingOptimizationTest >> inputDatasetWithLabelsProbabilities [

	^SampleDataset new
		bindTrainingSetTo: #((0 0 1) (0 1 1) (1 0 0) (1 1 1)) asFloatTensor
			andLabelsTo: self expectedProbabilityByLabel;
		yourself
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingOptimizationTest >> modelWithTwoOutputUnits [

	^(SequentialModelBuilder on: tf)
		addDenseLayerSized: 2
			builtWith: [:layer |
				layer
					inputSize: 3;
					weightInitializedToZero;
					biasInitializedTo: #(0.2 0.8)];
		buildApplyingToLogits: [:logits | logits argMaxOnRows]
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingOptimizationTest >> optimizationAlgorithm [

	self subclassResponsibility
]

{ #category : 'Tests' }
TrainingUsingOptimizationTest >> testMinimizingCategoricalCrossEntropy [

	| model summary |

	model := self modelWithTwoOutputUnits.
	summary :=
		self trainerMinimizingCategoricalCrossEntropy
			stopTrainingWhen: (CompletedNumberOfTraining after: 5);
			train: model toFit: self inputDatasetWithLabelsProbabilities.

	self
		assert: summary historicalTrainingLoss
		isArrayCloseTo: self expectedLossWhenMinimizingCategoricalCrossEntropy
]

{ #category : 'Tests' }
TrainingUsingOptimizationTest >> testMinimizingMeanSquaredError [

	| model summary |

	model := self modelWithTwoOutputUnits.
	summary :=
		self trainerMinimizingMeanSquaredError
			stopTrainingWhen: (CompletedNumberOfTraining after: 5);
			train: model toFit: self inputDatasetWithLabelsProbabilities.

	self
		assert: summary historicalTrainingLoss
		isArrayCloseTo: self expectedLossWhenMinimizingMeanSquaredError
]

{ #category : 'Tests' }
TrainingUsingOptimizationTest >> testMinimizingSparseCategoricalCrossEntropy [

	| model summary |

	model := self modelWithTwoOutputUnits.
	summary :=
		self trainerMinimizingSparseCategoricalCrossEntropy
			stopTrainingWhen: (CompletedNumberOfTraining after: 5);
			train: model toFit: self inputDatasetWithLabels.

	self
		assert: summary historicalTrainingLoss
		isArrayCloseTo: self expectedLossWhenMinimizingSparseCategoricalCrossEntropy
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingOptimizationTest >> trainerMinimizingCategoricalCrossEntropy [

	^(NeuralNetworkTrainer on: tf)
		minimizeCategoricalCrossEntropyUsing: self optimizationAlgorithm;
		yourself
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingOptimizationTest >> trainerMinimizingMeanSquaredError [

	^(NeuralNetworkTrainer on: tf)
		minimizeMeanSquaredErrorUsing: self optimizationAlgorithm;
		yourself
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingUsingOptimizationTest >> trainerMinimizingSparseCategoricalCrossEntropy [

	^(NeuralNetworkTrainer on: tf)
		minimizeSparseCategoricalCrossEntropyUsing: self optimizationAlgorithm;
		yourself
]
