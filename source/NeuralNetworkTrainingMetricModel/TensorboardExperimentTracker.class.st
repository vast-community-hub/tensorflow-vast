Class {
	#name : 'TensorboardExperimentTracker',
	#superclass : 'TrainingMetricTracker',
	#instVars : [
		'logsFolder',
		'trainingWriter',
		'validationWriter',
		'timestampAtStart'
	],
	#category : 'NeuralNetworkTrainingMetricModel'
}

{ #category : 'Instance Creation' }
TensorboardExperimentTracker class >> formattedTimestamp [
	
	^ '%1-%2' 
		bindWith: (Date today stsFormattedUsing: '%Y%m%d')
		with: (Time now stsFormattedUsing: '%H%M%S')
]

{ #category : 'Instance Creation' }
TensorboardExperimentTracker class >> new [

	^ self storingTo: self formattedTimestamp
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

	aTrainingContext
		withAllMetricsCollectedDuring: aFittingStage
		do: [:metricName :metricValues |
			writer
				writeScalar: metricValues last
				atStep: metricValues size - 1
				tagged: ('epoch_%1' bindWith: metricName).

			aFittingStage
				whenTrainDo: []
				whenValidationDo: [
					writer
						writeScalar: metricValues last
						atStep: aTrainingContext trainingStepValue
						tagged: ('evaluation_%1_vs_iterations' bindWith: metricName)]]
]

{ #category : 'Processing' }
TensorboardExperimentTracker >> measureMetricDuring: aTrainingStage onEpochStartWithin: aNeuralNetworkTrainingContext [

	timestampAtStart := DateAndTime now asMilliseconds


]

{ #category : 'Processing' }
TensorboardExperimentTracker >> measureMetricDuring: aFittingStage onStepEndUsing: aStepInput within: aTrainingContext [
	
	" do nothing - jvanecek " 
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
			buildSummaryWriterTo: (logsFolder asFileReference / 'validation') asString.
			
	trainingWriter writeGraphSummaryAtStep: 0
]

{ #category : 'Processing',
  #vaVisibility : 'private' }
TensorboardExperimentTracker >> suitableWriterFor: aFittingStage [

	^aFittingStage whenTrainDo: [trainingWriter] whenValidationDo: [validationWriter]
]
