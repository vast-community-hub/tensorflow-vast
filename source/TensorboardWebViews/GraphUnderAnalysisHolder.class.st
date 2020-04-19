Class {
	#name : 'GraphUnderAnalysisHolder',
	#superclass : 'Object',
	#instVars : [
		'graphUnderAnalysis'
	],
	#classInstVars : [
		'current'
	],
	#category : 'TensorboardWebViews'
}

{ #category : 'Instance Creation' }
GraphUnderAnalysisHolder class >> clearCurrent [

	current := nil
]

{ #category : 'Instance Creation' }
GraphUnderAnalysisHolder class >> current [

	current ifNil: [current := self new initialize].
	^current
]

{ #category : 'Configuring' }
GraphUnderAnalysisHolder >> analyze: aGraph [

	graphUnderAnalysis := aGraph
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
GraphUnderAnalysisHolder >> initialize [

	graphUnderAnalysis := nil
]

{ #category : 'Accessing' }
GraphUnderAnalysisHolder >> withDefinitionTextDo: aBlock [


	"WIP: graphUnderAnalysis definition needs to be converted to pbtxt first. 
		For the moment we use an example, but this method should be: 
	graphUnderAnalysis ifNotNil: [:graph | aBlock value: graph definitionText]."
	
	aBlock value:
		'node { name: "a" op: "Const" attr { key: "dtype" value { type: DT_INT32 } } attr { key: "value" value { tensor { dtype: DT_INT32 tensor_shape { } int_val: 42 } } } } node { name: "init" op: "NoOp" } versions { producer: 15 }'
]
