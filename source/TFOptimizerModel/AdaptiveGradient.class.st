Class {
	#name : 'AdaptiveGradient',
	#superclass : 'OptimizationAlgorithm',
	#instVars : [
		'learningRate',
		'accumulatorByVariable'
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

{ #category : 'Accessing',
  #vaVisibility : 'private' }
AdaptiveGradient >> accumulatorFor: aVariable [

	^accumulatorByVariable
		at: aVariable
		ifAbsentPut: [
			VariableNode
				on: aVariable currentComputation
				named: 'accum'
				filledWithZerosLike: aVariable]
]

{ #category : 'Applying' }
AdaptiveGradient >> apply: aGradient to: aVariable [

	| tf |

	tf := aVariable currentComputation.
	^tf
		newOperationOf: 'ApplyAdagrad'
		namePrefixed: ('Optimization_<1s>' expandMacrosWith: aVariable operationName)
		withAll: (
			(OrderedCollection new)
				add: aVariable;
				add: (self accumulatorFor: aVariable);
				add: learningRate;
				add: aGradient;
				yourself)
		describedBy: [:d | ]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
AdaptiveGradient >> initializeScalingBy: aLearningRate [

	learningRate := aLearningRate.
	accumulatorByVariable := Dictionary new
]

{ #category : 'Printing' }
AdaptiveGradient >> printOn: aStream [

	aStream nextPutAll: ('AdaGrad (learning rate: <1p>)' expandMacrosWith: learningRate)
]

{ #category : 'Accessing' }
AdaptiveGradient >> shortName [

	^'AdaGrad'
]
