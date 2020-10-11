Class {
	#name : 'CategoricalPredictionAccuracyTracker',
	#superclass : 'TrainingMetricTracker',
	#instVars : [
		'accuracy'
	],
	#category : 'MLTrainingMetricModel'
}

{ #category : 'Accessing' }
CategoricalPredictionAccuracyTracker class >> metricKey [

	^'training-accuracy'
]

{ #category : 'Processing' }
CategoricalPredictionAccuracyTracker >> measureMetricConsidering: aTrainingEpochInput within: aTrainingContext [

	aTrainingContext
		addMetricValued: (accuracy computeWith: aTrainingEpochInput) scalarOutput
		to: self class metricKey
]

{ #category : 'Preprocessing' }
CategoricalPredictionAccuracyTracker >> prepareMetricsWithin: aTrainingContext [

	accuracy := aTrainingContext buildCategoricalPredictionAccuracy
]
