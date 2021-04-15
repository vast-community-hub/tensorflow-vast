Class {
	#name : 'TFGraph',
	#superclass : 'TFStructure',
	#instVars : [
		'context'
	],
	#category : 'TensorFlowCore'
}

{ #category : 'instance creation' }
TFGraph class >> create [
	^ TensorFlowCAPI current newGraph initialize useFinalization
]

{ #category : 'instance creation' }
TFGraph class >> fromBlock: aBlockClosure [
	| output graph |
	graph := self create.
	output := graph fromBlock: aBlockClosure.
	output alias: 'output'.
	^ graph
]

{ #category : 'instance creation' }
TFGraph class >> fromFileNamed: aString [
	^ self create importFileNamed: aString
]

{ #category : 'instance creation' }
TFGraph class >> fromString: aString [
	^ self create importString: aString
]

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFGraph class >> initializeAfterLoad [
	"Set an opaque layout."

	self initializeOpaqueLayout
]

{ #category : 'instance creation' }
TFGraph class >> new [

	^super new initialize
]

{ #category : 'operations' }
TFGraph >> add: nameString described: aBlock [
	^ self newOperation: 'Add' named: nameString described: aBlock
]

{ #category : 'accessing' }
TFGraph >> allInitializers [
	^ self
		operationsSelect: [ :op | op type = 'Assign' and: [ op name endsWith: '_initializer' ] ]
]

{ #category : 'accessing' }
TFGraph >> allInputs [
	^ self operationsSelect: [ :op | op type = 'Placeholder' ]
]

{ #category : 'accessing' }
TFGraph >> allOperations [
	^ self operationsSelect: [ :op | true ]
]

{ #category : 'accessing' }
TFGraph >> allVariables [
	^ self operationsSelect: [ :op | op type = 'Variable' ]
]

{ #category : 'operations' }
TFGraph >> asString: nameString described: aBlock [
	^ self newOperation: 'AsString' named: nameString described: aBlock
]

{ #category : 'initialize-release' }
TFGraph >> basicDelete [
	^ self library deleteGraph: self
]

{ #category : 'operations' }
TFGraph >> concat: nameString described: aBlock [
	^ self newOperation: 'Concat' named: nameString described: aBlock
]

{ #category : 'root operations' }
TFGraph >> const: aTFTensor [
	| name |
	name := self nameFor: 'constant'.
	^ self const: name value: aTFTensor
]

{ #category : 'root operations' }
TFGraph >> const: nameString value: aTFTensor [
	^ self
		newOperation: 'Const'
		named: nameString
		described: [ :description | 
			description at: 'dtype' putType: aTFTensor type.
			description at: 'value' putTensor: aTFTensor ]
]

{ #category : 'root operations' }
TFGraph >> constShaped: aShape filledWith: aTensor [

	| shape |

	shape := self const: aShape asInt32Tensor.
	^shape binaryOp: 'Fill' with: aTensor
]

{ #category : 'accessing' }
TFGraph >> definition [
	| buffer status |
	status := TFStatus create.
	buffer := TFBuffer new.
	self library graph: self toGraphDef: buffer status: status.
	status check.
	^ buffer dataBytes asString
]

{ #category : 'initialize-release' }
TFGraph >> fromBlock: aBlockClosure [
	| types |
	types := Array new: aBlockClosure argumentCount.
	types atAllPut: TFTensor typeFloat.
	^ self fromBlock: aBlockClosure inputTypes: types
]

{ #category : 'initialize-release' }
TFGraph >> fromBlock: aBlockClosure inputTypes: anArray [
	| inputs index |
	index := 0.
	inputs := (1 to: aBlockClosure argumentCount)
		collect: [ :each | 
			index := index + 1.
			self inputType: (anArray at: index) ].
	^ aBlockClosure valueWithArguments: inputs
]

{ #category : 'initialize-release' }
TFGraph >> fromBlock: aBlockClosure inputTypes: anArray named: nameString [

	| answer |

	self
		inScopeNamed: nameString
		do: [answer := self fromBlock: aBlockClosure inputTypes: anArray].
	^answer
]

{ #category : 'initialize-release' }
TFGraph >> fromBlock: aBlockClosure named: nameString [
	| types |
	types := Array new: aBlockClosure argumentCount.
	types atAllPut: TFTensor typeFloat.
	^ self fromBlock: aBlockClosure inputTypes: types named: nameString
]

{ #category : 'gradients' }
TFGraph >> gradientsOf: yArrayOfTFOutput withRespectTo: xArrayOfTFOutput [

	^self gradientsOf: yArrayOfTFOutput withRespectTo: xArrayOfTFOutput product: nil
]

{ #category : 'gradients' }
TFGraph >> gradientsOf: yArrayOfTFOutput withRespectTo: xArrayOfTFOutput product: dxArrayOfOutput [

	| y x dx status dy |

	y := TFOutputArray externalFromArray: yArrayOfTFOutput.
	x := TFOutputArray externalFromArray: xArrayOfTFOutput.
	dx := dxArrayOfOutput ifNil: [nil] ifNotNil: [TFOutputArray externalFromArray: dxArrayOfOutput].
	dy := TFOutputArray new: xArrayOfTFOutput size.
	status := TFStatus create.
	self library
		graph: self
		y: y
		yCount: yArrayOfTFOutput size
		x: x
		xCount: xArrayOfTFOutput size
		dx: dx
		status: status
		into: dy.
	status check.
	^dy
]

{ #category : 'initialize-release' }
TFGraph >> import: aTFBuffer [
	| options status |
	status := TFStatus create.
	options := TFImportGraphDefOptions create.
	self library
		importGraphDefInto: self
		from: aTFBuffer
		options: options
		status: status.
	options delete.
	status check
]

{ #category : 'initialize-release' }
TFGraph >> importFileNamed: aString [
	| buffer |
	buffer := TFBuffer fromFileNamed: aString.
	[ self import: buffer ]
		ensure: [ buffer delete ]
]

{ #category : 'initialize-release' }
TFGraph >> importString: aString [
	| buffer |
	buffer := TFBuffer fromString: aString.
	[ self import: buffer ]
		ensure: [ buffer delete ]
]

{ #category : 'initialize-release' }
TFGraph >> initialize [
	context := ''
]

{ #category : 'running' }
TFGraph >> initializeOn: aTFSession [
	| initializers |
	initializers := self allInitializers
		collect: [ :each | each output: 0 ].
	initializers size > 0
		ifTrue: [ aTFSession runOutputs: initializers ]
]

{ #category : 'root operations' }
TFGraph >> inputType: typeInteger [
	^ self
		newOperation: 'Placeholder'
		named: (self nameFor: 'input')
		described: [ :description | description at: 'dtype' putType: typeInteger ]
]

{ #category : 'initialize-release' }
TFGraph >> inScopeNamed: aName do: aBlock [

	| previousContext |

	previousContext := context.
	context := context , aName , '/'.
	^aBlock ensure: [context := previousContext]
]

{ #category : 'operations' }
TFGraph >> mul: nameString described: aBlock [
	^ self newOperation: 'Mul' named: nameString described: aBlock
]

{ #category : 'root operations' }
TFGraph >> nameFor: aNodeName [

	| preffix count |

	preffix := context , aNodeName.
	count := (self operationsSelect: [:op | op name beginsWithSubCollection: preffix]) size.
	count strictlyPositive ifTrue: [preffix := preffix , '_' , count printString].
	^preffix
]

{ #category : 'operations' }
TFGraph >> newOperation: typeString named: aString [
	^ self
		newOperation: typeString
		named: aString
		described: [ :unused |  ]
]

{ #category : 'operations' }
TFGraph >> newOperation: typeString named: aString described: aBlock [
	| description answer |
	description := self
		newOperationDescription: typeString
		named: aString.
	aBlock value: description.
	answer := description finish.
	answer graph: self.
	^ answer
]

{ #category : 'operations' }
TFGraph >> newOperationDescription: typeString named: aString [
	^ self library
		newOperationDescriptionOn: self
		type: typeString
		named: aString
]

{ #category : 'accessing' }
TFGraph >> newOperationIteratorContext [
	^ ByteArray new: 8
]

{ #category : 'root operations' }
TFGraph >> onesShaped: aShape [

	^self constShaped: aShape filledWith: 1.0 asTensor
]

{ #category : 'accessing' }
TFGraph >> operationAt: contextULongLongPtr [
	^ self library graph: self operationAt: contextULongLongPtr
]

{ #category : 'accessing' }
TFGraph >> operationNamed: aString [
	| answer |
	answer := self library
		graph: self
		getOperationNamed: aString asAsciiZ.
	answer isNull
		ifTrue: [ Error signal: 'Operation not found' ].
	^ answer
]

{ #category : 'accessing' }
TFGraph >> operationNamed: aString ifFound: aFoundBlock ifNotFound: aNotFoundBlock [

	| answer |

	answer := self library graph: self getOperationNamed: aString asAsciiZ.
	^answer isNull ifTrue: aNotFoundBlock ifFalse: [aFoundBlock cull: answer]
]

{ #category : 'accessing' }
TFGraph >> operationsCount [
	| answer |
	answer := 0.
	self operationsDo: [ :each | answer := answer + 1 ].
	^ answer
]

{ #category : 'accessing' }
TFGraph >> operationsDo: oneArgBlock [
	| iterator operation |
	iterator := self newOperationIteratorContext.
	[ operation := self operationAt: iterator.
	operation isNull ] whileFalse: [ oneArgBlock value: operation ]
]

{ #category : 'accessing' }
TFGraph >> operationsSelect: oneArgBlock [
	| answer |
	answer := OrderedCollection new.
	self operationsSelect: oneArgBlock thenDo: [ :op | answer add: op ].
	^ answer asArray
]

{ #category : 'accessing' }
TFGraph >> operationsSelect: conditionBlock thenDo: actionBlock [
	| answer |
	answer := OrderedCollection new.
	self
		operationsDo: [ :op | 
			(conditionBlock value: op)
				ifTrue: [ actionBlock value: op ] ].
	^ answer asArray
]

{ #category : 'outputs' }
TFGraph >> outputDimensionsCount: aTFOutput [
	| status answer |
	status := TFStatus create.
	answer := self library
		forGraph: self
		outputDims: aTFOutput
		status: status.
	status check.
	^ answer
]

{ #category : 'root operations' }
TFGraph >> placeholder: nameString type: typeInteger [
	^ self
		newOperation: 'Placeholder'
		named: nameString
		described: [ :description | description at: 'dtype' putType: typeInteger ]
]

{ #category : 'outputs' }
TFGraph >> rankOf: aTFOutputOrInput [
	| status answer |
	status := TFStatus create.
	answer := self library
		graph: self
		getRankOf: aTFOutputOrInput
		status: status.
	status check.
	^ answer
]

{ #category : 'running' }
TFGraph >> runInputs: inArrayOfTFOutputs values: inArrayOfTFTensor outputs: outArrayOfTFOutputs [
	| session |
	session := TFSession on: self.
	self initializeOn: session.
	^ session
		runInputs: inArrayOfTFOutputs
		values: inArrayOfTFTensor
		outputs: outArrayOfTFOutputs
]

{ #category : 'running' }
TFGraph >> runOutput: aTFOutput [
	| session |
	session := TFSession on: self.
	self initializeOn: session.
	^ session runOutput: aTFOutput
]

{ #category : 'running' }
TFGraph >> runOutputs: anArrayOfTFOutputs [
	| session |
	session := TFSession on: self.
	self initializeOn: session.
	^ session runOutputs: anArrayOfTFOutputs
]

{ #category : 'outputs' }
TFGraph >> shapeOf: aTFOutputOrInput [
	| status value size answer |
	size := self rankOf: aTFOutputOrInput.
	value := Int64Array externalNew: size.
	status := TFStatus create.
	self library
		graph: self
		getShapeOf: aTFOutputOrInput
		into: value
		size: size
		status: status.
	status check.
	answer := (1 to: size) collect: [ :i | value at: i ].
	^ answer asTensorShape
]

{ #category : 'outputs' }
TFGraph >> shapeOf: aTFOutputOrInput set: shape [
	| status value |
	value := Int64Array externalFromArray: shape.
	status := TFStatus create.
	self library
		graph: self
		setShapeOf: aTFOutputOrInput
		to: value
		size: shape size
		status: status.
	status check
]

{ #category : 'root operations' }
TFGraph >> statelessNormalRandomShaped: shapeArray withSeeds: aSeedsArray [

	| shape seeds |

	shape := self const: shapeArray asInt32Tensor.
	seeds := self const: aSeedsArray asInt32Tensor.
	^shape
		binaryOp: 'StatelessTruncatedNormal'
		with: seeds
		described: [:description | description at: 'dtype' putType: TFTensor typeFloat]
]

{ #category : 'root operations' }
TFGraph >> truncatedNormalRandomShaped: shapeArray [
	| shape |
	shape := self const: shapeArray asInt32Tensor.
	^ shape
		unaryOp: 'TruncatedNormal'
		described: [ :description | description at: 'dtype' putType: TFTensor typeFloat ]
]

{ #category : 'root operations' }
TFGraph >> truncatedNormalRandomShaped: shapeArray stddev: aNumber [
	| random |
	random := self truncatedNormalRandomShaped: shapeArray.
	^ random @* (self const: aNumber asTensor)
]

{ #category : 'root operations' }
TFGraph >> variable: nameString forTensor: aTFTensor [
	^ self
		variable: nameString
		type: aTFTensor type
		shape: aTFTensor shape
]

{ #category : 'root operations' }
TFGraph >> variable: nameString initialValue: aTFTensor [
	| const var |
	var := self variable: nameString forTensor: aTFTensor.
	const := self const: nameString , '_initialValue' value: aTFTensor.
	var assign: const.
	^ var
]

{ #category : 'root operations' }
TFGraph >> variable: nameString initialValueFrom: aTFOperation [
	| output var shape |
	output := aTFOperation output: 0.
	shape := self shapeOf: output.
	var := self variable: nameString type: output type shape: shape.
	var assign: aTFOperation.
	^ var
]

{ #category : 'root operations' }
TFGraph >> variable: nameString type: typeInteger shape: anArray [
	^ self
		newOperation: 'Variable'
		named: nameString
		described: [ :description | 
			description
				at: 'dtype' putType: typeInteger;
				at: 'shape' putShape: anArray asTensorShape ]
]

{ #category : 'debugging' }
TFGraph >> writeDefTo: strm [
	strm nextPutAll: self definition
]

{ #category : 'debugging' }
TFGraph >> writeDefToFileNamed: filename [
	filename asPath writeStreamDo: [ :strm | self writeDefTo: strm ]
]

{ #category : 'root operations' }
TFGraph >> zerosShaped: aShape [

	^self constShaped: aShape filledWith: 0.0 asTensor
]
