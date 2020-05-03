Class {
	#name : 'TFCrossEntropyErrorAgainstProbabilities',
	#superclass : 'TFLossFunction',
	#instVars : [
		'operationName',
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

	^self
		named: 'SoftmaxCrossEntropyWithLogits'
		of: aLogitsTensor
		whenExpectedProbabilityIs: aLabelsTensor
]

{ #category : 'Accessing - Outputs' }
TFCrossEntropyErrorAgainstProbabilities >> backpropagatedGradient [

	^value output: 1
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFCrossEntropyErrorAgainstProbabilities >> calculateValue [

	^self
		binaryOperation: 'SoftmaxCrossEntropyWithLogits'
		between: logits
		and: labelProbabilities
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFCrossEntropyErrorAgainstProbabilities >> initializeNamed: anOperationName of: aLogitsTensor whenExpectedProbabilityIs: anExpectedTensor [

	operationName := anOperationName.
	logits := aLogitsTensor.
	labelProbabilities := anExpectedTensor.
	value := self calculateValue
]

{ #category : 'Accessing - Outputs' }
TFCrossEntropyErrorAgainstProbabilities >> loss [

	^value output: 0
]

{ #category : 'Accessing' }
TFCrossEntropyErrorAgainstProbabilities >> operationName [

	^operationName
]
