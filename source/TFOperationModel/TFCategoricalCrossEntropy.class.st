Class {
	#name : 'TFCategoricalCrossEntropy',
	#superclass : 'TFLossFunction',
	#instVars : [
		'logits',
		'labelProbabilities'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFCategoricalCrossEntropy class >> named: anOperationName of: aLogitsTensor whenExpectedProbabilityIs: aLabelsTensor [

	^self new initializeNamed: anOperationName of: aLogitsTensor whenExpectedProbabilityIs: aLabelsTensor
]

{ #category : 'Instance Creation' }
TFCategoricalCrossEntropy class >> of: aLogitsTensor whenExpectedProbabilityIs: aLabelsTensor [

	^self named: self operationType of: aLogitsTensor whenExpectedProbabilityIs: aLabelsTensor
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFCategoricalCrossEntropy class >> operationType [

	^'SoftmaxCrossEntropyWithLogits'
]

{ #category : 'Accessing - Outputs' }
TFCategoricalCrossEntropy >> backpropagatedGradient [

	^value output: 1
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFCategoricalCrossEntropy >> initializeNamed: anOperationName of: aLogitsTensor whenExpectedProbabilityIs: anExpectedTensor [

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
TFCategoricalCrossEntropy >> loss [

	^value output: 0
]

{ #category : 'Operations' }
TFCategoricalCrossEntropy >> mean [

	^TFCrossEntropyMean of: self
]

{ #category : 'Printing' }
TFCategoricalCrossEntropy >> printOn: aStream [

	aStream nextPutAll: 'Categorical Cross Entropy' 
]
