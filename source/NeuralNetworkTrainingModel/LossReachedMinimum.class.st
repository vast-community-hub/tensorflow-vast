Class {
	#name : 'LossReachedMinimum',
	#superclass : 'TrainingStopCondition',
	#instVars : [
		'minimumLoss'
	],
	#category : 'NeuralNetworkTrainingModel'
}

{ #category : 'Instance Creation' }
LossReachedMinimum class >> lowerThan: aLossValue [

	^self new initializeLowerThan: aLossValue
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
LossReachedMinimum >> initializeLowerThan: aLossValue [

	minimumLoss := aLossValue
]

{ #category : 'Testing' }
LossReachedMinimum >> isModelWellTrainedAccording: aTrainingContext [

	^aTrainingContext historicalTrainingLoss last < minimumLoss
]

{ #category : 'Printing' }
LossReachedMinimum >> printOn: aStream [

	aStream nextPutAll:
		('Stop training when loss has reached a value lower than <1p>' expandMacrosWith: minimumLoss)
]
