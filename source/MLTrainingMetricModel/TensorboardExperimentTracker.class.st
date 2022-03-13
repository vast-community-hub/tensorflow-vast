Class {
	#name : 'TensorboardExperimentTracker',
	#superclass : 'TrainingMetricTracker',
	#instVars : [
		'logsFolder',
		'trainingWriter',
		'validationWriter'
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

	| writer |

	writer := self suitableWriterFor: aFittingStage.
	self
		writeLastLossValueDuring: aFittingStage within: aTrainingContext using: writer;
		writeLastAccuracyValueDuring: aFittingStage within: aTrainingContext using: writer
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

	| timestamp |

	timestamp :=
		'%1-%2'
			bindWith: (Date today stsFormattedUsing: '%Y%m%d')
			with: (Time now stsFormattedUsing: '%H%M%S').
	trainingWriter :=
		aNeuralNetworkTrainingContext
			buildSummaryWriterTo: (logsFolder asFileReference / 'fit' / timestamp / 'train') asString.
	validationWriter :=
		aNeuralNetworkTrainingContext buildSummaryWriterTo:
			(logsFolder asFileReference / 'fit' / timestamp / 'validation') asString
]

{ #category : 'Processing',
  #vaVisibility : 'private' }
TensorboardExperimentTracker >> suitableWriterFor: aFittingStage [

	^aFittingStage whenTrainDo: [trainingWriter] whenValidationDo: [validationWriter]
]

{ #category : 'Processing',
  #vaVisibility : 'private' }
TensorboardExperimentTracker >> writeLastAccuracyValueDuring: aFittingStage within: aTrainingContext using: writer [

	aTrainingContext
		withMetricKnownAs: CategoricalPredictionAccuracyTracker metricKey
		during: aFittingStage
		do: [:accuracyValues |
			writer
				writeScalar: accuracyValues last
				atStep: accuracyValues size - 1
				tagged: 'epoch_accuracy']
]

{ #category : 'Processing',
  #vaVisibility : 'private' }
TensorboardExperimentTracker >> writeLastLossValueDuring: aFittingStage within: aTrainingContext using: writer [

	aTrainingContext
		withMetricKnownAs: aTrainingContext lossMetricKey
		during: aFittingStage
		do: [:lossValues |
			writer writeScalar: lossValues last atStep: lossValues size - 1 tagged: 'epoch_loss']
]
