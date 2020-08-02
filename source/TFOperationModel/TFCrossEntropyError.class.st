Class {
	#name : 'TFCrossEntropyError',
	#superclass : 'TFLossFunction',
	#instVars : [
		'unscaledLogits',
		'labels'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFCrossEntropyError class >> named: anOperationName of: aLogitsTensor whenExpectedIs: aLabelsTensor [

	" Expects unscaled logits, since it performs a softmax on logits internally for efficiency. 
	 Do not call this op with the output of softmax, as it will produce incorrect results. "

	^self new initializeNamed: anOperationName of: aLogitsTensor whenExpectedIs: aLabelsTensor
]

{ #category : 'Instance Creation' }
TFCrossEntropyError class >> of: aLogitsTensor whenExpectedIs: aLabelsTensor [

	^self named: self operationType of: aLogitsTensor whenExpectedIs: aLabelsTensor
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFCrossEntropyError class >> operationType [

	^'SparseSoftmaxCrossEntropyWithLogits'
]

{ #category : 'Accessing - Outputs' }
TFCrossEntropyError >> backpropagatedGradient [

	^value output: 1
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFCrossEntropyError >> initializeNamed: anOperationName of: aLogitsTensor whenExpectedIs: anExpectedTensor [

	unscaledLogits := aLogitsTensor.
	labels := anExpectedTensor.
	value :=
		unscaledLogits currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			with: unscaledLogits
			with: labels
]

{ #category : 'Accessing - Outputs' }
TFCrossEntropyError >> loss [

	^value output: 0
]
