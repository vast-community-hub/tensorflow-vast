Class {
	#name : 'GradientDescent',
	#superclass : 'OptimizationAlgorithm',
	#instVars : [
		'operationName',
		'learningRate'
	],
	#category : 'TFOptimizerModel'
}

{ #category : 'Instance Creation' }
GradientDescent class >> named: anOperationName scalingBy: aLearningRate [

	^super new initializeNamed: anOperationName scalingBy: aLearningRate
]

{ #category : 'Instance Creation' }
GradientDescent class >> new [

	^self scalingBy: 0.01
]

{ #category : 'Instance Creation' }
GradientDescent class >> scalingBy: aLearningRate [

	^self named: 'GradientDescent' scalingBy: aLearningRate
]

{ #category : 'Applying' }
GradientDescent >> apply: aGradient to: aVariable [

	^aVariable currentComputation
		newOperationOf: 'ApplyGradientDescent'
		namePrefixed: operationName
		withAll: (Array with: aVariable with: learningRate with: aGradient)
		describedBy: [:d | ]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
GradientDescent >> initializeNamed: anOperationName scalingBy: aLearningRate [

	operationName := anOperationName.
	learningRate := aLearningRate
]

{ #category : 'Printing' }
GradientDescent >> printOn: aStream [

	aStream
		nextPutAll: ('Gradient Descent (learning rate: <1p>)' expandMacrosWith: learningRate)
]

{ #category : 'Accessing' }
GradientDescent >> shortName [

	^'Gradient Descent'
]
