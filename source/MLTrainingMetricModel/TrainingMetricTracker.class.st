Class {
	#name : 'TrainingMetricTracker',
	#superclass : 'Object',
	#category : 'MLTrainingMetricModel'
}

{ #category : 'Processing' }
TrainingMetricTracker >> measureMetricConsidering: aTrainingEpochInput within: aTrainingContext [

	self subclassResponsibility
]

{ #category : 'Preprocessing' }
TrainingMetricTracker >> prepareMetricsWithin: aTrainingContext [

	self subclassResponsibility
]
