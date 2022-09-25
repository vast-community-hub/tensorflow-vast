Class {
	#name : 'Adam',
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
	#category : 'NeuralNetworkTrainingOptimizerModel'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
Adam class >> defaultBeta1Factor [

	^0.9
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
Adam class >> defaultBeta2Factor [

	^0.999
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
Adam class >> defaultEpsilonValue [

	^10e-8
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
Adam class >> defaultLearningRate [

	^0.001
]

{ #category : 'Instance Creation' }
Adam class >> new [

	^self
		scalingBy: self defaultLearningRate
		decayingFirstMomentBy: self defaultBeta1Factor
		decayingSecondMomentBy: self defaultBeta2Factor
		usingForNumericalStability: self defaultEpsilonValue
]

{ #category : 'Instance Creation' }
Adam class >> scalingBy: aLearningRate decayingFirstMomentBy: aBeta1Factor decayingSecondMomentBy: aBeta2Factor usingForNumericalStability: anEpsilonValue [

	^super new
		initializeScalingBy: aLearningRate
		decayingFirstMomentBy: aBeta1Factor
		decayingSecondMomentBy: aBeta2Factor
		usingForNumericalStability: anEpsilonValue
]

{ #category : 'Applying' }
Adam >> apply: aGradient to: aVariable [

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
Adam >> considerCurrentEpochIn: anEpochHolder [

	timestep := anEpochHolder trainingStepAsVariable castedTo: FloatDataType new
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
Adam >> firstMomentDecayingRatePoweredOn: currentComputation [

	firstMomentDecayingRatePowered ifNil: [
		firstMomentDecayingRatePowered :=
			(currentComputation floatConstantWith: firstMomentDecayingRate) raisedTo: timestep].
	^firstMomentDecayingRatePowered
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
Adam >> gradientsMeanOf: aVariable [

	^variableGradientsMean
		at: aVariable
		ifAbsentPut: [
			VariableTensor on: aVariable currentComputation named: 'm' filledWithZerosLike: aVariable]
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
Adam >> gradientsUncenteredVarianceOf: aVariable [

	^variableGradientsVariance
		at: aVariable
		ifAbsentPut: [
			VariableTensor on: aVariable currentComputation named: 'v' filledWithZerosLike: aVariable]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Adam >> initializeScalingBy: aLearningRate decayingFirstMomentBy: aBeta1Factor decayingSecondMomentBy: aBeta2Factor usingForNumericalStability: anEpsilonValue [

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
Adam >> printOn: aStream [

	aStream nextPutAll: (
		'Adam (learning rate: <1p>; beta1: <2p>; beta2: <3p>; epsilon: <4p>)'
			expandMacrosWith: learningRate
			with: firstMomentDecayingRate
			with: secondMomentDecayingRate
			with: epsilon asFloat)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
Adam >> secondMomentDecayingRatePoweredOn: currentComputation [

	secondMomentDecayingRatePowered ifNil: [
		secondMomentDecayingRatePowered :=
			(currentComputation floatConstantWith: secondMomentDecayingRate) raisedTo: timestep].
	^secondMomentDecayingRatePowered
]

{ #category : 'Accessing' }
Adam >> shortName [

	^'Adam'
]

{ #category : 'Configuring' }
Adam >> useNesterovUpdate [

	useNesterov := true 
]
