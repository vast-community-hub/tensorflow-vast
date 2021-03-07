Class {
	#name : 'TrainingMetricTracker',
	#superclass : 'Object',
	#category : 'MLTrainingMetricModel'
}

{ #category : 'Processing' }
TrainingMetricTracker >> measureMetricAfterEpochWithin: aTrainingContext [

	self subclassResponsibility
]

{ #category : 'Preprocessing' }
TrainingMetricTracker >> measureMetricAfterStepWith: aTrainingEpochInput within: aTrainingContext [

	self subclassResponsibility
]

{ #category : 'Processing' }
TrainingMetricTracker >> measureMetricBeforeEpochWithin: aTrainingContext [

	self subclassResponsibility
]

{ #category : 'Preprocessing' }
TrainingMetricTracker >> measureMetricBeforeStepWith: aTrainingEpochInput within: aTrainingContext [

	self subclassResponsibility
]

{ #category : 'Preprocessing' }
TrainingMetricTracker >> prepareMetricsWithin: aTrainingContext [

	self subclassResponsibility
]
