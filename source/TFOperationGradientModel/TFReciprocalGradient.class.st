Class {
	#name : 'TFReciprocalGradient',
	#superclass : 'TFGradientBehavior',
	#instVars : [
		'backpropagation',
		'inputFeatures',
		'operationName'
	],
	#category : 'TFOperationGradientModel'
}

{ #category : 'Instance Creation' }
TFReciprocalGradient class >> considering: aBackpropagation andGradientsOfInputs: anInput [

	^self new initializeConsidering: aBackpropagation andGradientsOfInputs: anInput
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFReciprocalGradient >> calculateValue [

	^self binaryOperation: 'ReciprocalGrad' between: backpropagation and: inputFeatures
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFReciprocalGradient >> initializeConsidering: aBackpropagation andGradientsOfInputs: anInput [

	backpropagation := aBackpropagation.
	inputFeatures := anInput.
	operationName := inputFeatures value nameFor: 'ReciprocalGrad'. 
	value := self calculateValue
]

{ #category : 'Accessing' }
TFReciprocalGradient >> operationName [

	^operationName
]
