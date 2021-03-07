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
LossHasNotImproved >> isModelWellTrainedAccording: aTrainingContext [

	^aTrainingContext epochsTrained > 2 and: [| lastLosses |
		lastLosses := aTrainingContext historicalTrainingLoss last: 2.
		lastLosses first - lastLosses last < delta]
]

{ #category : 'Printing' }
LossHasNotImproved >> printOn: aStream [

	aStream nextPutAll:
		('Stop training when loss has not improved more than <1p>' expandMacrosWith: delta)
]
