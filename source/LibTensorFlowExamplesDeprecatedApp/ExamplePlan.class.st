Class {
	#name : 'ExamplePlan',
	#superclass : 'Object',
	#instVars : [
		'graph',
		'inputs',
		'outputs',
		'session'
	],
	#category : 'LibTensorFlowExamplesDeprecatedApp'
}

{ #category : 'instance creation' }
ExamplePlan class >> new [

	^super new initialize
]

{ #category : 'initialization',
  #vaVisibility : 'private' }
ExamplePlan >> initialize [

	self initializeGraph.
	self initializeSession
]

{ #category : 'initialization' }
ExamplePlan >> initializeGraph [

	graph := TFGraph create
]

{ #category : 'initialization',
  #vaVisibility : 'private' }
ExamplePlan >> initializeSession [

	session := TFSession on: graph.
	graph initializeOn: session
]

{ #category : 'running' }
ExamplePlan >> runOn: inputValues [
	| results |	
	results := session
		runInputs: inputs
		values: inputValues
		outputs: outputs.
		
	^ results first
	
]
