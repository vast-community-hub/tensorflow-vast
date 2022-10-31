Extension {
	#name : 'TrainingUsingOptimizationTest'
}

{ #category : '*NeuralNetworkTrainingMetricModelTests',
 #vaCategories : ['Tests'],
  #vaVisibility : 'private' }
TrainingUsingOptimizationTest >> assertConsistencyInDurationsTrackedFor: summary [

	| stepAvgDurations epochDurations |

	epochDurations := summary trainingMetricKnownAs: EpochDurationTracker metricKey.
	stepAvgDurations :=
		summary trainingMetricKnownAs: EpochDurationTracker averageStepDurationMetricKey.

	self assert: epochDurations size equals: 10.
	self assert: (epochDurations conform: [:duration | duration >= 0]).
	self assert: stepAvgDurations size equals: 10.
	self assert: (stepAvgDurations conform: [:duration | duration >= 0]).

	epochDurations
		with: stepAvgDurations
		do: [:epochDuration :stepAvgDuration |
			self assert: stepAvgDuration * 2 equals: epochDuration]
]

{ #category : '*NeuralNetworkTrainingMetricModelTests',
 #vaCategories : ['Tests'] }
TrainingUsingOptimizationTest >> testAccuracyMinimizingCategoricalCrossEntropyInBatches [

	| model summary inputInBatches |

	model := self modelWithTwoOutputUnits.

	inputInBatches :=
		(SampleDatasetComputationAware on: tf applying: [:dataset | dataset inBatchesOf: 2])
			bindSetsFrom: self inputDatasetWithLabelsProbabilities.

	summary :=
		self trainerMinimizingCategoricalCrossEntropy
			trackMetricWith: CategoricalPredictionAccuracyTracker new;
			stopTrainingWhen: (CompletedNumberOfEpochs after: 5);
			train: model toFit: inputInBatches.

	self assert: summary historicalTrainingAccuracy isArrayCloseTo: #(0.5 0.5 0.5 0.5 0.5)
]

{ #category : '*NeuralNetworkTrainingMetricModelTests',
 #vaCategories : ['Tests'] }
TrainingUsingOptimizationTest >> testAccuracyMinimizingMeanSquaredErrorInBatches [

	| model summary inputInBatches |

	model := self modelWithTwoOutputUnits.

	inputInBatches :=
		(SampleDatasetComputationAware on: tf applying: [:dataset | dataset inBatchesOf: 2])
			bindSetsFrom: self inputDatasetWithLabelsProbabilities.

	summary :=
		self trainerMinimizingMeanSquaredError
			trackMetricWith: CategoricalPredictionAccuracyTracker new;
			stopTrainingWhen: (CompletedNumberOfEpochs after: 5);
			train: model toFit: inputInBatches.

	self assert: summary historicalTrainingAccuracy isArrayCloseTo: #(0.5 0.5 0.5 0.5 0.5)
]

{ #category : '*NeuralNetworkTrainingMetricModelTests',
 #vaCategories : ['Tests'] }
TrainingUsingOptimizationTest >> testAccuracyMinimizingSparseCategoricalCrossEntropyInBatches [

	| model summary inputInBatches |

	model := self modelWithTwoOutputUnits.

	inputInBatches :=
		(SampleDatasetComputationAware on: tf applying: [:dataset | dataset inBatchesOf: 2])
			bindSetsFrom: self inputDatasetWithLabels.

	summary :=
		self trainerMinimizingSparseCategoricalCrossEntropy
			trackMetricWith: CategoricalPredictionAccuracyTracker new;
			stopTrainingWhen: (CompletedNumberOfEpochs after: 5);
			train: model toFit: inputInBatches.

	self assert: summary historicalTrainingAccuracy isArrayCloseTo: #(0.25 0.25 0.25 0.25 0.25)
]

{ #category : '*NeuralNetworkTrainingMetricModelTests',
 #vaCategories : ['Tests'] }
TrainingUsingOptimizationTest >> testEpochDurationWhenMinimizingCategoricalCrossEntropy [

	| model inputInBatches summary |

	model := self modelWithTwoOutputUnits.

	inputInBatches :=
		(SampleDatasetComputationAware on: tf applying: [:dataset | dataset inBatchesOf: 2])
			bindSetsFrom: self inputDatasetWithLabelsProbabilities.

	summary :=
		self trainerMinimizingCategoricalCrossEntropy
			trackMetricWith: EpochDurationTracker new;
			stopTrainingWhen: (CompletedNumberOfEpochs after: 10);
			train: model toFit: inputInBatches.

	self assertConsistencyInDurationsTrackedFor: summary
]

{ #category : '*NeuralNetworkTrainingMetricModelTests',
 #vaCategories : ['Tests'] }
TrainingUsingOptimizationTest >> testEpochDurationWhenMinimizingMeanSquaredError [

	| model inputInBatches summary |

	model := self modelWithTwoOutputUnits.

	inputInBatches :=
		(SampleDatasetComputationAware on: tf applying: [:dataset | dataset inBatchesOf: 2])
			bindSetsFrom: self inputDatasetWithLabelsProbabilities.

	summary :=
		self trainerMinimizingMeanSquaredError
			trackMetricWith: EpochDurationTracker new;
			stopTrainingWhen: (CompletedNumberOfEpochs after: 10);
			train: model toFit: inputInBatches.

	self assertConsistencyInDurationsTrackedFor: summary
]

{ #category : '*NeuralNetworkTrainingMetricModelTests',
 #vaCategories : ['Tests'] }
TrainingUsingOptimizationTest >> testEpochDurationWhenMinimizingSparseCategoricalCrossEntropy [

	| model inputInBatches summary |

	model := self modelWithTwoOutputUnits.
	
	inputInBatches :=
		(SampleDatasetComputationAware on: tf applying: [:dataset | dataset inBatchesOf: 2])
			bindSetsFrom: self inputDatasetWithLabels.
	
	summary :=
		(self trainerMinimizingSparseCategoricalCrossEntropy)
			trackMetricWith: EpochDurationTracker new;
			stopTrainingWhen: (CompletedNumberOfEpochs after: 10);
			train: model toFit: inputInBatches.
			
	self assertConsistencyInDurationsTrackedFor: summary
]
