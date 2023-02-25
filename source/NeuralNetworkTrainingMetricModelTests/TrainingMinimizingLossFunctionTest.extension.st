Extension {
	#name : 'TrainingMinimizingLossFunctionTest'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingLossFunctionTest >> expectedAccuracyAfterOneEpoch [

	self subclassResponsibility
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingLossFunctionTest >> expectedAccuracyThroughTenEpochs [

	self subclassResponsibility
]

{ #category : 'Tests' }
TrainingMinimizingLossFunctionTest >> testAccuracyAfterOneEpoch [

	| model summary |

	model := self modelWithTwoOutputUnits.
	summary :=
		self neuralNetworkTrainer
			trackMetricWith: CategoricalPredictionAccuracyTracker new; 
			stopTrainingWhen: (CompletedNumberOfEpochs after: 1);
			train: model toFit: self trainingDataset.

	self
		assert: summary historicalTrainingAccuracy
		isArrayCloseTo: self expectedAccuracyAfterOneEpoch
]

{ #category : 'Tests' }
TrainingMinimizingLossFunctionTest >> testAccuracyThroughTenEpochs [

	| model summary |

	model := self modelWithTwoOutputUnits.
	summary :=
		self neuralNetworkTrainer
			trackMetricWith: CategoricalPredictionAccuracyTracker new;
			stopTrainingWhen: (CompletedNumberOfEpochs after: 10);
			train: model toFit: self trainingDataset.

	self
		assert: summary historicalTrainingAccuracy
		isArrayCloseTo: self expectedAccuracyThroughTenEpochs
]

{ #category : 'Tests' }
TrainingMinimizingLossFunctionTest >> testEpochDuration [

	| model summary durations |

	model := self modelWithTwoOutputUnits.
	summary :=
		self neuralNetworkTrainer
			trackMetricWith: EpochDurationTracker new;
			stopTrainingWhen: (CompletedNumberOfEpochs after: 10);
			train: model toFit: self trainingDataset.

	durations := summary trainingMetricKnownAs: EpochDurationTracker metricKey.
	self assert: durations size equals: 10.
	self assert: (durations conform: [:duration | duration >= 0])
]

{ #category : 'Tests' }
TrainingMinimizingLossFunctionTest >> testFittingLogger [

	| model stream inputInBatches |

	stream := WriteStream on: String new.
	model := self modelWithTwoOutputUnits.

	inputInBatches :=
		(SampleDatasetComputationAware on: tf applying: [:dataset | dataset inBatchesOf: 2])
			bindSetsFrom: self trainingAndValidationDataset.

	self neuralNetworkTrainer
		trackMetricWith: (NeuralNetworkFittingLogger on: stream);
		stopTrainingWhen: (CompletedNumberOfEpochs after: 2);
		train: model toFit: inputInBatches.

	self assert: (stream contents subStrings: String crlf) size equals: 25
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingLossFunctionTest >> trainingAndValidationDataset [

	^SampleDataset new
		bindTrainingSetTo: self inputTensor withLabels: self targetTensor;
		bindValidationSetTo: self inputTensor withLabels: self targetTensor;
		yourself
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingLossFunctionTest >> trainingDataset [

	^SampleDataset new
		bindTrainingSetTo: self inputTensor withLabels: self targetTensor;
		yourself
]
