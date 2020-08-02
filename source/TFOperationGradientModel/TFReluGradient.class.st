Class {
	#name : 'TFReluGradient',
	#superclass : 'TFGradientBehavior',
	#instVars : [
		'backpropagation',
		'inputFeatures'
	],
	#category : 'TFOperationGradientModel'
}

{ #category : 'Instance Creation' }
TFReluGradient class >> considering: aBackpropagation andGradientsOfInputs: anInput [

	^self new initializeConsidering: aBackpropagation andGradientsOfInputs: anInput
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFReluGradient >> initializeConsidering: aBackpropagation andGradientsOfInputs: anInput [

	backpropagation := aBackpropagation.
	inputFeatures := anInput.
	value :=
		backpropagation currentComputation
			newOperationOf: self operationType
			namePrefixed: self operationType
			with: backpropagation
			with: inputFeatures
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFReluGradient >> operationType [

	^'ReluGrad'
]
