Class {
	#name : 'CategoricalCrossEntropy',
	#superclass : 'LossFunction',
	#instVars : [
		'logits',
		'labelProbabilities'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
CategoricalCrossEntropy class >> named: anOperationName of: aLogitsTensor whenExpectedProbabilityIs: aLabelsTensor [

	^self new initializeNamed: anOperationName of: aLogitsTensor whenExpectedProbabilityIs: aLabelsTensor
]

{ #category : 'Instance Creation' }
CategoricalCrossEntropy class >> of: aLogitsTensor whenExpectedProbabilityIs: aLabelsTensor [

	^self named: self operationType of: aLogitsTensor whenExpectedProbabilityIs: aLabelsTensor
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
CategoricalCrossEntropy class >> operationType [

	^'SoftmaxCrossEntropyWithLogits'
]

{ #category : 'Accessing - Outputs' }
CategoricalCrossEntropy >> backpropagatedGradient [

	^value output: 1
]

{ #category : 'Accessing' }
CategoricalCrossEntropy >> expectedVariableName [

	^labelProbabilities operationName
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
CategoricalCrossEntropy >> initializeNamed: anOperationName of: aLogitsTensor whenExpectedProbabilityIs: anExpectedTensor [

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
CategoricalCrossEntropy >> loss [

	^value output: 0
]

{ #category : 'Operations' }
CategoricalCrossEntropy >> mean [

	^CrossEntropyMean of: self
]

{ #category : 'Printing' }
CategoricalCrossEntropy >> printOn: aStream [

	aStream nextPutAll: 'Categorical Cross Entropy' 
]
