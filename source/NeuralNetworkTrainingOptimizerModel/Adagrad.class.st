Class {
	#name : 'Adagrad',
	#superclass : 'OptimizationAlgorithm',
	#instVars : [
		'learningRate',
		'accumulatorByVariable',
		'epsilonValue',
		'initialAccumulatorValue'
	],
	#category : 'NeuralNetworkTrainingOptimizerModel'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
Adagrad class >> defaultEpsilonValue [

	^1e-07
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
Adagrad class >> defaultInitialAccumulatorValue [

	^0.1
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
Adagrad class >> defaultLearningRate [

	^0.001
]

{ #category : 'Instance Creation' }
Adagrad class >> new [

	^self
		scalingBy: self defaultLearningRate
		startingAccumulatorWith: self defaultInitialAccumulatorValue
		usingForNumericalStability: self defaultEpsilonValue
]

{ #category : 'Instance Creation' }
Adagrad class >> scalingBy: aLearningRate [

	^self
		scalingBy: aLearningRate
		startingAccumulatorWith: self defaultInitialAccumulatorValue
		usingForNumericalStability: self defaultEpsilonValue
]

{ #category : 'Instance Creation' }
Adagrad class >> scalingBy: aLearningRate startingAccumulatorWith: anAccumulatatorInitialValue usingForNumericalStability: anEpsilonValue [

	^super new
		initializeScalingBy: aLearningRate
		startingAccumulatorWith: anAccumulatatorInitialValue
		usingForNumericalStability: anEpsilonValue
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
Adagrad >> accumulatorFor: aVariable [

	^accumulatorByVariable
		at: aVariable
		ifAbsentPut: [
			VariableTensor
				on: aVariable currentComputation
				named: 'accum'
				of: aVariable value outputType
				shaped: aVariable value outputShape
				initializedWith: (ConstantInitializer with: initialAccumulatorValue)]
]

{ #category : 'Applying' }
Adagrad >> apply: aGradient to: aVariable [

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
Adagrad >> initializeScalingBy: aLearningRate startingAccumulatorWith: anAccumulatatorInitialValue usingForNumericalStability: anEpsilonValue [

	learningRate := aLearningRate.
	initialAccumulatorValue := anAccumulatatorInitialValue.
	epsilonValue := anEpsilonValue.
	accumulatorByVariable := Dictionary new
]

{ #category : 'Printing' }
Adagrad >> printOn: aStream [

	aStream nextPutAll: ('AdaGrad (learning rate: <1p>)' expandMacrosWith: learningRate)
]

{ #category : 'Accessing' }
Adagrad >> shortName [

	^'AdaGrad'
]
