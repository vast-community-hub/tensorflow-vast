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
		ifTrue: [^self]
		ifFalse: [^Error signal: 'Can''t move an operation to another Graph']
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
"The name of the device to which this op has been assigned, if any.
Returns: The string name of the device to which this op has been assigned, or an empty string if it has not been assigned to a device."
	^ self library deviceNameContaining: self
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
	"The Graph that contains this operation"
	
	^ graph
]

{ #category : 'accessing' }
TFOperation >> graph: aTFGraph [
	graph := aTFGraph
]

{ #category : 'accessing' }
TFOperation >> input: anInteger [
	"Return input at position anInteger"
	
	^ TFInput onOperation: self index: anInteger
]

{ #category : 'accessing' }
TFOperation >> inputsCount [
	"Returns number of inputs of this operation"
	
	^ self library operationNumInputs: self
]

{ #category : 'attributes' }
TFOperation >> intAt: nameString [

	^self library operation: self getInt64At: nameString asAsciiZ
]

{ #category : 'accessing' }
TFOperation >> name [
	"The full name of this operation"
	
	^ self library operationName: self
]

{ #category : 'accessing' }
TFOperation >> output: anInteger [
	"Return output at position anInteger"
	
	^ TFOutput onOperation: self index: anInteger
]

{ #category : 'accessing' }
TFOperation >> outputsCount [
	"Returns number of inputs of this operation"
	
	^ self library operationNumOutputs: self
]

{ #category : 'printing' }
TFOperation >> printOn: stream [
	super printOn: stream.
	self isNull
		ifFalse: [ stream
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
	"The type of the op (e.g. MatMul)"

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
