Class {
	#name : 'TFGradient',
	#superclass : 'TFGradientBehavior',
	#instVars : [
		'operationName',
		'functions',
		'variables',
		'currentComputation'
	],
	#category : 'TFOperationGradientModel'
}

{ #category : 'Instance Creation',
  #vaVisibility : 'private' }
TFGradient class >> assert: aFunctionCollection hasTheSameSizeAs: aVectorCollection [

	aFunctionCollection size = aVectorCollection size ifFalse: [SizeMismatch signal]
]

{ #category : 'Instance Creation',
  #vaVisibility : 'private' }
TFGradient class >> defaultName [

	^'Grad'
]

{ #category : 'Instance Creation' }
TFGradient class >> named: anOperationName of: aFunctionCollection withRespectTo: aVariableCollection [

	^self
		named: anOperationName
		of: aFunctionCollection
		withRespectTo: aVariableCollection
		product: nil
]

{ #category : 'Instance Creation' }
TFGradient class >> named: anOperationName of: aFunctionCollection withRespectTo: aVariableCollection product: aCotangentVectors [

	| functions variables cotangents |

	functions := self toArray: aFunctionCollection.
	variables := self toArray: aVariableCollection.
	cotangents := aCotangentVectors ifNil: [nil] ifNotNil: [self toArray: aCotangentVectors].
	aCotangentVectors ifNotNil: [self assert: functions hasTheSameSizeAs: cotangents].

	^self new
		initializeNamed: anOperationName
		of: functions
		withRespectTo: variables
		product: cotangents
]

{ #category : 'Instance Creation' }
TFGradient class >> of: aFunctionCollection withRespectTo: aVariableCollection [

	^self named: self defaultName of: aFunctionCollection withRespectTo: aVariableCollection
]

{ #category : 'Instance Creation' }
TFGradient class >> of: aFunctionCollection withRespectTo: aVariableCollection product: aCotangentVectors [

	^self
		named: self defaultName
		of: aFunctionCollection
		withRespectTo: aVariableCollection
		product: aCotangentVectors
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFGradient class >> toArray: aSingleElementOrCollection [

	^(aSingleElementOrCollection isA: Collection)
		ifTrue: [aSingleElementOrCollection]
		ifFalse: [Array with: aSingleElementOrCollection]
]

{ #category : 'Accessing' }
TFGradient >> allGradients [

	| grads |

	grads := Array new: variables size.
	variables doWithIndex: [:var :index | grads at: index put: (value at: index)].
	^grads
]

{ #category : 'Accessing' }
TFGradient >> currentComputation [

	^currentComputation
]

{ #category : 'Accessing' }
TFGradient >> gradientRespectTo: aVariable [

	^value at: (variables indexOf: aVariable)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFGradient >> initializeNamed: aString of: aFunctionCollection withRespectTo: aVariableCollection product: aCotangentVectors [

	currentComputation := aFunctionCollection first currentComputation.
	operationName := aString.
	functions := aFunctionCollection.
	variables := aVariableCollection.

	value :=
		currentComputation gradientsOf: functions withRespectTo: variables product: aCotangentVectors.

	"value is a TFOutputArray so I have to set the graph from outside. Pretty ugly"
	self allGradients
		do: [:gradOutput | gradOutput graph: (currentComputation instVarNamed: 'graph')]
]

{ #category : 'Accessing' }
TFGradient >> operationName [

	^operationName
]
