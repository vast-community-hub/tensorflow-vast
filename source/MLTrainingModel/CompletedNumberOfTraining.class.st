Class {
	#name : 'CompletedNumberOfTraining',
	#superclass : 'TrainingStopCondition',
	#instVars : [
		'stopTrainingEpoch'
	],
	#category : 'MLTrainingModel'
}

{ #category : 'Instance Creation' }
CompletedNumberOfTraining class >> after: aTrainingNumber [

	^self new initializeAfter: aTrainingNumber
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
CompletedNumberOfTraining >> initializeAfter: aTrainingNumber [

	
	stopTrainingEpoch := aTrainingNumber
]

{ #category : 'Testing' }
CompletedNumberOfTraining >> isModelWellTrainedAccording: aTrainingSummary [

	^stopTrainingEpoch <= aTrainingSummary totalNumberOfEpochs
]

{ #category : 'Printing' }
CompletedNumberOfTraining >> printOn: aStream [

	aStream nextPutAll: ('Stop training after <1p> epochs' expandMacrosWith: stopTrainingEpoch)
]
