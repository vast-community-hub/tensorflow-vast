Class {
	#name : 'TensorFlowCalculator',
	#superclass : 'Object',
	#instVars : [
		'graph'
	],
	#category : 'TensorFlowEnvironmentModel'
}

{ #category : 'Instance Creation' }
TensorFlowCalculator class >> new [

	^super new initialize
]

{ #category : 'Operations' }
TensorFlowCalculator >> add: aTensorCollection [

	aTensorCollection isEmpty ifTrue: [^self constant: 0].

	^aTensorCollection allButFirst
		inject: aTensorCollection first
		into: [:combinedOperation :nextOperation |
			self calculate: 'Add' withAll: (Array with: combinedOperation with: nextOperation)]
]

{ #category : 'Operations' }
TensorFlowCalculator >> assign: aValue to: aVariable [

	| operationName |

	operationName := aVariable name , '_initializer'.
	graph
		operationNamed: operationName
		ifFound: [:operation | operation assign: aValue]
		ifNotFound: [aVariable assign: aValue].
	^aVariable
]

{ #category : 'Processing',
  #vaVisibility : 'private' }
TensorFlowCalculator >> calculate: anOperationName with: anArgument [

	^self calculate: anOperationName withAll: (Array with: anArgument)
]

{ #category : 'Processing',
  #vaVisibility : 'private' }
TensorFlowCalculator >> calculate: anOperationName withAll: anArgumentCollection [

	anArgumentCollection size >= 1 ifFalse: [self error: 'At least one argument must be provided'].

	^(anArgumentCollection first asOperationOn: graph)
		op: anOperationName
		withAll: anArgumentCollection allButFirst
]

{ #category : 'Accessing' }
TensorFlowCalculator >> constant: aNumber [

	^aNumber asOperationOn: graph
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TensorFlowCalculator >> coordinatesOf: aShape [

	^aShape isEmpty ifTrue: [#()] ifFalse: [self coordinatesOfNotEmpty: aShape]
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TensorFlowCalculator >> coordinatesOfNotEmpty: aShape [

	| prefixes |

	prefixes := (1 to: aShape first) collect: [:prefix | OrderedCollection with: prefix - 1].
	^aShape size = 1
		ifTrue: [prefixes]
		ifFalse: [self coordinatesOfNotOneDimensional: aShape after: prefixes]
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TensorFlowCalculator >> coordinatesOfNotOneDimensional: aShape after: aPrefixCollection [

	| suffixes |

	suffixes := self coordinatesOf: aShape allButFirst.
	^aPrefixCollection
		inject: OrderedCollection new
		into: [:coordinates :prefix |
			coordinates
				addAll: (
					suffixes collect: [:suffix |
						OrderedCollection new
							addAll: prefix;
							addAll: suffix;
							yourself]);
				yourself]
]

{ #category : 'Operations' }
TensorFlowCalculator >> encodeBase64: aString [

	| stringTensor |

	stringTensor := TFTensor fromStrings: (Array with: aString).
	^self calculate: 'EncodeBase64' with: stringTensor
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TensorFlowCalculator >> flattenedValuesFrom: aTensor [

	^self
		calculate: 'Reshape'
		withAll: (Array with: aTensor with: (Array with: aTensor size) asInt32Tensor)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TensorFlowCalculator >> initialize [

	super initialize.
	graph := TFGraph create
]

{ #category : 'Operations' }
TensorFlowCalculator >> multiplyElementsOf: aTensor by: aScalar [

	^self calculate: 'Mul' withAll: (Array with: aTensor with: aScalar)
]

{ #category : 'Operations' }
TensorFlowCalculator >> multiplyMatrices: aTensorCollection [

	"https://www.tensorflow.org/api_docs/cc/class/tensorflow/ops/mat-mul.html"

	aTensorCollection isEmpty ifTrue: [^self constant: 0].

	^aTensorCollection allButFirst
		inject: aTensorCollection first
		into: [:combinedOperation :nextOperation |
			self calculate: 'MatMul' withAll: (Array with: combinedOperation with: nextOperation)]
]

{ #category : 'Operations' }
TensorFlowCalculator >> reduceSum: aTensor [

	"https://www.tensorflow.org/api_docs/cc/class/tensorflow/ops/sparse-reduce-sum.html"

	| indices values shape reductionAxes |

	indices := (self coordinatesOf: aTensor shape) asInt64Tensor.
	values := self flattenedValuesFrom: aTensor.
	shape := aTensor shape asInt64Tensor.
	reductionAxes := self reductionAxesFor: aTensor.
	^self
		calculate: 'SparseReduceSum'
		withAll: (Array with: indices with: values with: shape with: reductionAxes)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TensorFlowCalculator >> reductionAxesFor: aTensor [

	^((1 to: aTensor numDims) collect: [:dimension | dimension - 1]) asInt32Tensor
]

{ #category : 'Processing' }
TensorFlowCalculator >> resultOf: anOperation [

	^graph runOutput: anOperation firstOutput
]

{ #category : 'Operations' }
TensorFlowCalculator >> square: aTensor [

	^self calculate: 'Square' with: aTensor
]

{ #category : 'Tensor Creation' }
TensorFlowCalculator >> tensorOf: aScalar with: aShape [

	^self calculate: 'Fill' withAll: (Array with: aShape with: aScalar)
]

{ #category : 'Tensor Creation' }
TensorFlowCalculator >> tensorOfOnesWith: aShape [

	^self tensorOf: 1 with: aShape
]

{ #category : 'Accessing' }
TensorFlowCalculator >> variable: aNumber [

	^graph variable: (graph nameFor: 'variable') initialValue: aNumber asTensor
]

{ #category : 'Accessing' }
TensorFlowCalculator >> variableNamed: aName [

	^ graph variable: aName forTensor: 0 asTensor
]
