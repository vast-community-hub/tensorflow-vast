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

{ #category : 'attributes' }
TFOperation >> attrMetadata: nameString [

	^self library operation: self getMetadataFor: nameString asAsciiZ
]

{ #category : 'attributes' }
TFOperation >> boolAt: nameString [

	^self library operation: self getBoolAt: nameString asAsciiZ
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

	^self library operation: self getFloatAt: nameString asAsciiZ
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

	^self library operation: self getInt64At: nameString asAsciiZ
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

	^self library operation: self getShapeAt: nameString asAsciiZ
]

{ #category : 'attributes' }
TFOperation >> stringAt: nameString [

	^self library operation: self getStringAt: nameString asAsciiZ
]

{ #category : 'attributes' }
TFOperation >> stringsAt: nameString [

	^self library operation: self getStringsAt: nameString asAsciiZ
]

{ #category : 'attributes' }
TFOperation >> tensorAt: nameString [

	^self library operation: self getTensorAt: nameString asAsciiZ
]

{ #category : 'accessing' }
TFOperation >> type [
	^ self library operationOpType: self
]

{ #category : 'attributes' }
TFOperation >> typeAt: nameString [

	^self library operation: self getTypeAt: nameString asAsciiZ
]

{ #category : 'accessing' }
TFOperation >> useOutput: anInteger [
	output := anInteger
]
