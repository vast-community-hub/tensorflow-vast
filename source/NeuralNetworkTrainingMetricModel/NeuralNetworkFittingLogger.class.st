Class {
	#name : 'NeuralNetworkFittingLogger',
	#superclass : 'TrainingMetricTracker',
	#instVars : [
		'stream',
		'epochByStage',
		'batchStepByStage'
	],
	#category : 'NeuralNetworkTrainingMetricModel'
}

{ #category : 'Instance Creation' }
NeuralNetworkFittingLogger class >> new [

	^self on: Transcript
]

{ #category : 'Instance Creation' }
NeuralNetworkFittingLogger class >> on: aStream [

	^super new initializeOn: aStream
]

{ #category : 'Processing' }
NeuralNetworkFittingLogger >> batchStepAt: aFittingStage [

	^batchStepByStage at: aFittingStage description ifAbsentPut: [1]
]

{ #category : 'Processing' }
NeuralNetworkFittingLogger >> epochAt: aFittingStage [

	^epochByStage at: aFittingStage description ifAbsentPut: [1]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
NeuralNetworkFittingLogger >> initializeOn: aStream [

	stream := aStream.
	epochByStage := Dictionary new.
	batchStepByStage := Dictionary new
]

{ #category : 'Preprocessing',
  #vaVisibility : 'private' }
NeuralNetworkFittingLogger >> log: aText [

	stream
		nextPutAll: ('[<1p>] <2s>' expandMacrosWith: DateAndTime now with: aText);
		cr
]

{ #category : 'Processing' }
NeuralNetworkFittingLogger >> measureMetricDuring: aFittingStage onEpochEndWithin: aContext [

	self log: (
		'Finished <1s> epoch <2p>'
			expandMacrosWith: aFittingStage description
			with: (self epochAt: aFittingStage)).
	epochByStage at: aFittingStage description put: (self epochAt: aFittingStage) + 1.
	batchStepByStage at: aFittingStage description put: 1
]

{ #category : 'Processing' }
NeuralNetworkFittingLogger >> measureMetricDuring: aFittingStage onEpochStartWithin: aNeuralNetworkTrainingContext [

	self log: (
		'Started <1s> epoch <2p>'
			expandMacrosWith: aFittingStage description
			with: (self epochAt: aFittingStage))
]

{ #category : 'Processing' }
NeuralNetworkFittingLogger >> measureMetricDuring: aFittingStage onStepEndUsing: anInput within: aContext [

	self log: (
		'.. Finished <1s> batch step <2p> (Epoch <3p>)'
			expandMacrosWith: aFittingStage description
			with: (self batchStepAt: aFittingStage)
			with: (self epochAt: aFittingStage)).
	batchStepByStage at: aFittingStage description put: (self batchStepAt: aFittingStage) + 1
]

{ #category : 'Processing' }
NeuralNetworkFittingLogger >> measureMetricDuring: aFittingStage onStepStartUsing: anInput within: aContext [

	self log: (
		'.. Started <1s> batch step <2p> (Epoch <3p>)'
			expandMacrosWith: aFittingStage description
			with: (self batchStepAt: aFittingStage)
			with: (self epochAt: aFittingStage))


]

{ #category : 'Preprocessing' }
NeuralNetworkFittingLogger >> prepareMetricsWithin: aContext [

	self log: 'Initializing context'
]
