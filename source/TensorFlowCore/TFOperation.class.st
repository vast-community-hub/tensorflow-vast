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

{ #category : 'converting' }
TFOperation >> asOperationOn: aTFGraph [
	graph == aTFGraph
		ifTrue: [ ^ self ]
		ifFalse: [ ^ Error signal: 'Can''t move an operation to another Graph' ]
		
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

{ #category : 'accessing' }
TFOperation >> device [
	^ self library operationDevice: self
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

{ #category : 'accessing' }
TFOperation >> name [
	^ self library operationName: self
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

{ #category : 'accessing' }
TFOperation >> useOutput: anInteger [
	output := anInteger
]
