Class {
	#name : 'TensorFlowEnvironment',
	#superclass : 'Object',
	#instVars : [
		'calculator'
	],
	#category : 'TensorFlowEnvironmentDeprecatedModel'
}

{ #category : 'Instance Creation' }
TensorFlowEnvironment class >> new [

	^super new initialize
]

{ #category : 'Processing' }
TensorFlowEnvironment >> calculate: aBlock [

	| operation |

	operation := aBlock value: calculator.
	^calculator resultOf: operation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TensorFlowEnvironment >> initialize [

	super initialize.
	calculator := TensorFlowCalculator new
]
