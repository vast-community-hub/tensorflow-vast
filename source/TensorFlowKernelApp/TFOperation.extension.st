Extension {
	#name : 'TFOperation'
}

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFOperation class >> new [

	^super new initialize
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops binary'] }
TFOperation >> * aTFOperation [
	^ self binaryOp: 'MatMul' with: aTFOperation
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops binary'] }
TFOperation >> *\ aTFOperation [
	^ self
		binaryOp: 'MatMul'
		with: aTFOperation
		described: [ :description | description at: 'transpose_b' putBoolean: true ]
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops binary'] }
TFOperation >> + aTFOperation [
	^ self binaryOp: 'Add' with: aTFOperation
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops binary'] }
TFOperation >> - aTFOperation [
	^ self binaryOp: 'Sub' with: aTFOperation
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops binary'] }
TFOperation >> -= aTFOperation [
	^ self binaryOp: 'AssignSub' with: aTFOperation
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops binary'] }
TFOperation >> > aTFOperation [
	^ self binaryOp: 'Greater' with: aTFOperation
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops binary'] }
TFOperation >> @* aTFOperation [
	^ self binaryOp: 'Mul' with: aTFOperation
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops binary'] }
TFOperation >> @/ aTFOperation [
	^ self binaryOp: 'Div' with: aTFOperation
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops binary'] }
TFOperation >> \* aTFOperation [
	^ self
		binaryOp: 'MatMul'
		with: aTFOperation
		described: [ :description | description at: 'transpose_a' putBoolean: true ]
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops binary'] }
TFOperation >> \\ aTFOperation [
	^ self binaryOp: 'Mod' with: aTFOperation
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops unary'] }
TFOperation >> abs [
	^ self unaryOp: 'Abs'
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops unary'] }
TFOperation >> alias: nameString [
	^ self unaryOp: 'Identity' named: nameString
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops unary'] }
TFOperation >> arcCos [
	^ self unaryOp: 'Acos'
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops unary'] }
TFOperation >> arcSin [
	^ self unaryOp: 'Asin'
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops unary'] }
TFOperation >> arcTan [
	^ self unaryOp: 'Atan'
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['converting'] }
TFOperation >> asOperationOn: aTFGraph [
	graph == aTFGraph
		ifTrue: [ ^ self ]
		ifFalse: [ ^ Error signal: 'Can''t move an operation to another Graph' ]
		
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops binary'] }
TFOperation >> assign: aTFOperation [
	^ self
		binaryOp: 'Assign'
		with: aTFOperation
		named: self name , '_initializer'
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['attributes'] }
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

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops binary'] }
TFOperation >> binaryOp: aString with: aTFOperation [
	^ self
		binaryOp: aString
		with: aTFOperation
		described: [ :nothing |  ]
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops binary'] }
TFOperation >> binaryOp: aString with: aTFOperation described: oneArgBlock [
	| name |
	name := self nameFor: aString.
	^ self
		binaryOp: aString
		with: aTFOperation
		named: name
		described: oneArgBlock
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops binary'] }
TFOperation >> binaryOp: aString with: aTFOperation named: name [
	^ self
		binaryOp: aString
		with: aTFOperation
		named: name
		described: [ :nothing |  ]
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops binary'] }
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

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['attributes'] }
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

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops binary'] }
TFOperation >> castTo: typeInteger [
	^ self
		unaryOp: 'Cast'
		described: [ :description | description at: 'DstT' putType: typeInteger ]
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops unary'] }
TFOperation >> cos [
	^ self unaryOp: 'Cos'
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops other'] }
TFOperation >> descent: delta rate: learningRate [
	^ self
		op: 'ApplyGradientDescent'
		withAll:
			((Array new: 2)
				at: 1 put: learningRate;
				at: 2 put: delta;
				yourself)
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFOperation >> device [
	^ self library operationDevice: self
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops unary'] }
TFOperation >> exp [
	^ self unaryOp: 'Exp'
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops binary'] }
TFOperation >> findMaxOn: aTFOperation [
	^ self binaryOp: 'ArgMax' with: aTFOperation
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops binary'] }
TFOperation >> findMinOn: aTFOperation [
	^ self binaryOp: 'ArgMin' with: aTFOperation
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFOperation >> firstInput [
	^ self input: 0
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['initialization'] }
TFOperation >> firstOutput [
	output ifNil: [ output := 0 ].
	^ self output: output
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['attributes'] }
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

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFOperation >> graph [
	^ graph
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFOperation >> graph: aTFGraph [
	graph := aTFGraph
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops unary'] }
TFOperation >> identity [
	^ self unaryOp: 'Identity'
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFOperation >> input: indexInteger [
	^ TFInput onOperation: self index: indexInteger
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFOperation >> inputsCount [

	^self library operationNumInputs: self
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['attributes'] }
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

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops unary'] }
TFOperation >> inverse [
	^ self unaryOp: 'MatrixInverse'
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops binary'] }
TFOperation >> meanOn: shapeTensorOrOperation [
	^ self binaryOp: 'Mean' with: shapeTensorOrOperation
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFOperation >> name [
	^ self library operationName: self
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops other'] }
TFOperation >> nameFor: namePrefix [
	^ graph nameFor: namePrefix
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops unary'] }
TFOperation >> negated [
	^ self unaryOp: 'Neg'
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops other'] }
TFOperation >> op: aString withAll: aTFOperationArray [
	^ self
		op: aString
		withAll: aTFOperationArray
		described: [ :nothing |  ]
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops other'] }
TFOperation >> op: aString withAll: aTFOperationArray described: oneArgBlock [
	| name |
	name := self nameFor: aString.
	^ self
		op: aString
		withAll: aTFOperationArray
		named: name
		described: oneArgBlock
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops other'] }
TFOperation >> op: aString withAll: aTFOperationArray named: name [
	^ self
		op: aString
		withAll: aTFOperationArray
		named: name
		described: [ :nothing |  ]
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops other'] }
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

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFOperation >> output: indexInteger [
	^ TFOutput onOperation: self index: indexInteger
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFOperation >> outputsCount [
	^ self library operationNumOutputs: self
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['printing'] }
TFOperation >> printOn: strm [
	super printOn: strm.
	self isNull
		ifFalse: [ strm
				space;
				print: self type;
				space;
				print: self name ]

]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops unary'] }
TFOperation >> rectified [
	^ self unaryOp: 'Relu'
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops unary'] }
TFOperation >> shape [
	^ self unaryOp: 'Shape'
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['attributes'] }
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
	^ answer
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops unary'] }
TFOperation >> sigmoid [
	^ self unaryOp: 'Sigmoid'
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops unary'] }
TFOperation >> sin [
	^ self unaryOp: 'Sin'
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops binary'] }
TFOperation >> sizeOn: dimensionInteger [
	^ self shape
		sliceFrom:
			((Array new: 1)
				at: 1 put: dimensionInteger;
				yourself) asInt32Tensor
		size: #(1) asInt32Tensor
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops other'] }
TFOperation >> sliceFrom: begin size: size [
	^ self
		op: 'Slice'
		withAll:
			((Array new: 2)
				at: 1 put: begin;
				at: 2 put: size;
				yourself)
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops unary'] }
TFOperation >> softmax [
	^ self unaryOp: 'Softmax'
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops binary'] }
TFOperation >> sparseSoftmaxCrossEntropyWithLogits: aTFOperation [
	^ self
		binaryOp: 'SparseSoftmaxCrossEntropyWithLogits'
		with: aTFOperation
		named: (self nameFor: 'SparseSoftmaxCrossEntropyWithLogits')
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops unary'] }
TFOperation >> squared [
	^ self @* self
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['attributes'] }
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

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['attributes'] }
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

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops binary'] }
TFOperation >> sumOn: aTFOperation [
	^ self binaryOp: 'Sum' with: aTFOperation
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops unary'] }
TFOperation >> tan [
	^ self unaryOp: 'Tan'
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['attributes'] }
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

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops binary'] }
TFOperation >> timesRectifiedGradOf: aTFOperation [
	^ self binaryOp: 'ReluGrad' with: aTFOperation
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFOperation >> type [
	^ self library operationOpType: self
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['attributes'] }
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

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops unary'] }
TFOperation >> unaryOp: aString [
	| name |
	name := self nameFor: aString.
	^ self unaryOp: aString named: name
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops unary'] }
TFOperation >> unaryOp: aString described: oneArgBlock [
	| name |
	name := self nameFor: aString.
	^ self unaryOp: aString named: name described: oneArgBlock
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops unary'] }
TFOperation >> unaryOp: aString named: name [
	^ self unaryOp: aString named: name described: [ :description |  ]
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['ops unary'] }
TFOperation >> unaryOp: aString named: name described: oneArgBlock [
	^ self
		op: aString
		withAll:
			((Array new: 0)
				yourself)
		named: name
		described: oneArgBlock
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFOperation >> useOutput: anInteger [
	output := anInteger
]
