Class {
	#name : 'Gradient',
	#superclass : 'TensorFlowOperationAbstract',
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
Gradient class >> assert: aFunctionCollection hasTheSameSizeAs: aVectorCollection [

	aFunctionCollection size = aVectorCollection size ifFalse: [SizeMismatch signal]
]

{ #category : 'Instance Creation',
  #vaVisibility : 'private' }
Gradient class >> defaultName [

	^'Grad'
]

{ #category : 'Instance Creation' }
Gradient class >> named: anOperationName of: aFunctionCollection withRespectTo: aVariableCollection [

	^self
		named: anOperationName
		of: aFunctionCollection
		withRespectTo: aVariableCollection
		product: nil
]

{ #category : 'Instance Creation' }
Gradient class >> named: anOperationName of: aFunctionCollection withRespectTo: aVariableCollection product: aCotangentVectors [

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
Gradient class >> of: aFunctionCollection withRespectTo: aVariableCollection [

	^self named: self defaultName of: aFunctionCollection withRespectTo: aVariableCollection
]

{ #category : 'Instance Creation' }
Gradient class >> of: aFunctionCollection withRespectTo: aVariableCollection product: aCotangentVectors [

	^self
		named: self defaultName
		of: aFunctionCollection
		withRespectTo: aVariableCollection
		product: aCotangentVectors
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
Gradient class >> toArray: aSingleElementOrCollection [

	^(aSingleElementOrCollection isA: Collection)
		ifTrue: [aSingleElementOrCollection]
		ifFalse: [Array with: aSingleElementOrCollection]
]

{ #category : 'Accessing' }
Gradient >> allPartialDerivatives [

	| grads |

	grads := Array new: variables size.
	variables doWithIndex: [:var :index | grads at: index put: (value at: index)].
	^grads
]

{ #category : 'Accessing' }
Gradient >> currentComputation [

	^currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Gradient >> initializeNamed: aString of: aFunctionCollection withRespectTo: aVariableCollection product: aCotangentVectors [

	currentComputation := aFunctionCollection first currentComputation.
	operationName := aString.
	functions := aFunctionCollection.
	variables := aVariableCollection.

	value :=
		currentComputation gradientsOf: functions withRespectTo: variables product: aCotangentVectors.

	"value is a TFOutputArray so I have to set the graph from outside. Pretty ugly"
	self allPartialDerivatives
		do: [:gradOutput | gradOutput graph: (currentComputation instVarNamed: 'graph')]
]

{ #category : 'Accessing' }
Gradient >> operationName [

	^operationName
]

{ #category : 'Accessing' }
Gradient >> valueWithRespectTo: aVariable [

	^value at: (variables indexOf: aVariable)
]
