Class {
	#name : 'Momentum',
	#superclass : 'TFOptimizer',
	#instVars : [
		'learningRate',
		'momentum',
		'accumulator',
		'useNesterov'
	],
	#category : 'TFOptimizerModel'
}

{ #category : 'Instance Creation' }
Momentum class >> new [

	^self scalingBy: 0.001 momentumSetTo: 0.9
]

{ #category : 'Instance Creation' }
Momentum class >> scalingBy: aLearningRate momentumSetTo: aMomentumTerm [

	^super new initializeScalingBy: aLearningRate momentumSetTo: aMomentumTerm


]

{ #category : 'Applying' }
Momentum >> apply: aGradient to: aVariable [

	| tf |

	tf := aVariable currentComputation.
	accumulator
		ifNil: [accumulator := TFVariable on: tf named: 'accum' filledWithZerosLike: aVariable].

	^tf
		newOperationOf: 'ApplyMomentum'
		namePrefixed: 'ApplyMomentum'
		withAll: (
			OrderedCollection new
				add: aVariable;
				add: accumulator;
				add: learningRate;
				add: aGradient;
				add: momentum;
				yourself)
		describedBy: [:d | d at: 'use_nesterov' putBoolean: useNesterov]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Momentum >> initializeScalingBy: aLearningRate momentumSetTo: aMomentumTerm [

	learningRate := aLearningRate.
	momentum := aMomentumTerm.
	useNesterov := false
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
