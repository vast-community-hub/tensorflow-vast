Class {
	#name : 'TensorboardExperimentTracker',
	#superclass : 'TrainingMetricTracker',
	#instVars : [
		'logsFolder',
		'trainingWriter',
		'validationWriter'
	],
	#category : 'NeuralNetworkTrainingMetricModel'
}

{ #category : 'Instance Creation' }
TensorboardExperimentTracker class >> new [

	^self storingTo: (
		'%1-%2'
			bindWith: (Date today stsFormattedUsing: '%Y%m%d')
			with: (Time now stsFormattedUsing: '%H%M%S'))
]

{ #category : 'Instance Creation' }
TensorboardExperimentTracker class >> storingTo: aLogsLocation [

	^super new initializeStoringTo: aLogsLocation
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
TensorboardExperimentTracker >> measureMetricDuring: aFittingStage onStepEndUsing: aStepInput within: aTrainingContext [

	| writer |

	writer := self suitableWriterFor: aFittingStage.
	aFittingStage
		whenTrainDo: []
		whenValidationDo: [
			self
				writeLastStepAccuracyValuDuring: aFittingStage
				within: aTrainingContext
				using: writer]
]

{ #category : 'Processing' }
TensorboardExperimentTracker >> measureMetricDuring: aTrainingStage onStepStartUsing: aStepInput within: aNeuralNetworkTrainingContext [

	" do nothing - jvanecek "


]

{ #category : 'Preprocessing' }
TensorboardExperimentTracker >> prepareMetricsWithin: aNeuralNetworkTrainingContext [

	trainingWriter :=
		aNeuralNetworkTrainingContext
			buildSummaryWriterTo: (logsFolder asFileReference / 'train') asString.
	validationWriter :=
		aNeuralNetworkTrainingContext
			buildSummaryWriterTo: (logsFolder asFileReference / 'validation') asString
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

{ #category : 'Processing' }
TensorboardExperimentTracker >> writeLastStepAccuracyValuDuring: aFittingStage within: aTrainingContext using: writer [

	aTrainingContext
		withMetricKnownAs: CategoricalPredictionAccuracyTracker stepsMetricKey
		during: aFittingStage
		do: [:accuracyValues |
			writer
				writeScalar: accuracyValues last
				atStep: accuracyValues size - 1
				tagged: 'evaluation_accuracy_vs_iterations']
]
