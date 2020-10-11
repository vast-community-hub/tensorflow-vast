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
