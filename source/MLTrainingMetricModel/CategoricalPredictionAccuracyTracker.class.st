Class {
	#name : 'CategoricalPredictionAccuracyTracker',
	#superclass : 'TrainingMetricTracker',
	#instVars : [
		'accuracy',
		'accuraciesDuringOneEpoch'
	],
	#category : 'MLTrainingMetricModel'
}

{ #category : 'Accessing' }
CategoricalPredictionAccuracyTracker class >> metricKey [

	^'training-accuracy'
]

{ #category : 'Processing' }
CategoricalPredictionAccuracyTracker >> measureMetricAfterEpochWithin: aTrainingContext [

	aTrainingContext addMetricValued: accuraciesDuringOneEpoch mean to: self class metricKey
]

{ #category : 'Preprocessing' }
CategoricalPredictionAccuracyTracker >> measureMetricAfterStepWith: aTrainingEpochInput within: aTrainingContext [

	accuraciesDuringOneEpoch add: (accuracy computeWith: aTrainingEpochInput) scalarOutput
]

{ #category : 'Processing' }
CategoricalPredictionAccuracyTracker >> measureMetricBeforeEpochWithin: aTrainingContext [

	accuraciesDuringOneEpoch := OrderedCollection new
]

{ #category : 'Preprocessing' }
CategoricalPredictionAccuracyTracker >> measureMetricBeforeStepWith: aTrainingEpochInput within: aTrainingContext [
	" do nothing "


]

{ #category : 'Preprocessing' }
CategoricalPredictionAccuracyTracker >> prepareMetricsWithin: aTrainingContext [

	accuracy := aTrainingContext buildCategoricalPredictionAccuracy
]
