Class {
	#name : 'RootMeanSquaredPropagation',
	#superclass : 'TFOptimizer',
	#instVars : [
		'learningRate',
		'rho',
		'momentum',
		'epsilon',
		'meanSquaredAccum',
		'momentumAccum'
	],
	#category : 'TFOptimizerModel'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
RootMeanSquaredPropagation class >> defaultEpsilonValue [

	^1e-07
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
RootMeanSquaredPropagation class >> defaultLearningRate [

	^0.001
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
RootMeanSquaredPropagation class >> defaultMomentumValue [

	^0.0
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
RootMeanSquaredPropagation class >> defaultRhoFactor [

	^0.9
]

{ #category : 'Instance Creation' }
RootMeanSquaredPropagation class >> new [

	^self
		scalingBy: self defaultLearningRate
		decayingBy: self defaultRhoFactor
		momentumSetTo: self defaultMomentumValue
		usingForNumericalStability: self defaultEpsilonValue
]

{ #category : 'Instance Creation' }
RootMeanSquaredPropagation class >> scalingBy: aLearningRate decayingBy: theRhoFactor momentumSetTo: aMomentumConstant usingForNumericalStability: anEpsilonValue [

	^super new
		initializeScalingBy: aLearningRate
		decayingBy: theRhoFactor
		momentumSetTo: aMomentumConstant
		usingForNumericalStability: anEpsilonValue
]

{ #category : 'Applying' }
RootMeanSquaredPropagation >> apply: aGradient to: aVariable [

	| tf |

	tf := aVariable currentComputation.
	meanSquaredAccum
		ifNil: [meanSquaredAccum := TFVariable on: tf named: 'ms' filledWithZerosLike: aVariable].
	momentumAccum
		ifNil: [momentumAccum := TFVariable on: tf named: 'mom' filledWithZerosLike: aVariable].

	^tf
		newOperationOf: 'ApplyRMSProp'
		namePrefixed: 'ApplyRMSProp'
		withAll: (
			OrderedCollection new
				add: aVariable;
				add: meanSquaredAccum;
				add: momentumAccum;
				add: learningRate;
				add: rho;
				add: momentum;
				add: epsilon;
				add: aGradient;
				yourself)
		describedBy: [:description | ]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
RootMeanSquaredPropagation >> initializeScalingBy: aLearningRate decayingBy: theRhoFactor momentumSetTo: aMomentumConstant usingForNumericalStability: anEpsilonValue [

	learningRate := aLearningRate.
	rho := theRhoFactor.
	momentum := aMomentumConstant.
	epsilon := anEpsilonValue
]

{ #category : 'Printing' }
RootMeanSquaredPropagation >> printOn: aStream [

	aStream nextPutAll: (
		'RMSProp (learning rate: <1p>; rho: <2p>; momentum: <3p>; epsilon: <4p>)'
			expandMacrosWith: learningRate
			with: rho
			with: momentum
			with: epsilon asFloat)
]

{ #category : 'Accessing' }
RootMeanSquaredPropagation >> shortName [

	^'RMSProp'
]
