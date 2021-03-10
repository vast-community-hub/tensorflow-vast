Class {
	#name : 'TrainingMetricTracker',
	#superclass : 'Object',
	#category : 'MLTrainingMetricModel'
}

{ #category : 'Processing' }
TrainingMetricTracker >> measureMetricDuring: aFittingStage onEpochEndWithin: aTrainingContext [

	self subclassResponsibility
]

{ #category : 'Processing' }
TrainingMetricTracker >> measureMetricDuring: aFittingStage onEpochStartWithin: aTrainingContext [

	self subclassResponsibility
]

{ #category : 'Processing' }
TrainingMetricTracker >> measureMetricDuring: aFittingStage onStepEndUsing: aStepInput within: aTrainingContext [

	self subclassResponsibility
]

{ #category : 'Processing' }
TrainingMetricTracker >> measureMetricDuring: aFittingStage onStepStartUsing: aStepInput within: aTrainingContext [

	self subclassResponsibility
]

{ #category : 'Preprocessing' }
TrainingMetricTracker >> prepareMetricsWithin: aTrainingContext [

	self subclassResponsibility
]
