Class {
	#name : 'AdaptiveMomentEstimation',
	#superclass : 'OptimizationAlgorithm',
	#instVars : [
		'learningRate',
		'beta1',
		'beta2',
		'epsilon',
		'movingAverages',
		'squaredGradient',
		'useNesterov'
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

	| tf timestep |

	tf := aVariable currentComputation.
	movingAverages
		ifNil: [movingAverages := VariableNode on: tf named: 'm' filledWithZerosLike: aVariable].
	squaredGradient
		ifNil: [squaredGradient := VariableNode on: tf named: 'v' filledWithZerosLike: aVariable].
	timestep := 1. " When should it be updated? "

	^tf
		newOperationOf: 'ApplyAdam'
		namePrefixed: 'ApplyAdam'
		withAll: (
			OrderedCollection new
				add: aVariable;
				add: movingAverages;
				add: squaredGradient;
				add: (beta1 raisedTo: timestep);
				add: (beta2 raisedTo: timestep);
				add: learningRate;
				add: beta1;
				add: beta2;
				add: epsilon;
				add: aGradient;
				yourself)
		describedBy: [:d | d at: TFAttributeName useNesterov putBoolean: useNesterov]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
AdaptiveMomentEstimation >> initializeScalingBy: aLearningRate decayingFirstMomentBy: aBeta1Factor decayingSecondMomentBy: aBeta2Factor usingForNumericalStability: anEpsilonValue [

	learningRate := aLearningRate.
	beta1 := aBeta1Factor.
	beta2 := aBeta2Factor.
	epsilon := anEpsilonValue. 
	useNesterov := false. 
]

{ #category : 'Printing' }
AdaptiveMomentEstimation >> printOn: aStream [

	aStream nextPutAll: (
		'Adam (learning rate: <1p>; beta1: <2p>; beta2: <3p>; epsilon: <4p>)'
			expandMacrosWith: learningRate
			with: beta1
			with: beta2
			with: epsilon asFloat)
]

{ #category : 'Accessing' }
AdaptiveMomentEstimation >> shortName [

	^'Adam'
]

{ #category : 'Configuring' }
AdaptiveMomentEstimation >> useNesterovUpdate [

	useNesterov := true
]
