Class {
	#name : 'TFOperation',
	#superclass : 'TFStructure',
	#instVars : [
		'graph',
		'output'
	],
	#category : 'TensorFlowCore'
}

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFOperation class >> initializeAfterLoad [
	"Set an opaque layout."

	self initializeOpaqueLayout
]

{ #category : 'instance creation' }
TFOperation class >> new [

	^super new initialize
]

{ #category : 'ops binary' }
TFOperation >> * aTFOperation [
	^ self binaryOp: 'MatMul' with: aTFOperation
]

{ #category : 'ops binary' }
TFOperation >> *\ aTFOperation [
	^ self
		binaryOp: 'MatMul'
		with: aTFOperation
		described: [ :description | description at: 'transpose_b' putBoolean: true ]
]

{ #category : 'ops binary' }
TFOperation >> + aTFOperation [
	^ self binaryOp: 'Add' with: aTFOperation
]

{ #category : 'ops binary' }
TFOperation >> - aTFOperation [
	^ self binaryOp: 'Sub' with: aTFOperation
]

{ #category : 'ops binary' }
TFOperation >> -= aTFOperation [
	^ self binaryOp: 'AssignSub' with: aTFOperation
]

{ #category : 'ops binary' }
TFOperation >> > aTFOperation [
	^ self binaryOp: 'Greater' with: aTFOperation
]

{ #category : 'ops binary' }
TFOperation >> @* aTFOperation [
	^ self binaryOp: 'Mul' with: aTFOperation
]

{ #category : 'ops binary' }
TFOperation >> @/ aTFOperation [
	^ self binaryOp: 'Div' with: aTFOperation
]

{ #category : 'ops binary' }
TFOperation >> \* aTFOperation [
	^ self
		binaryOp: 'MatMul'
		with: aTFOperation
		described: [ :description | description at: 'transpose_a' putBoolean: true ]
]

{ #category : 'ops binary' }
TFOperation >> \\ aTFOperation [
	^ self binaryOp: 'Mod' with: aTFOperation
]

{ #category : 'ops unary' }
TFOperation >> abs [
	^ self unaryOp: 'Abs'
]

{ #category : 'ops unary' }
TFOperation >> alias: nameString [
	^ self unaryOp: 'Identity' named: nameString
]

{ #category : 'ops unary' }
TFOperation >> arcCos [
	^ self unaryOp: 'Acos'
]

{ #category : 'ops unary' }
TFOperation >> arcSin [
	^ self unaryOp: 'Asin'
]

{ #category : 'ops unary' }
TFOperation >> arcTan [
	^ self unaryOp: 'Atan'
]

{ #category : 'converting' }
TFOperation >> asOperationOn: aTFGraph [
	graph == aTFGraph
		ifTrue: [ ^ self ]
		ifFalse: [ ^ Error signal: 'Can''t move an operation to another Graph' ]
		
]

{ #category : 'ops binary' }
TFOperation >> assign: aTFOperation [
	^ self
		binaryOp: 'Assign'
		with: aTFOperation
		named: self name , '_initializer'
]

{ #category : 'attributes' }
TFOperation >> attrMetadata: nameString [
	| status answer |
	status := TFStatus create.
	answer := self library
		operation: self
		getMetadataFor: nameString asAsciiZ
		status: status.
	status check.
	^ answer
]

{ #category : 'ops binary' }
TFOperation >> binaryOp: aString with: aTFOperation [
	^ self
		binaryOp: aString
		with: aTFOperation
		described: [ :nothing |  ]
]

{ #category : 'ops binary' }
TFOperation >> binaryOp: aString with: aTFOperation described: oneArgBlock [
	| name |
	name := self nameFor: aString.
	^ self
		binaryOp: aString
		with: aTFOperation
		named: name
		described: oneArgBlock
]

{ #category : 'ops binary' }
TFOperation >> binaryOp: aString with: aTFOperation named: name [
	^ self
		binaryOp: aString
		with: aTFOperation
		named: name
		described: [ :nothing |  ]
]

{ #category : 'ops binary' }
TFOperation >> binaryOp: aString with: aTFOperation named: name described: oneArgBlock [
	^ self
		op: aString
		withAll:
			((Array new: 1)
				at: 1 put: aTFOperation;
				yourself)
		named: name
		described: oneArgBlock
]

{ #category : 'attributes' }
TFOperation >> boolAt: nameString [
	| value status |
	status := TFStatus create.
	value := TFStructure externalNew: 1.
	self library
		operation: self
		attr: nameString asAsciiZ
		getBool: value
		status: status.
	status check.
	^ value bool8At: 0
]

{ #category : 'ops binary' }
TFOperation >> castTo: typeInteger [
	^ self
		unaryOp: 'Cast'
		described: [ :description | description at: 'DstT' putType: typeInteger ]
]

{ #category : 'ops unary' }
TFOperation >> cos [
	^ self unaryOp: 'Cos'
]

{ #category : 'ops other' }
TFOperation >> descent: delta rate: learningRate [
	^ self
		op: 'ApplyGradientDescent'
		withAll:
			((Array new: 2)
				at: 1 put: learningRate;
				at: 2 put: delta;
				yourself)
]

{ #category : 'accessing' }
TFOperation >> device [
	^ self library operationDevice: self
]

{ #category : 'ops unary' }
TFOperation >> exp [
	^ self unaryOp: 'Exp'
]

{ #category : 'ops binary' }
TFOperation >> findMaxOn: aTFOperation [
	^ self binaryOp: 'ArgMax' with: aTFOperation
]

{ #category : 'ops binary' }
TFOperation >> findMinOn: aTFOperation [
	^ self binaryOp: 'ArgMin' with: aTFOperation
]

{ #category : 'accessing' }
TFOperation >> firstInput [
	^ self input: 0
]

{ #category : 'initialization' }
TFOperation >> firstOutput [
	output ifNil: [ output := 0 ].
	^ self output: output
]

{ #category : 'attributes' }
TFOperation >> floatAt: nameString [
	| value status |
	status := TFStatus create.
	value := TFStructure new: 8.
	self library
		operation: self
		attr: nameString asAsciiZ
		getFloat: value
		status: status.
	status check.
	^ value float32At: 0
]

{ #category : 'accessing' }
TFOperation >> graph [
	^ graph
]

{ #category : 'accessing' }
TFOperation >> graph: aTFGraph [
	graph := aTFGraph
]

{ #category : 'ops unary' }
TFOperation >> identity [
	^ self unaryOp: 'Identity'
]

{ #category : 'accessing' }
TFOperation >> input: indexInteger [
	^ TFInput onOperation: self index: indexInteger
]

{ #category : 'accessing' }
TFOperation >> inputsCount [

	^self library operationNumInputs: self
]

{ #category : 'attributes' }
TFOperation >> intAt: nameString [
	| value status |
	status := TFStatus create.
	value := TFStructure new: 8.
	self library
		operation: self
		attr: nameString asAsciiZ
		getInt64: value
		status: status.
	status check.
	^ value uint64At: 0
]

{ #category : 'ops unary' }
TFOperation >> inverse [
	^ self unaryOp: 'MatrixInverse'
]

{ #category : 'ops binary' }
TFOperation >> meanOn: shapeTensorOrOperation [
	^ self binaryOp: 'Mean' with: shapeTensorOrOperation
]

{ #category : 'accessing' }
TFOperation >> name [
	^ self library operationName: self
]

{ #category : 'ops other' }
TFOperation >> nameFor: namePrefix [
	^ graph nameFor: namePrefix
]

{ #category : 'ops unary' }
TFOperation >> negated [
	^ self unaryOp: 'Neg'
]

{ #category : 'ops other' }
TFOperation >> op: aString withAll: aTFOperationArray [
	^ self
		op: aString
		withAll: aTFOperationArray
		described: [ :nothing |  ]
]

{ #category : 'ops other' }
TFOperation >> op: aString withAll: aTFOperationArray described: oneArgBlock [
	| name |
	name := self nameFor: aString.
	^ self
		op: aString
		withAll: aTFOperationArray
		named: name
		described: oneArgBlock
]

{ #category : 'ops other' }
TFOperation >> op: aString withAll: aTFOperationArray named: name [
	^ self
		op: aString
		withAll: aTFOperationArray
		named: name
		described: [ :nothing |  ]
]

{ #category : 'ops other' }
TFOperation >> op: aString withAll: aTFOperationArray named: name described: oneArgBlock [
	^ graph
		newOperation: aString
		named: name
		described: [ :description | 
			description addInput: self firstOutput.
			aTFOperationArray
				do: [ :each | 
					| input |
					input := (each asOperationOn: graph) firstOutput.
					description addInput: input ].
			oneArgBlock value: description ]
]

{ #category : 'accessing' }
TFOperation >> output: indexInteger [
	^ TFOutput onOperation: self index: indexInteger
]

{ #category : 'accessing' }
TFOperation >> outputsCount [
	^ self library operationNumOutputs: self
]

{ #category : 'printing' }
TFOperation >> printOn: strm [
	super printOn: strm.
	self isNull
		ifFalse: [ strm
				space;
				print: self type;
				space;
				print: self name ]

]

{ #category : 'ops unary' }
TFOperation >> rectified [
	^ self unaryOp: 'Relu'
]

{ #category : 'ops unary' }
TFOperation >> shape [
	^ self unaryOp: 'Shape'
]

{ #category : 'attributes' }
TFOperation >> shapeAt: nameString [
	| value status size answer |
	size := (self attrMetadata: nameString) totalSize.
	status := TFStatus create.
	value := Int64Array externalNew: size.
	self library
		operation: self
		attr: nameString asAsciiZ
		getShape: value
		size: size
		status: status.
	status check.
	answer := (1 to: size) collect: [ :i | value at: i ].
	^ answer asTensorShape
]

{ #category : 'ops unary' }
TFOperation >> sigmoid [
	^ self unaryOp: 'Sigmoid'
]

{ #category : 'ops unary' }
TFOperation >> sin [
	^ self unaryOp: 'Sin'
]

{ #category : 'ops binary' }
TFOperation >> sizeOn: dimensionInteger [
	^ self shape
		sliceFrom:
			((Array new: 1)
				at: 1 put: dimensionInteger;
				yourself) asInt32Tensor
		size: #(1) asInt32Tensor
]

{ #category : 'ops other' }
TFOperation >> sliceFrom: begin size: size [
	^ self
		op: 'Slice'
		withAll:
			((Array new: 2)
				at: 1 put: begin;
				at: 2 put: size;
				yourself)
]

{ #category : 'ops unary' }
TFOperation >> softmax [
	^ self unaryOp: 'Softmax'
]

{ #category : 'ops binary' }
TFOperation >> sparseSoftmaxCrossEntropyWithLogits: aTFOperation [
	^ self
		binaryOp: 'SparseSoftmaxCrossEntropyWithLogits'
		with: aTFOperation
		named: (self nameFor: 'SparseSoftmaxCrossEntropyWithLogits')
]

{ #category : 'ops unary' }
TFOperation >> squared [
	^ self @* self
]

{ #category : 'attributes' }
TFOperation >> stringAt: nameString [
	| metadata value status |
	metadata := self attrMetadata: nameString.
	status := TFStatus create.
	value := ByteArray new: metadata totalSize.
	self library
		operation: self
		attr: nameString asAsciiZ
		getString: value
		size: metadata totalSize
		status: status.
	status check.
	^ (value copyUpTo: 0) asString 
]

{ #category : 'attributes' }
TFOperation >> stringsAt: nameString [
	| status pointers sizes spaceRequired storage metadata valuesCount |
	metadata := self attrMetadata: nameString.
	spaceRequired := metadata totalSize.
	valuesCount := metadata listSize.
	pointers := ByteArray new: ExternalWordArray fixedSize * valuesCount.
	sizes := (Int64Array externalNew: valuesCount) useFinalization.
	storage := OSPtr calloc: spaceRequired.
	status := TFStatus create.
	self library
		operation: self
		attr: nameString asAsciiZ
		getStrings: pointers
		sizes: sizes
		maxCount: valuesCount
		storage: storage
		size: spaceRequired
		status: status.
	status check.
	^ (1 to: valuesCount)
		collect: [ :i | 
			| one |
			one := pointers pointerAt: (i - 1) * ExternalWordArray fixedSize.
			one := (OSPtr address: one) memcpyStringFrom: 0 to: (sizes at: i) - 1]
]

{ #category : 'ops binary' }
TFOperation >> sumOn: aTFOperation [
	^ self binaryOp: 'Sum' with: aTFOperation
]

{ #category : 'ops unary' }
TFOperation >> tan [
	^ self unaryOp: 'Tan'
]

{ #category : 'attributes' }
TFOperation >> tensorAt: nameString [
	| value status |
	status := TFStatus create.
	value := ByteArray new: ExternalWordArray fixedSize.
	self library
		operation: self
		attr: nameString asAsciiZ
		getTensor: value
		status: status.
	status check.
	^ TFTensor address: (value pointerAt: 0)
]

{ #category : 'ops binary' }
TFOperation >> timesRectifiedGradOf: aTFOperation [
	^ self binaryOp: 'ReluGrad' with: aTFOperation
]

{ #category : 'accessing' }
TFOperation >> type [
	^ self library operationOpType: self
]

{ #category : 'attributes' }
TFOperation >> typeAt: nameString [
	| value status |
	status := TFStatus create.
	value := TFStructure new: 8.
	self library
		operation: self
		attr: nameString asAsciiZ
		getType: value
		status: status.
	status check.
	^ value uint64At: 0
]

{ #category : 'ops unary' }
TFOperation >> unaryOp: aString [
	| name |
	name := self nameFor: aString.
	^ self unaryOp: aString named: name
]

{ #category : 'ops unary' }
TFOperation >> unaryOp: aString described: oneArgBlock [
	| name |
	name := self nameFor: aString.
	^ self unaryOp: aString named: name described: oneArgBlock
]

{ #category : 'ops unary' }
TFOperation >> unaryOp: aString named: name [
	^ self unaryOp: aString named: name described: [ :description |  ]
]

{ #category : 'ops unary' }
TFOperation >> unaryOp: aString named: name described: oneArgBlock [
	^ self
		op: aString
		withAll:
			((Array new: 0)
				yourself)
		named: name
		described: oneArgBlock
]

{ #category : 'accessing' }
TFOperation >> useOutput: anInteger [
	output := anInteger
]
