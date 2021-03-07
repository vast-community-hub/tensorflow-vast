Class {
	#name : 'AdaptiveMomentEstimation',
	#superclass : 'OptimizationAlgorithm',
	#instVars : [
		'learningRate',
		'epsilon',
		'useNesterov',
		'firstMomentDecayingRate',
		'secondMomentDecayingRate',
		'secondMomentDecayingRatePowered',
		'firstMomentDecayingRatePowered',
		'variableGradientsMean',
		'variableGradientsVariance',
		'timestep'
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

	| currentComputation |

	currentComputation := aVariable currentComputation.
	^currentComputation
		newOperationOf: 'ApplyAdam'
		namePrefixed: ('Optimization_<1s>' expandMacrosWith: aVariable operationName)
		withAll: (
			OrderedCollection new
				add: aVariable;
				add: (self gradientsMeanOf: aVariable);
				add: (self gradientsUncenteredVarianceOf: aVariable);
				add: (self firstMomentDecayingRatePoweredOn: currentComputation);
				add: (self secondMomentDecayingRatePoweredOn: currentComputation);
				add: learningRate;
				add: firstMomentDecayingRate;
				add: secondMomentDecayingRate;
				add: epsilon;
				add: aGradient;
				yourself)
		describedBy: [:d | d atUseNesterovPut: useNesterov]
]

{ #category : 'Configuring' }
AdaptiveMomentEstimation >> considerCurrentEpochIn: anEpochHolder [

	timestep := anEpochHolder trainingStepAsVariable castedTo: TFTensor typeFloat
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
AdaptiveMomentEstimation >> firstMomentDecayingRatePoweredOn: currentComputation [

	firstMomentDecayingRatePowered ifNil: [
		firstMomentDecayingRatePowered :=
			(currentComputation floatConstantWith: firstMomentDecayingRate) raisedTo: timestep].
	^firstMomentDecayingRatePowered
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
AdaptiveMomentEstimation >> gradientsMeanOf: aVariable [

	^variableGradientsMean
		at: aVariable
		ifAbsentPut: [
			VariableNode on: aVariable currentComputation named: 'm' filledWithZerosLike: aVariable]
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
AdaptiveMomentEstimation >> gradientsUncenteredVarianceOf: aVariable [

	^variableGradientsVariance
		at: aVariable
		ifAbsentPut: [
			VariableNode on: aVariable currentComputation named: 'v' filledWithZerosLike: aVariable]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
AdaptiveMomentEstimation >> initializeScalingBy: aLearningRate decayingFirstMomentBy: aBeta1Factor decayingSecondMomentBy: aBeta2Factor usingForNumericalStability: anEpsilonValue [

	learningRate := aLearningRate.
	firstMomentDecayingRate := aBeta1Factor.
	secondMomentDecayingRate := aBeta2Factor.
	epsilon := anEpsilonValue.
	useNesterov := false.
	variableGradientsMean := Dictionary new.
	variableGradientsVariance := Dictionary new.
	timestep := 1 asFloatTensor
]

{ #category : 'Printing' }
AdaptiveMomentEstimation >> printOn: aStream [

	aStream nextPutAll: (
		'Adam (learning rate: <1p>; beta1: <2p>; beta2: <3p>; epsilon: <4p>)'
			expandMacrosWith: learningRate
			with: firstMomentDecayingRate
			with: secondMomentDecayingRate
			with: epsilon asFloat)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
AdaptiveMomentEstimation >> secondMomentDecayingRatePoweredOn: currentComputation [

	secondMomentDecayingRatePowered ifNil: [
		secondMomentDecayingRatePowered :=
			(currentComputation floatConstantWith: secondMomentDecayingRate) raisedTo: timestep].
	^secondMomentDecayingRatePowered
]

{ #category : 'Accessing' }
AdaptiveMomentEstimation >> shortName [

	^'Adam'
]

{ #category : 'Configuring' }
AdaptiveMomentEstimation >> useNesterovUpdate [

	useNesterov := true 
]
