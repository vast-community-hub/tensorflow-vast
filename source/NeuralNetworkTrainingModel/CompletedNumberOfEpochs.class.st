Class {
	#name : 'CompletedNumberOfEpochs',
	#superclass : 'TrainingStopCondition',
	#instVars : [
		'stopTrainingEpoch'
	],
	#category : 'NeuralNetworkTrainingModel'
}

{ #category : 'Instance Creation' }
CompletedNumberOfEpochs class >> after: aTrainingNumber [

	^self new initializeAfter: aTrainingNumber
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
CompletedNumberOfEpochs >> initializeAfter: aTrainingNumber [

	
	stopTrainingEpoch := aTrainingNumber
]

{ #category : 'Testing' }
CompletedNumberOfEpochs >> isModelWellTrainedAccording: aTrainingContext [

	^stopTrainingEpoch < aTrainingContext epochsTrained
]

{ #category : 'Printing' }
CompletedNumberOfEpochs >> printOn: aStream [

	aStream nextPutAll: ('Stop training after <1p> epochs' expandMacrosWith: stopTrainingEpoch)
]
