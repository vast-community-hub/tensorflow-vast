Class {
	#name : 'NeuralNetworkTrainingSummary',
	#superclass : 'Object',
	#instVars : [
		'model',
		'lossFunction',
		'optimizer',
		'stopCondition',
		'historicalTrainingLoss'
	],
	#category : 'MLTrainingModel'
}

{ #category : 'Instance Creation' }
NeuralNetworkTrainingSummary class >> of: aModel trainedMinimizing: aLossFunction using: anOptimizer until: aStopCondition [

	^self new
		initializeOf: aModel
		trainedMinimizing: aLossFunction
		using: anOptimizer
		until: aStopCondition
]

{ #category : 'Compute' }
NeuralNetworkTrainingSummary >> accuracyOfPredictionFrom: anInput whenExpectedIs: anExpectedValues [

	^lossFunction computeWith: (
		Dictionary new
			at: model inputVariableName put: anInput;
			at: lossFunction expectedVariableName put: anExpectedValues;
			yourself)
]

{ #category : 'Accessing' }
NeuralNetworkTrainingSummary >> addLossAfter: aTraining [

	| loss |

	loss := aTraining value.

	historicalTrainingLoss add: loss allElements any
]

{ #category : 'Accessing' }
NeuralNetworkTrainingSummary >> historicalTrainingLoss [

	^historicalTrainingLoss
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
NeuralNetworkTrainingSummary >> initializeOf: aModel trainedMinimizing: aLossFunction using: anOptimizer until: aStopCondition [

	model := aModel.
	lossFunction := aLossFunction.
	optimizer := anOptimizer.
	stopCondition := aStopCondition.
	historicalTrainingLoss := OrderedCollection new
]

{ #category : 'Accessing' }
NeuralNetworkTrainingSummary >> optimizer [

	^optimizer
]

{ #category : 'Printing' }
NeuralNetworkTrainingSummary >> printOn: aStream [

	aStream
		nextPutAll: '== Model To Train ==';
		cr;
		print: model;
		cr;
		nextPutAll: '=====';
		cr.
	aStream
		nextPutAll: ('Loss: <1p>' expandMacrosWith: lossFunction);
		cr.
	aStream
		nextPutAll: ('Optimization Algorithm: <1p>' expandMacrosWith: optimizer);
		cr.
	aStream
		nextPutAll: ('Stop Condition: <1p>' expandMacrosWith: stopCondition);
		cr.
	aStream nextPutAll:
		('Current number of epochs run: <1p>' expandMacrosWith: self totalNumberOfEpochs)
]

{ #category : 'Accessing' }
NeuralNetworkTrainingSummary >> totalNumberOfEpochs [

	^self historicalTrainingLoss size
]
