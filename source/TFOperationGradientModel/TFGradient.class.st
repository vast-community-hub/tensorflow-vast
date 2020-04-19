Class {
	#name : 'TFGradient',
	#superclass : 'TFGradientBehavior',
	#instVars : [
		'operationName',
		'functions',
		'variables'
	],
	#category : 'TFOperationGradientModel'
}

{ #category : 'Instance Creation' }
TFGradient class >> named: anOperationName of: aFunctionCollection withRespectTo: aVariableCollection [

	^self new
		initializeNamed: anOperationName
		of: aFunctionCollection
		withRespectTo: aVariableCollection
]

{ #category : 'Instance Creation' }
TFGradient class >> of: aFunctionCollection withRespectTo: aVariableCollection [
	
	^self named: 'Grad' of: aFunctionCollection withRespectTo: aVariableCollection
]

{ #category : 'Accessing' }
TFGradient >> allGradients [

	| grads |

	grads := Array new: variables size.
	variables doWithIndex: [:var :index | grads at: index put: (value at: index)].
	^grads
]

{ #category : 'Accessing' }
TFGradient >> gradientRespectTo: aVariable [

	^value at: (variables indexOf: aVariable)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFGradient >> initializeNamed: aString of: aFunctionCollection withRespectTo: aVariableCollection [

	operationName := aString.
	functions := aFunctionCollection.
	variables := aVariableCollection.

	value := functions first currentComputation gradientsOf: functions withRespectTo: variables.

	"value is a TFOutputArray so I have to put the graph from outside. Pretty ugly"
	self allGradients
		do: [:gradOutput | gradOutput graph: (functions first currentComputation instVarAt: 1)]
]

{ #category : 'Accessing' }
TFGradient >> operationName [

	^operationName
]
