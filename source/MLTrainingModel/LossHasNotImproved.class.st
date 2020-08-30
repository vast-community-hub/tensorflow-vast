Class {
	#name : 'LossHasNotImproved',
	#superclass : 'TrainingStopCondition',
	#instVars : [
		'delta'
	],
	#category : 'MLTrainingModel'
}

{ #category : 'Instance Creation' }
LossHasNotImproved class >> moreThan: aDelta [

	^self new initializeMoreThan: aDelta
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
LossHasNotImproved >> initializeMoreThan: aDelta [

	
	delta := aDelta
]

{ #category : 'Testing' }
LossHasNotImproved >> isModelWellTrainedAccording: aTrainingSummary [

	^aTrainingSummary totalNumberOfEpochs > 1 and: [| lastLosses |
		lastLosses := aTrainingSummary historicalTrainingLoss last: 2.
		lastLosses first - lastLosses last < delta]
]

{ #category : 'Printing' }
LossHasNotImproved >> printOn: aStream [

	aStream nextPutAll:
		('Stop training when loss has not improved more than <1p>' expandMacrosWith: delta)
]
