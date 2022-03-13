Class {
	#name : 'TrainingWithTensorboardExperimentTrackerTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'MLTrainingMetricModelTests'
}

{ #category : 'accessing',
  #vaVisibility : 'private' }
TrainingWithTensorboardExperimentTrackerTest >> modelWithTwoOutputUnits [

	^(SequentialModelBuilder on: tf)
		addDenseLayerSized: 2
			builtWith: [:layer |
				layer
					inputSize: 3;
					weightInitializedToZero;
					biasInitializedTo: #(0.2 0.8)];
		buildApplyingToLogits: [:logits | logits argMaxOnRows]
]

{ #category : 'tests' }
TrainingWithTensorboardExperimentTrackerTest >> testTrackExperimentWithNoValidation [

	| model folder |

	model := self modelWithTwoOutputUnits.

	(NeuralNetworkTrainer on: tf)
		minimizeSparseCategoricalCrossEntropyUsing: (GradientDescent scalingBy: 0.2);
		trackMetricWith: (TensorboardExperimentTracker storingTo: './test-logs');
		stopTrainingWhen: (CompletedNumberOfTraining after: 10);
		train: model toFit: self trainingDataset.

	folder := FileSystemAPI current directoryNamed: './test-logs'.
	[| content folderWithDate |
		content := folder allFileAndDirectoryEntries.
		self assert: content size equals: 6.
		self assert: (content at: 1) dName equals: 'fit'.
		folderWithDate := (content at: 2) dName.
		self assert: (content at: 3) dName equals: ('%1\train' bindWith: folderWithDate).
		self assert: (content at: 4) stSize equals: 518.
		self assert: (content at: 5) dName equals: ('%1\validation' bindWith: folderWithDate).
		self assert: (content at: 6) stSize equals: 40]
			ensure: [folder deleteAll]
]

{ #category : 'tests' }
TrainingWithTensorboardExperimentTrackerTest >> testTrackExperimentWithValidationSet [

	| model folder |

	model := self modelWithTwoOutputUnits.

	(NeuralNetworkTrainer on: tf)
		minimizeSparseCategoricalCrossEntropyUsing: (GradientDescent scalingBy: 0.2);
		trackMetricWith: (TensorboardExperimentTracker storingTo: './test-logs');
		stopTrainingWhen: (CompletedNumberOfTraining after: 10);
		train: model toFit: self trainingDatasetWithValidation.

	folder := FileSystemAPI current directoryNamed: './test-logs'.
	[| content folderWithDate |
		content := folder allFileAndDirectoryEntries.
		self assert: content size equals: 6.
		self assert: (content at: 1) dName equals: 'fit'.
		folderWithDate := (content at: 2) dName.
		self assert: (content at: 3) dName equals: ('%1\train' bindWith: folderWithDate).
		self assert: (content at: 4) stSize equals: 518.
		self assert: (content at: 5) dName equals: ('%1\validation' bindWith: folderWithDate).
		self assert: (content at: 6) stSize equals: 518]
			ensure: [folder deleteAll]
]

{ #category : 'accessing',
  #vaVisibility : 'private' }
TrainingWithTensorboardExperimentTrackerTest >> trainingDataset [

	^SampleDataset new
		bindTrainingSetTo: #((0 0 1) (0 1 1) (1 0 0) (1 1 1)) asFloatTensor
			withLabels: #(0 1 0 0) asInt32Tensor;
		yourself
]

{ #category : 'tests',
  #vaVisibility : 'private' }
TrainingWithTensorboardExperimentTrackerTest >> trainingDatasetWithValidation [

	^SampleDataset new
		bindTrainingSetTo: #((0 0 1) (0 1 1) (1 0 0) (1 1 1)) asFloatTensor
			withLabels: #(0 1 0 0) asInt32Tensor;
		bindValidationSetTo: #((0 0 1) (0 1 1) (1 0 0) (1 1 1)) asFloatTensor
			withLabels: #(0 1 0 0) asInt32Tensor;
		yourself
]
