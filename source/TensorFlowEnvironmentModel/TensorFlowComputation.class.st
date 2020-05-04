Class {
	#name : 'TensorFlowComputation',
	#superclass : 'Object',
	#instVars : [
		'graph',
		'session'
	],
	#category : 'TensorFlowEnvironmentModel'
}

{ #category : 'Instance Creation' }
TensorFlowComputation class >> new [

	^self on: TFGraph create
]

{ #category : 'Instance Creation' }
TensorFlowComputation class >> on: aTFGraph [

	^super new initializeOn: aTFGraph
]

{ #category : 'Computing' }
TensorFlowComputation >> compute: anOperation [

	^self compute: anOperation feedingInputsWith: Dictionary new
]

{ #category : 'Computing' }
TensorFlowComputation >> compute: anOperation feedingInputsWith: aPlaceholderValueMapping [

	^(self computeAll: (Array with: anOperation) feedingInputsWith: aPlaceholderValueMapping)
		at: anOperation
]

{ #category : 'Computing' }
TensorFlowComputation >> computeAll: operations feedingInputsWith: aPlaceholderValueMapping [

	| inputPlaceholders inputValues outputs results resultsByName |

	inputPlaceholders := OrderedCollection new.
	inputValues := OrderedCollection new.
	aPlaceholderValueMapping keysAndValuesDo: [:placeholderName :value |
		inputPlaceholders add: (graph operationNamed: placeholderName) firstInput.
		inputValues add: value].

	outputs := operations collect: [:operation | operation outputOn: graph].

	results :=
		self
			createSessionAndCompute: outputs asArray
			feeding: inputPlaceholders asArray
			with: inputValues asArray.

	resultsByName := Dictionary new.
	operations
		doWithIndex: [:operation :index | resultsByName at: operation put: (results at: index)].
	^resultsByName
]

{ #category : 'Computing' }
TensorFlowComputation >> computeAllNamed: anOperationsName feedingInputsWith: aPlaceholderValueMapping [

	| inputPlaceholders inputValues outputs results resultsByName |

	inputPlaceholders := OrderedCollection new.
	inputValues := OrderedCollection new.
	aPlaceholderValueMapping keysAndValuesDo: [:placeholderName :value |
		inputPlaceholders add: (graph operationNamed: placeholderName) firstInput.
		inputValues add: value].

	outputs :=
		anOperationsName
			collect: [:operationName | (graph operationNamed: operationName) firstOutput].

	results :=
		self
			createSessionAndCompute: outputs asArray
			feeding: inputPlaceholders asArray
			with: inputValues asArray.

	resultsByName := Dictionary new.
	anOperationsName
		doWithIndex: [:outputName :index | resultsByName at: outputName put: (results at: index)].
	^resultsByName
]

{ #category : 'Computing',
  #vaVisibility : 'private' }
TensorFlowComputation >> createSessionAndCompute: anArrayOfOutputs feeding: anArrayOfPlaceholders with: anArrayOfInputs [

	session ifNil: [
		session := TFSession on: graph.
		"When initialize graph, we initialize also the variables. So this can't be done before the variables are created, 
		 and can't be done every time we call run, because will be overriding them every time with the initial value. 
		 This is the best place I cound found to do it." 
		graph initializeOn: session].

	^session runInputs: anArrayOfPlaceholders values: anArrayOfInputs outputs: anArrayOfOutputs
]

{ #category : 'Computing' }
TensorFlowComputation >> gradientsOf: aFunctionCollection withRespectTo: aVariableCollection [

	^graph
		gradientsOf: (aFunctionCollection collect: [:function | function outputOn: graph])
		withRespectTo: (aVariableCollection collect: [:var | var outputOn: graph])
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TensorFlowComputation >> initializeOn: aGraph [

	graph := aGraph
]

{ #category : 'Accessing' }
TensorFlowComputation >> inScopeNamed: aScopeName do: aBlock [

	^graph inScopeNamed: aScopeName do: aBlock
]

{ #category : 'Creating - Operations' }
TensorFlowComputation >> newOperationOf: anOperationType named: anOperationName with: aTFNode [

	^self
		newOperationOf: anOperationType
		named: anOperationName
		withAll: (Array with: aTFNode)
		describedBy: [:desc | ]
]

{ #category : 'Creating - Operations' }
TensorFlowComputation >> newOperationOf: anOperationType named: anOperationName with: aTFNode with: anotherTFNode [

	^self
		newOperationOf: anOperationType
		named: anOperationName
		withAll: (Array with: aTFNode with: anotherTFNode)
		describedBy: [:desc | ]
]

{ #category : 'Creating - Operations' }
TensorFlowComputation >> newOperationOf: anOperationType named: anOperationName withAll: graphNodes describedBy: aBlock [

	^graph
		newOperation: anOperationType
		named: (graph nameFor: anOperationName)
		described: [:description |
			graphNodes do: [:node | description addInput: (node outputOn: graph)].
			aBlock value: description]
]

{ #category : 'Creating - Operations' }
TensorFlowComputation >> newOperationOf: anOperationType named: anOperationName withList: aTFNodeCollection [

	^graph
		newOperation: anOperationType
		named: anOperationName
		described: [:description |
			description addInputs: (aTFNodeCollection collect: [:node | node outputOn: graph])]
]
