Class {
	#name : 'TFCrossEntropyError',
	#superclass : 'TFLossFunction',
	#instVars : [
		'operationName',
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

	^self
		named: 'SparseSoftmaxCrossEntropyWithLogits'
		of: aLogitsTensor
		whenExpectedIs: aLabelsTensor
]

{ #category : 'Accessing - Outputs' }
TFCrossEntropyError >> backpropagatedGradient [

	^value output: 1
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFCrossEntropyError >> calculateValue [

	^self
		binaryOperation: 'SparseSoftmaxCrossEntropyWithLogits'
		between: unscaledLogits
		and: labels
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFCrossEntropyError >> initializeNamed: anOperationName of: aLogitsTensor whenExpectedIs: anExpectedTensor [

	operationName := anOperationName.
	unscaledLogits := aLogitsTensor.
	labels := anExpectedTensor.
	value := self calculateValue
]

{ #category : 'Accessing - Outputs' }
TFCrossEntropyError >> loss [

	^value output: 0
]

{ #category : 'Accessing' }
TFCrossEntropyError >> operationName [

	^operationName
]
