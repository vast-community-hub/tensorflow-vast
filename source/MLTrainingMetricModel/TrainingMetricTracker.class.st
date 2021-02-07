Class {
	#name : 'TrainingMetricTracker',
	#superclass : 'Object',
	#category : 'MLTrainingMetricModel'
}

{ #category : 'Processing' }
TrainingMetricTracker >> measureMetricAfterEpochWith: aTrainingEpochInput within: aTrainingContext [

	self subclassResponsibility
]

{ #category : 'Processing' }
TrainingMetricTracker >> measureMetricBeforeEpochWith: aTrainingEpochInput within: aTrainingContext [

	self subclassResponsibility
]

{ #category : 'Preprocessing' }
TrainingMetricTracker >> prepareMetricsWithin: aTrainingContext [

	self subclassResponsibility
]
