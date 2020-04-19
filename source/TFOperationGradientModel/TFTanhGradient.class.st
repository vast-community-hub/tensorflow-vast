Class {
	#name : 'TFTanhGradient',
	#superclass : 'TFGradientBehavior',
	#instVars : [
		'backpropagation',
		'inputFeatures',
		'operationName'
	],
	#category : 'TFOperationGradientModel'
}

{ #category : 'Instance Creation' }
TFTanhGradient class >> considering: aBackprop andGradientsOfInputs: anInput [

	^self new initializeConsidering: aBackprop andGradientsOfInputs: anInput
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFTanhGradient >> calculateValue [

	^self binaryOperation: 'TanhGrad' between: backpropagation and: inputFeatures
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFTanhGradient >> initializeConsidering: aBackprop andGradientsOfInputs: anInput [

	backpropagation := aBackprop.
	inputFeatures := anInput.
	operationName := 'TanhGrad'.
	value := self calculateValue
]

{ #category : 'Accessing' }
TFTanhGradient >> operationName [
	
	^operationName
]
