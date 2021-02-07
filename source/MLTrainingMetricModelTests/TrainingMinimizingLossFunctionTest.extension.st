Extension {
	#name : 'TrainingMinimizingLossFunctionTest'
}

{ #category : '*MLTrainingMetricModelTests',
 #vaCategories : ['Accessing'],
  #vaVisibility : 'private' }
TrainingMinimizingLossFunctionTest >> expectedAccuracyAfterOneEpoch [

	self subclassResponsibility
]

{ #category : '*MLTrainingMetricModelTests',
 #vaCategories : ['Accessing'],
  #vaVisibility : 'private' }
TrainingMinimizingLossFunctionTest >> expectedAccuracyThroughTenEpochs [

	self subclassResponsibility
]

{ #category : '*MLTrainingMetricModelTests',
 #vaCategories : ['Tests'] }
TrainingMinimizingLossFunctionTest >> testAccuracyAfterOneEpoch [

	| model summary |

	model := self modelWithTwoOutputUnits.
	summary :=
		self neuralNetworkTrainer
			trackMetricWith: CategoricalPredictionAccuracyTracker new; 
			stopTrainingWhen: (CompletedNumberOfTraining after: 1);
			train: model toFitPredictionFrom: self inputTensor to: self targetTensor.

	self
		assert: summary historicalTrainingAccuracy
		isArrayCloseTo: self expectedAccuracyAfterOneEpoch
]

{ #category : '*MLTrainingMetricModelTests',
 #vaCategories : ['Tests'] }
TrainingMinimizingLossFunctionTest >> testAccuracyThroughTenEpochs [

	| model summary |

	model := self modelWithTwoOutputUnits.
	summary :=
		self neuralNetworkTrainer
			trackMetricWith: CategoricalPredictionAccuracyTracker new;
			stopTrainingWhen: (CompletedNumberOfTraining after: 10);
			train: model toFitPredictionFrom: self inputTensor to: self targetTensor.

	self
		assert: summary historicalTrainingAccuracy
		isArrayCloseTo: self expectedAccuracyThroughTenEpochs
]

{ #category : '*MLTrainingMetricModelTests',
 #vaCategories : ['Tests'] }
TrainingMinimizingLossFunctionTest >> testEpochDuration [

	| model summary durations |

	model := self modelWithTwoOutputUnits.
	summary :=
		self neuralNetworkTrainer
			trackMetricWith: EpochDurationTracker new;
			stopTrainingWhen: (CompletedNumberOfTraining after: 10);
			train: model toFitPredictionFrom: self inputTensor to: self targetTensor.

	durations := summary metricKnownAs: EpochDurationTracker metricKey.
	self assert: durations size equals: 10.
	self assert: (durations conform: [:duration | duration >= 0])
]
