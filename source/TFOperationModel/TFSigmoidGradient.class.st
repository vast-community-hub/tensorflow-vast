"
Same as https://www.tensorflow.org/api_docs/python/tf/raw_ops/SigmoidGrad
"
Class {
	#name : 'TFSigmoidGradient',
	#superclass : 'TFGradientBehavior',
	#instVars : [
		'operationName',
		'backpropagation',
		'inputsGradients'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFSigmoidGradient class >> considering: aBackpropagation andGradientsOfInputs: anInput [

	^self new initializeConsidering: aBackpropagation andGradientsOfInputs: anInput
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFSigmoidGradient >> calculateValue [

	^self binaryOperation: 'SigmoidGrad' between: inputsGradients and: backpropagation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFSigmoidGradient >> initializeConsidering: aBackpropagation andGradientsOfInputs: anInput [

	operationName := aBackpropagation value nameFor: 'SigmoidGrad'.
	backpropagation := aBackpropagation.
	inputsGradients := anInput.
	value := self calculateValue
]

{ #category : 'Accessing' }
TFSigmoidGradient >> operationName [

	^operationName
]
