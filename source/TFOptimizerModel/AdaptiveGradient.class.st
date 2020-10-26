Class {
	#name : 'AdaptiveGradient',
	#superclass : 'OptimizationAlgorithm',
	#instVars : [
		'learningRate',
		'accumulatorByVariable',
		'epsilonValue',
		'initialAccumulatorValue'
	],
	#category : 'TFOptimizerModel'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
AdaptiveGradient class >> defaultEpsilonValue [

	^1e-07
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
AdaptiveGradient class >> defaultInitialAccumulatorValue [

	^0.1
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
AdaptiveGradient class >> defaultLearningRate [

	^0.001
]

{ #category : 'Instance Creation' }
AdaptiveGradient class >> new [

	^self
		scalingBy: self defaultLearningRate
		startingAccumulatorWith: self defaultInitialAccumulatorValue
		usingForNumericalStability: self defaultEpsilonValue
]

{ #category : 'Instance Creation' }
AdaptiveGradient class >> scalingBy: aLearningRate [

	^self
		scalingBy: aLearningRate
		startingAccumulatorWith: self defaultInitialAccumulatorValue
		usingForNumericalStability: self defaultEpsilonValue
]

{ #category : 'Instance Creation' }
AdaptiveGradient class >> scalingBy: aLearningRate startingAccumulatorWith: anAccumulatatorInitialValue usingForNumericalStability: anEpsilonValue [

	^super new
		initializeScalingBy: aLearningRate
		startingAccumulatorWith: anAccumulatatorInitialValue
		usingForNumericalStability: anEpsilonValue
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
				of: aVariable value outputType
				shaped: aVariable value outputShape
				initializedWith: (ConstantInitializer with: initialAccumulatorValue)]
]

{ #category : 'Applying' }
AdaptiveGradient >> apply: aGradient to: aVariable [

	| tf |

	tf := aVariable currentComputation.
	^tf
		newOperationOf: 'ApplyAdagradV2'
		namePrefixed: ('Optimization_<1s>' expandMacrosWith: aVariable operationName)
		withAll: (
			(OrderedCollection new)
				add: aVariable;
				add: (self accumulatorFor: aVariable);
				add: learningRate;
				add: epsilonValue; 
				add: aGradient;
				yourself)
		describedBy: [:d | ]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
AdaptiveGradient >> initializeScalingBy: aLearningRate startingAccumulatorWith: anAccumulatatorInitialValue usingForNumericalStability: anEpsilonValue [

	learningRate := aLearningRate.
	initialAccumulatorValue := anAccumulatatorInitialValue.
	epsilonValue := anEpsilonValue.
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
