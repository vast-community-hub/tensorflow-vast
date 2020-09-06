Class {
	#name : 'AdaptiveGradient',
	#superclass : 'OptimizationAlgorithm',
	#instVars : [
		'learningRate',
		'accumulatorInitialValue',
		'accumulator'
	],
	#category : 'TFOptimizerModel'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
AdaptiveGradient class >> defaultLearningRate [

	^0.001
]

{ #category : 'Instance Creation' }
AdaptiveGradient class >> new [

	^self scalingBy: self defaultLearningRate
]

{ #category : 'Instance Creation' }
AdaptiveGradient class >> scalingBy: aLearningRate [

	^super new initializeScalingBy: aLearningRate
]

{ #category : 'Applying' }
AdaptiveGradient >> apply: aGradient to: aVariable [

	| tf |

	tf := aVariable currentComputation.
	accumulator
		ifNil: [accumulator := VariableNode on: tf named: 'accum' filledWithZerosLike: aVariable].

	^tf
		newOperationOf: 'ApplyAdagrad'
		namePrefixed: 'ApplyAdagrad'
		withAll: (
			OrderedCollection new
				add: aVariable;
				add: accumulator;
				add: learningRate;
				add: aGradient;
				yourself)
		describedBy: [:d | ]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
AdaptiveGradient >> initializeScalingBy: aLearningRate [

	learningRate := aLearningRate
]

{ #category : 'Printing' }
AdaptiveGradient >> printOn: aStream [

	aStream nextPutAll: ('AdaGrad (learning rate: <1p>)' expandMacrosWith: learningRate)
]

{ #category : 'Accessing' }
AdaptiveGradient >> shortName [

	^'AdaGrad'
]
