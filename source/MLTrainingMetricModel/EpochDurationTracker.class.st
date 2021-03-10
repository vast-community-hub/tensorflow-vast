Class {
	#name : 'EpochDurationTracker',
	#superclass : 'TrainingMetricTracker',
	#instVars : [
		'timestampAtStart',
		'stepsDurations'
	],
	#category : 'MLTrainingMetricModel'
}

{ #category : 'Accessing' }
EpochDurationTracker class >> averageStepDurationMetricKey [

	^'average-step-duration'
]

{ #category : 'Accessing' }
EpochDurationTracker class >> metricKey [

	^'epoch-duration'
]

{ #category : 'Processing' }
EpochDurationTracker >> measureMetricDuring: aFittingStage onEpochEndWithin: aTrainingContext [

	aTrainingContext
		addMetricValued: stepsDurations mean
		during: aFittingStage
		to: self class averageStepDurationMetricKey.
	aTrainingContext
		addMetricValued: stepsDurations sum
		during: aFittingStage
		to: self class metricKey
]

{ #category : 'Processing' }
EpochDurationTracker >> measureMetricDuring: aFittingStage onEpochStartWithin: aTrainingContext [

	stepsDurations := OrderedCollection new
]

{ #category : 'Processing' }
EpochDurationTracker >> measureMetricDuring: aFittingStage onStepEndUsing: aTrainingEpochInput within: aTrainingContext [

	stepsDurations add: self timestampNow - timestampAtStart
]

{ #category : 'Processing' }
EpochDurationTracker >> measureMetricDuring: aFittingStage onStepStartUsing: aStepInput within: aTrainingContext [

	timestampAtStart := self timestampNow
]

{ #category : 'Preprocessing' }
EpochDurationTracker >> prepareMetricsWithin: aNeuralNetworkTrainingContext [
	" do nothing "


]

{ #category : 'Processing',
  #vaVisibility : 'private' }
EpochDurationTracker >> timestampNow [

	^DateAndTime now asMilliseconds
]
