Class {
	#name : 'TFGradientDescent',
	#superclass : 'TFOptimizer',
	#instVars : [
		'operationName',
		'weightsTensor',
		'learningRate',
		'gradientsTensor',
		'value'
	],
	#category : 'TFOptimizerModel'
}

{ #category : 'Instance Creation' }
TFGradientDescent class >> named: anOperationName scalingBy: aLearningRate [

	^self new initializeNamed: anOperationName scalingBy: aLearningRate
]

{ #category : 'Instance Creation' }
TFGradientDescent class >> scalingBy: aLearningRate [

	^self named: 'GradientDescent' scalingBy: aLearningRate
]

{ #category : 'Applying' }
TFGradientDescent >> apply: aGradient to: aVariable [

	^aVariable currentComputation
		newOperationOf: 'ApplyGradientDescent'
		namePrefixed: operationName
		withAll: (Array with: aVariable with: learningRate with: aGradient)
		describedBy: [:d | ]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFGradientDescent >> initializeNamed: anOperationName scalingBy: aLearningRate [

	operationName := anOperationName.
	learningRate := aLearningRate
]
