Class {
	#name : 'TFGradientDescent',
	#superclass : 'TFOptimizer',
	#instVars : [
		'operationName',
		'learningRate'
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

{ #category : 'Printing' }
TFGradientDescent >> printOn: aStream [

	aStream
		nextPutAll: ('Gradient Descent with a learning rate of <1p>' expandMacrosWith: learningRate)
]
