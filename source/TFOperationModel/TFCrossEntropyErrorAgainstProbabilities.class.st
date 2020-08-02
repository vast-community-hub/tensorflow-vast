Class {
	#name : 'TFCrossEntropyErrorAgainstProbabilities',
	#superclass : 'TFLossFunction',
	#instVars : [
		'logits',
		'labelProbabilities'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFCrossEntropyErrorAgainstProbabilities class >> named: anOperationName of: aLogitsTensor whenExpectedProbabilityIs: aLabelsTensor [

	^self new initializeNamed: anOperationName of: aLogitsTensor whenExpectedProbabilityIs: aLabelsTensor
]

{ #category : 'Instance Creation' }
TFCrossEntropyErrorAgainstProbabilities class >> of: aLogitsTensor whenExpectedProbabilityIs: aLabelsTensor [

	^self named: self operationType of: aLogitsTensor whenExpectedProbabilityIs: aLabelsTensor
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFCrossEntropyErrorAgainstProbabilities class >> operationType [

	^'SoftmaxCrossEntropyWithLogits'
]

{ #category : 'Accessing - Outputs' }
TFCrossEntropyErrorAgainstProbabilities >> backpropagatedGradient [

	^value output: 1
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFCrossEntropyErrorAgainstProbabilities >> initializeNamed: anOperationName of: aLogitsTensor whenExpectedProbabilityIs: anExpectedTensor [

	logits := aLogitsTensor.
	labelProbabilities := anExpectedTensor.
	value :=
		logits currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			with: logits
			with: labelProbabilities
]

{ #category : 'Accessing - Outputs' }
TFCrossEntropyErrorAgainstProbabilities >> loss [

	^value output: 0
]
