Class {
	#name : 'SparseCategoricalCrossEntropy',
	#superclass : 'LossFunction',
	#instVars : [
		'unscaledLogits',
		'labels'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
SparseCategoricalCrossEntropy class >> named: anOperationName of: aLogitsTensor whenExpectedIs: aLabelsTensor [

	" Expects unscaled logits, since it performs a softmax on logits internally for efficiency. 
	 Do not call this op with the output of softmax, as it will produce incorrect results. "

	^self new initializeNamed: anOperationName of: aLogitsTensor whenExpectedIs: aLabelsTensor
]

{ #category : 'Instance Creation' }
SparseCategoricalCrossEntropy class >> of: aLogitsTensor whenExpectedIs: aLabelsTensor [

	^self named: self operationType of: aLogitsTensor whenExpectedIs: aLabelsTensor
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
SparseCategoricalCrossEntropy class >> operationType [

	^'SparseSoftmaxCrossEntropyWithLogits'
]

{ #category : 'Accessing - Outputs' }
SparseCategoricalCrossEntropy >> backpropagatedGradient [

	^value output: 1
]

{ #category : 'Accessing' }
SparseCategoricalCrossEntropy >> expectedVariableName [

	^labels operationName
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
SparseCategoricalCrossEntropy >> initializeNamed: anOperationName of: aLogitsTensor whenExpectedIs: anExpectedTensor [

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
SparseCategoricalCrossEntropy >> loss [

	^value output: 0
]

{ #category : 'Operations' }
SparseCategoricalCrossEntropy >> mean [

	^CrossEntropyMean of: self
]

{ #category : 'Printing' }
SparseCategoricalCrossEntropy >> printOn: aStream [

	aStream nextPutAll: 'Sparse Categorical Cross Entropy'
]
