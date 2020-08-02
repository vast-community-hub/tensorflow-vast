"
Same as https://www.tensorflow.org/api_docs/python/tf/raw_ops/SigmoidGrad
"
Class {
	#name : 'TFSigmoidGradient',
	#superclass : 'TFGradientBehavior',
	#instVars : [
		'backpropagation',
		'inputsGradients'
	],
	#category : 'TFOperationGradientModel'
}

{ #category : 'Instance Creation' }
TFSigmoidGradient class >> considering: aBackpropagation andGradientsOfInputs: anInput [

	^self new initializeConsidering: aBackpropagation andGradientsOfInputs: anInput
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFSigmoidGradient >> initializeConsidering: aBackpropagation andGradientsOfInputs: anInput [

	backpropagation := aBackpropagation.
	inputsGradients := anInput.
	value :=
		backpropagation currentComputation
			newOperationOf: self operationType
			namePrefixed: self operationType
			with: backpropagation
			with: inputsGradients
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFSigmoidGradient >> operationType [

	^'SigmoidGrad'
]
