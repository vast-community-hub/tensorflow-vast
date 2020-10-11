Class {
	#name : 'NeuralNetworkTrainingSummary',
	#superclass : 'Object',
	#instVars : [
		'trainingContext',
		'stopCondition'
	],
	#category : 'MLTrainingModel'
}

{ #category : 'Instance Creation' }
NeuralNetworkTrainingSummary class >> regarding: aTrainingContext stoppedAfter: aStopCondition [

	^self new initializeRegarding: aTrainingContext stoppedAfter: aStopCondition
]

{ #category : 'Accessing' }
NeuralNetworkTrainingSummary >> historicalTrainingAccuracy [

	^trainingContext metricKnownAs: 'training-accuracy'
]

{ #category : 'Accessing' }
NeuralNetworkTrainingSummary >> historicalTrainingLoss [

	^trainingContext historicalTrainingLoss
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
NeuralNetworkTrainingSummary >> initializeRegarding: aTrainingContext stoppedAfter: aStopCondition [

	trainingContext := aTrainingContext.
	stopCondition := aStopCondition
]

{ #category : 'Compute' }
NeuralNetworkTrainingSummary >> lossValueWhenPredictingFrom: anInput andExpectedIs: anExpectedValues [

	^trainingContext lossValueWhenPredictingFrom: anInput andExpectedIs: anExpectedValues
]

{ #category : 'Printing' }
NeuralNetworkTrainingSummary >> printOn: aStream [

	trainingContext printTrainingDescriptionOn: aStream.
	aStream
		nextPutAll: ('Stop Condition: <1p>' expandMacrosWith: stopCondition);
		cr.
	aStream
		nextPutAll: ('Current number of epochs run: <1p>' expandMacrosWith: self totalNumberOfEpochs)
]

{ #category : 'Accessing' }
NeuralNetworkTrainingSummary >> totalNumberOfEpochs [

	^trainingContext totalNumberOfEpochs
]
