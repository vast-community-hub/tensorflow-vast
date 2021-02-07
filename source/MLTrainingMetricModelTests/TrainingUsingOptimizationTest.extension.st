Extension {
	#name : 'TrainingUsingOptimizationTest'
}

{ #category : '*MLTrainingMetricModelTests',
 #vaCategories : ['Tests'] }
TrainingUsingOptimizationTest >> testEpochDurationWhenMinimizingCategoricalCrossEntropy [

	| model summary durations |

	model := self modelWithTwoOutputUnits.
	summary :=
		self trainerMinimizingCategoricalCrossEntropy
			trackMetricWith: EpochDurationTracker new;
			stopTrainingWhen: (CompletedNumberOfTraining after: 10);
			train: model toFit: self inputDatasetWithLabelsProbabilities.

	durations := summary metricKnownAs: EpochDurationTracker metricKey.
	self assert: durations size equals: 10.
	self assert: (durations conform: [:duration | duration >= 0])
]

{ #category : '*MLTrainingMetricModelTests',
 #vaCategories : ['Tests'] }
TrainingUsingOptimizationTest >> testEpochDurationWhenMinimizingMeanSquaredError [

	| model summary durations |

	model := self modelWithTwoOutputUnits.
	summary :=
		self trainerMinimizingMeanSquaredError
			trackMetricWith: EpochDurationTracker new;
			stopTrainingWhen: (CompletedNumberOfTraining after: 10);
			train: model toFit: self inputDatasetWithLabelsProbabilities.

	durations := summary metricKnownAs: EpochDurationTracker metricKey.
	self assert: durations size equals: 10.
	self assert: (durations conform: [:duration | duration >= 0])
]

{ #category : '*MLTrainingMetricModelTests',
 #vaCategories : ['Tests'] }
TrainingUsingOptimizationTest >> testEpochDurationWhenMinimizingSparseCategoricalCrossEntropy [

	| model summary durations |

	model := self modelWithTwoOutputUnits.
	summary :=
		self trainerMinimizingSparseCategoricalCrossEntropy
			trackMetricWith: EpochDurationTracker new;
			stopTrainingWhen: (CompletedNumberOfTraining after: 10);
			train: model toFit: self inputDatasetWithLabels.

	durations := summary metricKnownAs: EpochDurationTracker metricKey.
	self assert: durations size equals: 10.
	self assert: (durations conform: [:duration | duration >= 0])
]
