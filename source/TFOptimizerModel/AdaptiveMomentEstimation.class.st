Class {
	#name : 'AdaptiveMomentEstimation',
	#superclass : 'OptimizationAlgorithm',
	#instVars : [
		'learningRate',
		'epsilon',
		'useNesterov',
		'meanGradientByVariable',
		'gradientVarianceByVariable',
		'firstMomentDecayingRate',
		'secondMomentoDecayingRate'
	],
	#category : 'TFOptimizerModel'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
AdaptiveMomentEstimation class >> defaultBeta1Factor [

	^0.9
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
AdaptiveMomentEstimation class >> defaultBeta2Factor [

	^0.999
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
AdaptiveMomentEstimation class >> defaultEpsilonValue [

	^10e-8
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
AdaptiveMomentEstimation class >> defaultLearningRate [

	^0.001
]

{ #category : 'Instance Creation' }
AdaptiveMomentEstimation class >> new [

	^self
		scalingBy: self defaultLearningRate
		decayingFirstMomentBy: self defaultBeta1Factor
		decayingSecondMomentBy: self defaultBeta2Factor
		usingForNumericalStability: self defaultEpsilonValue
]

{ #category : 'Instance Creation' }
AdaptiveMomentEstimation class >> scalingBy: aLearningRate decayingFirstMomentBy: aBeta1Factor decayingSecondMomentBy: aBeta2Factor usingForNumericalStability: anEpsilonValue [

	^super new
		initializeScalingBy: aLearningRate
		decayingFirstMomentBy: aBeta1Factor
		decayingSecondMomentBy: aBeta2Factor
		usingForNumericalStability: anEpsilonValue
]

{ #category : 'Applying' }
AdaptiveMomentEstimation >> apply: aGradient to: aVariable [

	| timestep |

	timestep := 1. " When should it be updated? "

	^aVariable currentComputation
		newOperationOf: 'ApplyAdam'
		namePrefixed: ('Optimization_<1s>' expandMacrosWith: aVariable operationName)
		withAll: (
			(OrderedCollection new)
				add: aVariable;
				add: (self meanGradientOf: aVariable);
				add: (self uncenteredVarianceGradientOf: aVariable);
				add: (firstMomentDecayingRate raisedTo: timestep);
				add: (secondMomentoDecayingRate raisedTo: timestep);
				add: learningRate;
				add: firstMomentDecayingRate;
				add: secondMomentoDecayingRate;
				add: epsilon;
				add: aGradient;
				yourself)
		describedBy: [:d | d at: TFAttributeName useNesterov putBoolean: useNesterov]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
AdaptiveMomentEstimation >> initializeScalingBy: aLearningRate decayingFirstMomentBy: aBeta1Factor decayingSecondMomentBy: aBeta2Factor usingForNumericalStability: anEpsilonValue [

	learningRate := aLearningRate.
	firstMomentDecayingRate := aBeta1Factor.
	secondMomentoDecayingRate := aBeta2Factor.
	epsilon := anEpsilonValue.
	useNesterov := false.
	meanGradientByVariable := Dictionary new.
	gradientVarianceByVariable := Dictionary new
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
AdaptiveMomentEstimation >> meanGradientOf: aVariable [

	^meanGradientByVariable
		at: aVariable
		ifAbsentPut: [
			VariableNode on: aVariable currentComputation named: 'm' filledWithZerosLike: aVariable]
]

{ #category : 'Printing' }
AdaptiveMomentEstimation >> printOn: aStream [

	aStream nextPutAll: (
		'Adam (learning rate: <1p>; beta1: <2p>; beta2: <3p>; epsilon: <4p>)'
			expandMacrosWith: learningRate
			with: firstMomentDecayingRate
			with: secondMomentoDecayingRate
			with: epsilon asFloat)
]

{ #category : 'Accessing' }
AdaptiveMomentEstimation >> shortName [

	^'Adam'
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
AdaptiveMomentEstimation >> uncenteredVarianceGradientOf: aVariable [

	^gradientVarianceByVariable
		at: aVariable
		ifAbsentPut: [
			VariableNode on: aVariable currentComputation named: 'v' filledWithZerosLike: aVariable]
]

{ #category : 'Configuring' }
AdaptiveMomentEstimation >> useNesterovUpdate [

	useNesterov := true
]
