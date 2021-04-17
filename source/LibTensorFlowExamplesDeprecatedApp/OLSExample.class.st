Class {
	#name : 'OLSExample',
	#superclass : 'Object',
	#instVars : [
		'plan'
	],
	#category : 'LibTensorFlowExamplesDeprecatedApp'
}

{ #category : 'instance creation' }
OLSExample class >> new [

	^super new initialize
]

{ #category : 'initialization' }
OLSExample >> initialize [
	plan := ExampleOLSPlan new.
]

{ #category : 'initialization' }
OLSExample >> initializeWithOperations [
	plan := ExampleOLSPlan new initializeGraphWithOperations initializeSession
]

{ #category : 'running' }
OLSExample >> regress: x on: y [

	| result |

	result := plan runOn: (Array with: x with: y).
	^result allFloats
]
