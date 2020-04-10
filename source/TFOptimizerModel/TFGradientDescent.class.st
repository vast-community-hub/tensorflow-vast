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

	^aVariable value currentComputation
		newOperationOf: 'ApplyGradientDescent'
		named: (aVariable value graph nameFor: operationName)
		withAll: (Array with: aVariable with: learningRate with: aGradient value)
		describedBy: [:d | ]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFGradientDescent >> initializeNamed: anOperationName scalingBy: aLearningRate [

	operationName := anOperationName.
	learningRate := aLearningRate
]
