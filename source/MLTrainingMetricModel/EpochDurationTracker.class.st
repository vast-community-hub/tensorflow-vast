Class {
	#name : 'EpochDurationTracker',
	#superclass : 'TrainingMetricTracker',
	#instVars : [
		'measuredTimes',
		'timestampAtStart'
	],
	#category : 'MLTrainingMetricModel'
}

{ #category : 'Accessing' }
EpochDurationTracker class >> metricKey [

	^'epoch-duration'
]

{ #category : 'Processing' }
EpochDurationTracker >> measureMetricAfterEpochWith: aTrainingEpochInput within: aTrainingContext [

	| timestampAtEnd |

	timestampAtEnd := DateAndTime now asMilliseconds.
	aTrainingContext addMetricValued: (timestampAtEnd - timestampAtStart) to: self class metricKey
]

{ #category : 'Processing' }
EpochDurationTracker >> measureMetricBeforeEpochWith: aDictionary within: aNeuralNetworkTrainingContext [

	timestampAtStart := DateAndTime now asMilliseconds
]

{ #category : 'Preprocessing' }
EpochDurationTracker >> prepareMetricsWithin: aNeuralNetworkTrainingContext [
	" do nothing "


]
