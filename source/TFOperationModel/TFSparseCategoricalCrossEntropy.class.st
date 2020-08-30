Class {
	#name : 'TFSparseCategoricalCrossEntropy',
	#superclass : 'TFLossFunction',
	#instVars : [
		'unscaledLogits',
		'labels'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFSparseCategoricalCrossEntropy class >> named: anOperationName of: aLogitsTensor whenExpectedIs: aLabelsTensor [

	" Expects unscaled logits, since it performs a softmax on logits internally for efficiency. 
	 Do not call this op with the output of softmax, as it will produce incorrect results. "

	^self new initializeNamed: anOperationName of: aLogitsTensor whenExpectedIs: aLabelsTensor
]

{ #category : 'Instance Creation' }
TFSparseCategoricalCrossEntropy class >> of: aLogitsTensor whenExpectedIs: aLabelsTensor [

	^self named: self operationType of: aLogitsTensor whenExpectedIs: aLabelsTensor
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFSparseCategoricalCrossEntropy class >> operationType [

	^'SparseSoftmaxCrossEntropyWithLogits'
]

{ #category : 'Accessing - Outputs' }
TFSparseCategoricalCrossEntropy >> backpropagatedGradient [

	^value output: 1
]

{ #category : 'Accessing' }
TFSparseCategoricalCrossEntropy >> expectedVariableName [

	^labels operationName
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFSparseCategoricalCrossEntropy >> initializeNamed: anOperationName of: aLogitsTensor whenExpectedIs: anExpectedTensor [

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
TFSparseCategoricalCrossEntropy >> loss [

	^value output: 0
]

{ #category : 'Operations' }
TFSparseCategoricalCrossEntropy >> mean [

	^TFCrossEntropyMean of: self
]

{ #category : 'Printing' }
TFSparseCategoricalCrossEntropy >> printOn: aStream [

	aStream nextPutAll: 'Sparse Categorical Cross Entropy'
]
