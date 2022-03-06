Class {
	#name : 'TensorboardExperimentTracker',
	#superclass : 'TrainingMetricTracker',
	#instVars : [
		'writer',
		'logsFolder'
	],
	#category : 'MLTrainingMetricModel'
}

{ #category : 'Instance Creation' }
TensorboardExperimentTracker class >> storingTo: aLogsLocation [

	^self new initializeStoringTo: aLogsLocation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TensorboardExperimentTracker >> initializeStoringTo: aLogsLocation [

	logsFolder := aLogsLocation
]

{ #category : 'Processing' }
TensorboardExperimentTracker >> measureMetricDuring: aFittingStage onEpochEndWithin: aTrainingContext [

	| lossValues |

	lossValues := aTrainingContext
		metricKnownAs: aTrainingContext lossMetricKey
		during: aFittingStage.
	writer
		writeScalar: lossValues last
		atStep: lossValues size
		tagged: (aFittingStage metricKeyNamed: aTrainingContext lossMetricKey)
]

{ #category : 'Processing' }
TensorboardExperimentTracker >> measureMetricDuring: aTrainingStage onEpochStartWithin: aNeuralNetworkTrainingContext [

	" do nothing - jvanecek "


]

{ #category : 'Processing' }
TensorboardExperimentTracker >> measureMetricDuring: aTrainingStage onStepEndUsing: aStepInput within: aNeuralNetworkTrainingContext [


]

{ #category : 'Processing' }
TensorboardExperimentTracker >> measureMetricDuring: aTrainingStage onStepStartUsing: aStepInput within: aNeuralNetworkTrainingContext [

	" do nothing - jvanecek "


]

{ #category : 'Preprocessing' }
TensorboardExperimentTracker >> prepareMetricsWithin: aNeuralNetworkTrainingContext [

	
	writer := aNeuralNetworkTrainingContext buildSummaryWriterTo: logsFolder 
]
