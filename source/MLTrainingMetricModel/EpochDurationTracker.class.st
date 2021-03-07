Class {
	#name : 'EpochDurationTracker',
	#superclass : 'TrainingMetricTracker',
	#instVars : [
		'measuredTimes',
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
EpochDurationTracker >> measureMetricAfterEpochWithin: aTrainingContext [

	aTrainingContext addMetricValued: stepsDurations mean to: self class averageStepDurationMetricKey.
	aTrainingContext addMetricValued: stepsDurations sum to: self class metricKey
]

{ #category : 'Processing' }
EpochDurationTracker >> measureMetricAfterStepWith: aTrainingEpochInput within: aTrainingContext [

	| timestampAtEnd |

	timestampAtEnd := DateAndTime now asMilliseconds.
	stepsDurations add: (timestampAtEnd - timestampAtStart)
]

{ #category : 'Processing' }
EpochDurationTracker >> measureMetricBeforeEpochWithin: aNeuralNetworkTrainingContext [

	stepsDurations := OrderedCollection new
]

{ #category : 'Processing' }
EpochDurationTracker >> measureMetricBeforeStepWith: aTrainingEpochInput within: aTrainingContext [

	timestampAtStart := DateAndTime now asMilliseconds
]

{ #category : 'Preprocessing' }
EpochDurationTracker >> prepareMetricsWithin: aNeuralNetworkTrainingContext [
	" do nothing "


]
