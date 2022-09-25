Class {
	#name : 'CategoricalPredictionAccuracyTracker',
	#superclass : 'TrainingMetricTracker',
	#instVars : [
		'accuracy',
		'accuraciesDuringOneEpoch'
	],
	#category : 'NeuralNetworkTrainingMetricModel'
}

{ #category : 'Accessing' }
CategoricalPredictionAccuracyTracker class >> metricKey [

	^'accuracy'
]

{ #category : 'Accessing' }
CategoricalPredictionAccuracyTracker class >> stepsMetricKey [

	^'accuracy-by-step'
]

{ #category : 'Processing' }
CategoricalPredictionAccuracyTracker >> measureMetricDuring: aFittingStage onEpochEndWithin: aTrainingContext [

	aTrainingContext
		addMetricValued: accuraciesDuringOneEpoch mean
		during: aFittingStage
		to: self class metricKey
]

{ #category : 'Processing' }
CategoricalPredictionAccuracyTracker >> measureMetricDuring: aFittingStage onEpochStartWithin: aTrainingContext [

	accuraciesDuringOneEpoch := OrderedCollection new
]

{ #category : 'Processing' }
CategoricalPredictionAccuracyTracker >> measureMetricDuring: aFittingStage onStepEndUsing: aStepInput within: aTrainingContext [

	accuraciesDuringOneEpoch add: (accuracy computeWith: aStepInput) scalarOutput.

	aTrainingContext
		addMetricValued: accuraciesDuringOneEpoch last
		during: aFittingStage
		to: self class stepsMetricKey
]

{ #category : 'Processing' }
CategoricalPredictionAccuracyTracker >> measureMetricDuring: aFittingStage onStepStartUsing: aStepInput within: aTrainingContext [
	" do nothing "


]

{ #category : 'Preprocessing' }
CategoricalPredictionAccuracyTracker >> prepareMetricsWithin: aTrainingContext [

	accuracy := aTrainingContext buildCategoricalPredictionAccuracy
]
