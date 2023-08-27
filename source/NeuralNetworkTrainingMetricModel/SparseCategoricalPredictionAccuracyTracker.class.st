Class {
	#name : 'SparseCategoricalPredictionAccuracyTracker',
	#superclass : 'TrainingMetricTracker',
	#instVars : [
		'accuracy',
		'accuraciesDuringOneEpoch'
	],
	#category : 'NeuralNetworkTrainingMetricModel'
}

{ #category : 'Accessing' }
SparseCategoricalPredictionAccuracyTracker class >> metricKey [

	^'sparse_categorical_accuracy'
]

{ #category : 'Processing' }
SparseCategoricalPredictionAccuracyTracker >> measureMetricDuring: aFittingStage onEpochEndWithin: aTrainingContext [

	aTrainingContext
		addMetricValued: accuraciesDuringOneEpoch mean
		during: aFittingStage
		to: self class metricKey
]

{ #category : 'Processing' }
SparseCategoricalPredictionAccuracyTracker >> measureMetricDuring: aFittingStage onEpochStartWithin: aTrainingContext [

	accuraciesDuringOneEpoch := OrderedCollection new
]

{ #category : 'Processing' }
SparseCategoricalPredictionAccuracyTracker >> measureMetricDuring: aFittingStage onStepEndUsing: aStepInput within: aTrainingContext [

	accuraciesDuringOneEpoch add: (accuracy computeWith: aStepInput) scalarOutput
]

{ #category : 'Processing' }
SparseCategoricalPredictionAccuracyTracker >> measureMetricDuring: aFittingStage onStepStartUsing: aStepInput within: aTrainingContext [
	" do nothing "


]

{ #category : 'Preprocessing' }
SparseCategoricalPredictionAccuracyTracker >> prepareMetricsWithin: aTrainingContext [

	accuracy := aTrainingContext buildSparseCategoricalPredictionAccuracy
]
