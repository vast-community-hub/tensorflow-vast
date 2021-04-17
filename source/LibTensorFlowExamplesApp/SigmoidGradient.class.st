"
Same as https://www.tensorflow.org/api_docs/python/tf/raw_ops/SigmoidGrad
"
Class {
	#name : 'SigmoidGradient',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'backpropagation',
		'inputsGradients'
	],
	#category : 'LibTensorFlowExamplesApp'
}

{ #category : 'Instance Creation' }
SigmoidGradient class >> considering: aBackpropagation andGradientsOfInputs: anInput [

	^self new initializeConsidering: aBackpropagation andGradientsOfInputs: anInput
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
SigmoidGradient >> initializeConsidering: aBackpropagation andGradientsOfInputs: anInput [

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
SigmoidGradient >> operationType [

	^'SigmoidGrad'
]
