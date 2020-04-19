Class {
	#name : 'TFReluGradient',
	#superclass : 'TFGradientBehavior',
	#instVars : [
		'backpropagation',
		'inputFeatures',
		'operationName'
	],
	#category : 'TFOperationGradientModel'
}

{ #category : 'Instance Creation' }
TFReluGradient class >> considering: aBackpropagation andGradientsOfInputs: anInput [

	^self new initializeConsidering: aBackpropagation andGradientsOfInputs: anInput
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFReluGradient >> calculateValue [

	^self binaryOperation: 'ReluGrad' between: backpropagation and: inputFeatures
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFReluGradient >> initializeConsidering: aBackpropagation andGradientsOfInputs: anInput [

	backpropagation := aBackpropagation.
	inputFeatures := anInput.
	operationName := inputFeatures value nameFor: 'ReluGrad'. 
	value := self calculateValue
]

{ #category : 'Accessing' }
TFReluGradient >> operationName [

	^operationName
]
