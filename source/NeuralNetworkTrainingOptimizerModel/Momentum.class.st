Class {
	#name : 'Momentum',
	#superclass : 'OptimizationAlgorithm',
	#instVars : [
		'learningRate',
		'momentum',
		'useNesterov',
		'accumulatorByVariable'
	],
	#category : 'NeuralNetworkTrainingOptimizerModel'
}

{ #category : 'Instance Creation' }
Momentum class >> new [

	^self scalingBy: 0.001 momentumSetTo: 0.9
]

{ #category : 'Instance Creation' }
Momentum class >> scalingBy: aLearningRate momentumSetTo: aMomentumTerm [

	^super new initializeScalingBy: aLearningRate momentumSetTo: aMomentumTerm


]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
Momentum >> accumulatorFor: aVariable [

	^accumulatorByVariable
		at: aVariable
		ifAbsentPut: [
			VariableTensor
				on: aVariable currentComputation
				named: 'accum'
				filledWithZerosLike: aVariable]
]

{ #category : 'Applying' }
Momentum >> apply: aGradient to: aVariable [

	^aVariable currentComputation
		newOperationOf: 'ApplyMomentum'
		namePrefixed: ('Optimization_<1s>' expandMacrosWith: aVariable operationName)
		withAll: (
			(OrderedCollection new)
				add: aVariable;
				add: (self accumulatorFor: aVariable);
				add: learningRate;
				add: aGradient;
				add: momentum;
				yourself)
		describedBy: [:d | d atUseNesterovPut: useNesterov]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Momentum >> initializeScalingBy: aLearningRate momentumSetTo: aMomentumTerm [

	learningRate := aLearningRate.
	momentum := aMomentumTerm.
	useNesterov := false.
	accumulatorByVariable := Dictionary new. 
]

{ #category : 'Printing' }
Momentum >> printOn: aStream [

	aStream nextPutAll: (
		'Momentum (learning rate: <1p>; momentum: <2p>)'
			expandMacrosWith: learningRate
			with: momentum)
]

{ #category : 'Accessing' }
Momentum >> shortName [

	^'Momentum'
]

{ #category : 'Configuring' }
Momentum >> useNesterovUpdate [

	useNesterov := true
]
