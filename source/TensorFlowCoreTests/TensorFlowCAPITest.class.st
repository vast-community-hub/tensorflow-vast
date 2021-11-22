Class {
	#name : 'TensorFlowCAPITest',
	#superclass : 'TensorFlowTestCase',
	#instVars : [
		'library'
	],
	#category : 'TensorFlowCoreTests'
}

{ #category : 'graphs',
  #vaVisibility : 'private' }
TensorFlowCAPITest >> addGraphTwoInputsInt64 [
	"| graph in1 in2 |
	graph := TFGraph create.
	in1 := graph placeholder: 'in1' type: TFTensor typeInt64.
	in2 := graph placeholder: 'in2' type: TFTensor typeInt64.
	graph
		add: 'add'
		described: [ :description | 
			description addInput: (in1 output: 0).
			description addInput: (in2 output: 0) ].
	^ graph"

	^TFGraph fromString:
		#[10 46 10 3 105 110 49 18 11 80 108 97 99 101 104 111 108 100 101 114 42 13 10 5 115 104 97
		112 101 18 4 58 2 24 1 42 11 10 5 100 116 121 112 101 18 2 48 9 10 46 10 3 105 110 50 18 11
		80 108 97 99 101 104 111 108 100 101 114 42 13 10 5 115 104 97 112 101 18 4 58 2 24 1 42 11
		10 5 100 116 121 112 101 18 2 48 9 10 29 10 3 97 100 100 18 3 65 100 100 26 3 105 110 49 26 3
		105 110 50 42 7 10 1 84 18 2 48 9 18 0 34 3 8 184 3]
			asString
]

{ #category : 'test support',
  #vaVisibility : 'private' }
TensorFlowCAPITest >> assertElementsOf: tensorArray are: allElementsArray [

	self
		assert: allElementsArray
		equals: (
			Array
				new: tensorArray singleElementsInCollection
				streamContents: [:stream |
					tensorArray singleElementsDo: [:each | stream nextPut: each]])
]

{ #category : 'testing tensor',
  #vaVisibility : 'private' }
TensorFlowCAPITest >> assertRankOf: aMultidimensionalTensor is: anInteger [

	| rank |

	rank := aMultidimensionalTensor inferTensorRank.
	self
		assert: rank = anInteger
		description:
			'The rank is ' , rank printString , ' and should have been ' , anInteger printString
]

{ #category : 'testing tensor',
  #vaVisibility : 'private' }
TensorFlowCAPITest >> assertShapeOf: aMultidimensionalTensor is: anArray [

	| shape |

	shape := aMultidimensionalTensor inferTensorShape.
	self
		assert: shape = anArray
		description:
			'The shape is ' , shape printString , ' and should have been ' , anArray printString
]

{ #category : 'testing tensor',
  #vaVisibility : 'private' }
TensorFlowCAPITest >> assertSizeOf: aMultidimensionalTensor is: anInteger [

	| size |

	size := aMultidimensionalTensor singleElementsInCollection.
	self
		assert: size = anInteger
		description:
			'The size is ' , size printString , ' and should have been ' , anInteger printString
]

{ #category : 'testing tensor',
  #vaVisibility : 'private' }
TensorFlowCAPITest >> assertTensor: aTFTensor elementsEquals: tensorArray [
	self assert: aTFTensor allElements equals: tensorArray
]

{ #category : 'testing tensor',
  #vaVisibility : 'private' }
TensorFlowCAPITest >> assertTensor: aTFTensor streamEquals: tensorArray [
	| strm |
	strm := aTFTensor asStream.
	tensorArray do: [ :each | self assert: each equals: strm next ]
]

{ #category : 'testing strings',
  #vaVisibility : 'private' }
TensorFlowCAPITest >> assertTensorFromStrings: strings shape: shape [
	| tensor |
	tensor := TFTensor fromStrings: strings shape: shape asTensorShape.
	self assert: shape asTensorShape equals: tensor shape.
	self assert: strings equals: tensor allStrings
]

{ #category : 'graphs',
  #vaVisibility : 'private' }
TensorFlowCAPITest >> constant2x2FloatGraphDef [
	" This GraphDef corresponds to simple Graph, defined as
	
		a = tf.constant([[-1.1, -2.1],[-1.2,-2.2]], name='a')
		
	 saved as ProtoBuf "

	^ #[16r0A 16r42 16r0A 16r01 16r61 16r12 16r05 16r43 16r6F 16r6E 16r73 16r74 16r2A 16r29 16r0A 16r05 16r76 16r61 16r6C 16r75 16r65 16r12 16r20 16r42 16r1E 16r08 16r01 16r12 16r08 16r12 16r02 16r08 16r02 16r12 16r02 16r08 16r02 16r22 16r10 16rCD 16rCC 16r8C 16rBF 16r66 16r66 16r06 16rC0 16r9A 16r99 16r99 16rBF 16rCD 16rCC 16r0C 16rC0 16r2A 16r0B 16r0A 16r05 16r64 16r74 16r79 16r70 16r65 16r12 16r02 16r30 16r01 16r0A 16r0C 16r0A 16r04 16r69 16r6E 16r69 16r74 16r12 16r04 16r4E 16r6F 16r4F 16r70 16r22 16r02 16r08 16r11]
		asString
]

{ #category : 'graphs',
  #vaVisibility : 'private' }
TensorFlowCAPITest >> constant2x2FloatGraphFromDef [
	^ TFGraph fromString: self constant2x2FloatGraphDef
]

{ #category : 'graphs',
  #vaVisibility : 'private' }
TensorFlowCAPITest >> constantFloatGraphDef [
	" This GraphDef corresponds to simple Graph, defined as
	
		tf.constant(0.42, name='a')
		
	 saved as ProtoBuf "

	^ #[16r0A 16r2E 16r0A 16r01 16r61 16r12 16r05 16r43 16r6F 16r6E 16r73 16r74 16r2A 16r15 16r0A 16r05 16r76 16r61 16r6C 16r75 16r65 16r12 16r0C 16r42 16r0A 16r08 16r01 16r12 16r00 16r2A 16r04 16r3D 16r0A 16rD7 16r3E 16r2A 16r0B 16r0A 16r05 16r64 16r74 16r79 16r70 16r65 16r12 16r02 16r30 16r01 16r0A 16r0C 16r0A 16r04 16r69 16r6E 16r69 16r74 16r12 16r04 16r4E 16r6F 16r4F 16r70 16r22 16r02 16r08 16r0F]
		asString
]

{ #category : 'graphs',
  #vaVisibility : 'private' }
TensorFlowCAPITest >> constantFloatGraphFromDef [
	^ TFGraph fromString: self constantFloatGraphDef
]

{ #category : 'graphs',
  #vaVisibility : 'private' }
TensorFlowCAPITest >> constantInt32GraphDef [
	" This GraphDef corresponds to simple Graph, defined as
	
		tf.constant(0.42, name='a')
		
	 saved as ProtoBuf "

	^ #[16r0A 16r2B 16r0A 16r01 16r61 16r12 16r05 16r43 16r6F 16r6E 16r73 16r74 16r2A 16r12 16r0A 16r05 16r76 16r61 16r6C 16r75 16r65 16r12 16r09 16r42 16r07 16r08 16r03 16r12 16r00 16r3A 16r01 16r2A 16r2A 16r0B 16r0A 16r05 16r64 16r74 16r79 16r70 16r65 16r12 16r02 16r30 16r03 16r0A 16r0C 16r0A 16r04 16r69 16r6E 16r69 16r74 16r12 16r04 16r4E 16r6F 16r4F 16r70 16r22 16r02 16r08 16r0F]
		asString
]

{ #category : 'graphs',
  #vaVisibility : 'private' }
TensorFlowCAPITest >> constantInt32GraphFromDef [
	^ TFGraph fromString: self constantInt32GraphDef
]

{ #category : 'graphs',
  #vaVisibility : 'private' }
TensorFlowCAPITest >> constantInt64GraphDef [
	" This GraphDef corresponds to simple Graph, defined as
	
		tf.constant(0.42, name='a')
		
	 saved as ProtoBuf "

	^ #[16rA 16r33 16rA 16r1 16r61 16r12 16r5 16r43 16r6F 16r6E 16r73 16r74 16r2A 16r1A 16rA 16r5 16r76 16r61 16r6C 16r75 16r65 16r12 16r11 16r42 16rF 16r8 16r9 16r12 16r0 16r52 16r9 16rC2 16r84 16r89 16r92 16rA4 16rC8 16r90 16rA1 16r42 16r2A 16rB 16rA 16r5 16r64 16r74 16r79 16r70 16r65 16r12 16r2 16r30 16r9 16rA 16rC 16rA 16r4 16r69 16r6E 16r69 16r74 16r12 16r4 16r4E 16r6F 16r4F 16r70 16r12 16r0 16r22 16r2 16r8 16rF]
		asString.
	" Old version, from TensorFlow 1.0.0 
	^ #[16r0A 16r33 16r0A 16r01 16r61 16r12 16r05 16r43 16r6F 16r6E 16r73 16r74 16r2A 16r1A 16r0A 16r05 16r76 16r61 16r6C 16r75 16r65 16r12 16r11 16r42 16r0F 16r08 16r09 16r12 16r00 16r52 16r09 16rC2 16r84 16r89 16r92 16rA4 16rC8 16r90 16rA1 16r42 16r2A 16r0B 16r0A 16r05 16r64 16r74 16r79 16r70 16r65 16r12 16r02 16r30 16r09 16r0A 16r0C 16r0A 16r04 16r69 16r6E 16r69 16r74 16r12 16r04 16r4E 16r6F 16r4F 16r70 16r22 16r02 16r08 16r0F]
		asString
	"
]

{ #category : 'graphs',
  #vaVisibility : 'private' }
TensorFlowCAPITest >> constantInt64GraphFromDef [
	^ TFGraph fromString: self constantInt64GraphDef
]

{ #category : 'graphs',
  #vaVisibility : 'private' }
TensorFlowCAPITest >> emptyGraph [
	^ TFGraph fromString: self emptyGraphDef
]

{ #category : 'graphs',
  #vaVisibility : 'private' }
TensorFlowCAPITest >> emptyGraphDef [
	" This GraphDef corresponds to an Empty Graph (no operations), saved as ProtoBuf "

	^ #[16r0A 16r0C 16r0A 16r04 16r69 16r6E 16r69 16r74 16r12 16r04 16r4E 16r6F 16r4F 16r70 16r22 16r02 16r08 16r0F]
		asString
]

{ #category : 'initialization',
  #vaVisibility : 'private' }
TensorFlowCAPITest >> expectedFailures [
	^ #(
		testGraphDeletionDoesntBreakOperations
		testTensorFromFloatsOutOfRange
		testTensorFromDoubleOutOfRange
	)
]

{ #category : 'graphs',
  #vaVisibility : 'private' }
TensorFlowCAPITest >> get2x2FloatFromGraphDef [
	| graph session const result |
	graph := self constant2x2FloatGraphFromDef.
	const := (graph operationNamed: 'a') output: 0.
	session := TFSession on: graph.
	result := session runOutput: const.
	^ result
]

{ #category : 'graphs',
  #vaVisibility : 'private' }
TensorFlowCAPITest >> mulGraphOneInputInt64 [
	"| graph constant const in |
	graph := TFGraph create.
	constant := TFTensor fromInt64: 16r0606060606060606.
	in := graph placeholder: 'in' type: constant type.
	const := graph const: 'const' value: constant.
	graph
		mul: 'mul'
		described: [ :description | 
			description addInput: (in output: 0).
			description addInput: (const output: 0) ].
	^ graph"

	^TFGraph fromString:
		#[10 45 10 2 105 110 18 11 80 108 97 99 101 104 111 108 100 101 114 42 13 10 5 115 104 97 112
		101 18 4 58 2 24 1 42 11 10 5 100 116 121 112 101 18 2 48 9 10 55 10 5 99 111 110 115 116 18
		5 67 111 110 115 116 42 26 10 5 118 97 108 117 101 18 17 66 15 8 9 18 0 82 9 134 140 152 176
		224 192 129 131 6 42 11 10 5 100 116 121 112 101 18 2 48 9 10 30 10 3 109 117 108 18 3 77 117
		108 26 2 105 110 26 5 99 111 110 115 116 42 7 10 1 84 18 2 48 9 18 0 34 3 8 184 3]
			asByteArray
]

{ #category : 'graphs',
  #vaVisibility : 'private' }
TensorFlowCAPITest >> mulGraphTwoInputsInt64 [
	"| graph constant const in1 in2 mul1 |
	graph := TFGraph create.
	constant := TFTensor fromInt64: 16r0101010101010101.
	in1 := graph placeholder: 'in1' type: constant type.
	in2 := graph placeholder: 'in2' type: constant type.
	const := graph const: 'const' value: constant.
	mul1 := graph
		mul: 'mul1'
		described: [ :description | 
			description addInput: (const output: 0).
			description addInput: (in1 output: 0) ].
	graph
		mul: 'mul2'
		described: [ :description | 
			description addInput: (mul1 output: 0).
			description addInput: (in2 output: 0) ].
	^ graph"

	^TFGraph fromString:
		#[10 46 10 3 105 110 49 18 11 80 108 97 99 101 104 111 108 100 101 114 42 13 10 5 115 104 97
		112 101 18 4 58 2 24 1 42 11 10 5 100 116 121 112 101 18 2 48 9 10 46 10 3 105 110 50 18 11
		80 108 97 99 101 104 111 108 100 101 114 42 13 10 5 115 104 97 112 101 18 4 58 2 24 1 42 11
		10 5 100 116 121 112 101 18 2 48 9 10 55 10 5 99 111 110 115 116 18 5 67 111 110 115 116 42
		26 10 5 118 97 108 117 101 18 17 66 15 8 9 18 0 82 9 129 130 132 136 144 160 192 128 1 42 11
		10 5 100 116 121 112 101 18 2 48 9 10 32 10 4 109 117 108 49 18 3 77 117 108 26 5 99 111 110
		115 116 26 3 105 110 49 42 7 10 1 84 18 2 48 9 10 31 10 4 109 117 108 50 18 3 77 117 108 26 4
		109 117 108 49 26 3 105 110 50 42 7 10 1 84 18 2 48 9 18 0 34 3 8 184 3]
			asString
]

{ #category : 'initialization',
  #vaVisibility : 'private' }
TensorFlowCAPITest >> setUp [
	library := TensorFlowCAPI current
]

{ #category : 'testing session' }
TensorFlowCAPITest >> tesCloseSessionTwiceNoCrash [
	| graph session |
	graph := TFGraph create.
	session := TFSession on: graph.
	self deny: session isNull.
	session ignoreFinalization.
	session close.
	session close.
	session delete.
	self assert: session isNull
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testArrayFromStream [
	| t template array |
	t := 1.0 asTensor.
	template := #(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17) readStream.
	array := t arrayFromStream: template reset shape: #(10) asTensorShape.
	self assert: #(1 2 3 4 5 6 7 8 9 10) equals: array.
	array := t arrayFromStream: template reset shape: #(2 8) asTensorShape.
	self
		assert: #(#(1 2 3 4 5 6 7 8) #(9 10 11 12 13 14 15 16))
		equals: array.
	array := t arrayFromStream: template reset shape: #(2 4 2) asTensorShape.
	self
		assert: #(#(#(1 2) #(3 4) #(5 6) #(7 8)) #(#(9 10) #(11 12) #(13 14) #(15 16)))
		equals: array
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testAsBooleanTensor [

	self testAsBooleanTensor: true shape: TensorShape scalar.
	self testAsBooleanTensor: #(true false true false) shape: (TensorShape vectorSized: 4).
	self
		testAsBooleanTensor: #((true false true false) (false true false true))
		shape: (TensorShape matrixSized: 2 by: 4)
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testAsBooleanTensor: tensorArray shape: shapeArray [

	| tensor index bools |

	tensor := tensorArray asBooleanTensor.
	self assert: tensor shape equals: shapeArray.
	index := 1.
	bools := tensor allElements.
	tensorArray singleElementsDo: [:each |
		self assert: (bools at: index) equals: each.
		index := index + 1]
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testAsFloatTensor [
	self testAsFloatTensor: 1 shape: #().
	self testAsFloatTensor: #(1 2 3 4) shape: #(4).
	self
		testAsFloatTensor: #(#(1 2 3 4) #(3.14 1.71 2.12 -7.8))
		shape: #(2 4)
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testAsFloatTensor: tensorArray shape: shapeArray [

	| tensor index floats |

	tensor := tensorArray asFloatTensor.
	index := 1.
	floats := tensor allFloats.
	tensorArray singleElementsDo: [:each |
		self assert: (floats at: index) closeTo: each.
		index := index + 1].
	self assert: tensor shape equals: shapeArray
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testAsInt32Tensor [
	self testAsInt32Tensor: 1 shape: #().
	self testAsInt32Tensor: #(1 2 3 4) shape: #(4).
	self
		testAsInt32Tensor: #(#(1 2 3 4) #(-314 171 -212 -78))
		shape: #(2 4)
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testAsInt32Tensor: tensorArray shape: shapeArray [

	| tensor index ints |

	tensor := tensorArray asInt32Tensor.
	self assert: tensor shape equals: shapeArray.
	index := 1.
	ints := tensor allInt32s.
	tensorArray singleElementsDo: [:each |
		self assert: (ints at: index) equals: each.
		index := index + 1]
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testAsInt64Tensor [
	self testAsInt64Tensor: 1 shape: #().
	self testAsInt64Tensor: #(1 2 3 4) shape: #(4).
	self
		testAsInt64Tensor: #(#(1 2 3 4) #(-314 171 -212 -78))
		shape: #(2 4)
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testAsInt64Tensor: tensorArray shape: shapeArray [

	| tensor index ints |

	tensor := tensorArray asInt64Tensor.
	self assert: tensor shape equals: shapeArray.
	index := 1.
	ints := tensor allInt64s.
	tensorArray singleElementsDo: [:each |
		self assert: (ints at: index) equals: each.
		index := index + 1]
]

{ #category : 'testing operation' }
TensorFlowCAPITest >> testAttrSetShape [
	self testAttrSetShape: #().
	self testAttrSetShape: #(16r1234567890ABCDEF).
	self testAttrSetShape: #(1 2 3 4).
	self testAttrSetShape: (1 to: 10) asArray
]

{ #category : 'testing operation' }
TensorFlowCAPITest >> testAttrSetShape: anIntegerArray [
	| graph op shape |
	graph := TFGraph create.
	shape := anIntegerArray asTensorShape. 
	op := graph
		newOperation: 'Placeholder'
		named: 'const'
		described: [ :description | 
			description at: 'shape' putShape: shape.
			description at: 'dtype' putType: Int64DataType new ].
	self assert: (op shapeAt: 'shape') equals: shape 
]

{ #category : 'testing operation' }
TensorFlowCAPITest >> testAttrSetShapeTooLarge [
	" This test crashes VAST b437 with TensorFlow 1.14.0"

	self skip.
	self testAttrSetShape: (1 to: 200) asArray
]

{ #category : 'testing buffer' }
TensorFlowCAPITest >> testBufferDataBytes [
	| buffer string data |
	string := ' hola manola'.
	buffer := TFBuffer fromString: string.
	data := buffer dataBytes.
	self assert: string equals: data asString.
	buffer delete
]

{ #category : 'testing buffer' }
TensorFlowCAPITest >> testBufferNoNeedExternalize [
	| buffer string data |
	string := ' hola manola'.
	buffer := TFBuffer fromString: string.
	string := string copy.
	self garbageCollect.
	data := buffer dataBytes.
	self assert: string equals: data asString.
	buffer delete
]

{ #category : 'testing session' }
TensorFlowCAPITest >> testCloseSession [
	| graph session |
	graph := TFGraph create.
	session := TFSession on: graph.
	self deny: session isNull.
	session ignoreFinalization.
	self shouldnt: [ session close ] raise: Error.
	self shouldnt: [ session delete ] raise: Error.
	self assert: session isNull
]

{ #category : 'testing operation' }
TensorFlowCAPITest >> testDecodeCSVGraphRunCSV: csvLines [
	| defaults graph output records session results values |
	defaults := (Array new: 4)
		at: 1 put: (TFTensor fromInt64s: #(-1));
		at: 2 put: (TFTensor fromInt64s: #(-1));
		at: 3 put: (TFTensor fromInt64s: #(-1));
		at: 4 put: (TFTensor fromInt64s: #(-1));
		yourself.
	graph := self decodeCSVGraphDefaults: defaults.
	records := (graph operationNamed: 'records') input: 0.
	output := graph operationNamed: 'output'.
	values := TFTensor fromStringArray: csvLines.
	session := TFSession on: graph.
	results := session
		runInputs:
			((Array new: 1)
				at: 1 put: records;
				yourself)
		values:
			((Array new: 1)
				at: 1 put: values;
				yourself)
		outputs:
			((Array new: 4)
				at: 1 put: (output output: 0);
				at: 2 put: (output output: 1);
				at: 3 put: (output output: 2);
				at: 4 put: (output output: 3);
				yourself).
	graph delete.
	^ (1 to: 4) collect: [ :i | (results at: i) allInt64s ]
]

{ #category : 'testing device list' }
TensorFlowCAPITest >> testDeviceListAt [
	| graph session devices device |
	graph := TFGraph create.
	session := TFSession on: graph.
	devices := TFDeviceList on: session.
	device := devices at: 1.
	self assert: (device name endsWith: 'CPU:0').
	self assert: device type equals: 'CPU'.
	self assert: device memory > 16r100000.
]

{ #category : 'testing device list' }
TensorFlowCAPITest >> testDeviceListCount [
	| graph session devices |
	graph := TFGraph create.
	session := TFSession on: graph.
	devices := TFDeviceList on: session.
	self assert: devices count > 0	

]

{ #category : 'testing device list' }
TensorFlowCAPITest >> testDeviceListCreation [
	| graph session devices |
	graph := TFGraph create.
	session := TFSession on: graph.
	devices := TFDeviceList on: session.
	devices ignoreFinalization.
	self deny: devices isNull.
	devices delete.
	self assert: devices isNull	

]

{ #category : 'testing device list' }
TensorFlowCAPITest >> testDeviceListNames [
	| graph session devices list |
	graph := TFGraph create.
	session := TFSession on: graph.
	devices := TFDeviceList on: session.
	list := devices names.
	self assert: list size equals: devices count.
	self assert: (list first endsWith: 'CPU:0').
]

{ #category : 'testing device list' }
TensorFlowCAPITest >> testDeviceListTypeAt [
	| graph session devices type |
	graph := TFGraph create.
	session := TFSession on: graph.
	devices := TFDeviceList on: session.
	type := devices typeAt: 1.
	self assert: type equals: 'CPU'
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testElementsOf: tensorArray sum: aNumber [

	| sum |

	sum := 0.
	tensorArray singleElementsDo: [:each | sum := sum + each].
	self assert: sum equals: aNumber
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testElementsOfTensorDoIteratesAll [
	self testElementsOf: -13123213 sum: -13123213.
	self testElementsOf: #(123 123 123 123) sum: 123 * 4.
	self
		testElementsOf: #(#(1 2 3) #(4 5 6) #(7 8 9) #(10 11 12))
		sum: 12 * 13 / 2.
	self
		testElementsOf: #(#(#(1) #(2) #(3)) #(#(4) #(5) #(6)) #(#(7) #(8) #(9)))
		sum: 9 * 10 / 2.
	self
		testElementsOf:
			#(#(#(1 100) #(2 100) #(3 100)) #(#(4 100) #(5 100) #(6 100)) #(#(7 100) #(8 100) #(9 100)))
		sum: 9 * 10 / 2 + (100 * 9)
]

{ #category : 'testing options' }
TensorFlowCAPITest >> testExternalizeString [
	| original copy |
	original := 'hola manola'.
	copy := library externalizeString: original.
	1 to: original size do: [:i |
		self assert: (copy at: i-1) equals: (original at: i) ].
	self assert: 0 equals: (copy at: original size + 1) value.
	copy free
]

{ #category : 'testing operation' }
TensorFlowCAPITest >> testGetAttrMetadataType [
	| graph op template metadata |
	template := #(1 2 3 4 5) asTensorShape.
	graph := TFGraph create.
	op := graph
		newOperation: 'Placeholder'
		named: 'const'
		described: [ :description | 
			description at: 'shape' putShape: template.
			description at: 'dtype' putType: Int64DataType new ].
	metadata := op attrMetadata: 'dtype'.
	self assert: metadata isType.
	self assert: metadata isList equals: false
]

{ #category : 'testing operation' }
TensorFlowCAPITest >> testGetOperationOnConstantGraph [
	| graph op |
	graph := self constantFloatGraphFromDef.
	self shouldnt: [op := graph operationNamed: 'a'] raise: Error.
	self assert: op name equals: 'a'.
	self assert: op type equals: 'Const'.
	self assert: op inputsCount equals: 0.
	self assert: op outputsCount equals: 1
]

{ #category : 'testing operation' }
TensorFlowCAPITest >> testGetOperationOnEmptyGraph [
	| graph |
	graph := self emptyGraph.
	self
		should: [ graph operationNamed: 'something' ]
		raiseError: 'Operation not found'
]

{ #category : 'testing operation' }
TensorFlowCAPITest >> testGraph: aTFGraph outputType: anInteger [
	| operation output |
	operation := aTFGraph operationNamed: 'a'.
	output := operation output: 0.
	self assert: output type equals: anInteger.
	output free
]

{ #category : 'testing graph' }
TensorFlowCAPITest >> testGraphDefinition [
	| definition operations |
	definition := self mulGraphTwoInputsInt64 definition.
	operations := (TFGraph fromString: definition) allInputs.
	self assert: operations size equals: 2.
	self assert: operations first name equals: 'in1'.
	self assert: operations second name equals: 'in2'
]

{ #category : 'testing graph' }
TensorFlowCAPITest >> testGraphDeletionDoesntBreakOperations [
	| graph in1 in2 add |
	self
		assert: false
		description:
			'This test actually fails, and by failing it corrupts external memory and leads to a crash. This means when a TFGraph is deleted, all the TFOperations composing it are also deleted, hence pointers held to them (from Smalltalk or otherwise) become invalid'.
	graph := self addGraphTwoInputsInt64.
	graph ignoreFinalization.
	in1 := graph operationNamed: 'in1'.
	in2 := graph operationNamed: 'in2'.
	add := graph operationNamed: 'add'.
	self assert: in1 name equals: 'in1'.
	self assert: in2 name equals: 'in2'.
	self assert: add name equals: 'add'.
	graph delete.
	self assert: in1 name equals: 'in1'.
	self assert: in2 name equals: 'in2'.
	self assert: add name equals: 'add'.
	graph := self mulGraphTwoInputsInt64.
	graph ignoreFinalization.
	graph delete.
	self assert: in1 name equals: 'in1'.
	self assert: in2 name equals: 'in2'.
	self assert: add name equals: 'add'
]

{ #category : 'testing graph' }
TensorFlowCAPITest >> testGraphDeletionDoesntBreakSessions [
	| graph inputs inputValues add output session results |
	graph := self addGraphTwoInputsInt64.
	graph ignoreFinalization.
	inputs := Array
		with: ((graph operationNamed: 'in1') input: 0)
		with: ((graph operationNamed: 'in2') input: 0).
	inputValues := Array
		with: (TFTensor fromInt64: 16r2021222021222021)
		with: (TFTensor fromInt64: 16r2221202221202221).
	add := graph operationNamed: 'add'.
	output := add output: 0.
	session := TFSession on: graph.
	graph delete.
	graph := self addGraphTwoInputsInt64.
	graph ignoreFinalization.
	graph delete.
	results := session
		runInputs: inputs
		values: inputValues
		outputs: (Array with: output).
	self deny: results isNull.
	self deny: results first isNull.
	self deny: results first data isNull.
	self assert: results first asNumbers equals: 16r4242424242424242.
	results first delete
]

{ #category : 'testing graph' }
TensorFlowCAPITest >> testGraphNotFinalizedWhenHeldByOperations [
	| graph in1 in2 add |
	graph := self addGraphTwoInputsInt64.
	graph useFinalization.
	in1 := graph operationNamed: 'in1'.
	in2 := graph operationNamed: 'in2'.
	add := graph operationNamed: 'add'.
	self assert: in1 name equals: 'in1'.
	self assert: in2 name equals: 'in2'.
	self assert: add name equals: 'add'.
	graph := nil.
	self garbageCollect.
	self assert: in1 name equals: 'in1'.
	self assert: in2 name equals: 'in2'.
	self assert: add name equals: 'add'.
	graph := self mulGraphTwoInputsInt64.
	graph delete.
	self assert: in1 name equals: 'in1'.
	self assert: in2 name equals: 'in2'.
	self assert: add name equals: 'add'
]

{ #category : 'testing graph' }
TensorFlowCAPITest >> testGraphOperationAt [
	| graph operation context |
	graph := self mulGraphTwoInputsInt64.
	context := graph newOperationIteratorContext.
	operation := graph operationAt: context.
	self assert: operation name equals: 'in1'.
	self assert: operation type equals: 'Placeholder'.
	operation := graph operationAt: context.
	self assert: operation name equals: 'in2'.
	self assert: operation type equals: 'Placeholder'.
	operation := graph operationAt: context.
	self assert: operation name equals: 'const'.
	self assert: operation type equals: 'Const'.
	operation := graph operationAt: context.
	self assert: operation name equals: 'mul1'.
	self assert: operation type equals: 'Mul'.
	operation := graph operationAt: context.
	self assert: operation name equals: 'mul2'.
	self assert: operation type equals: 'Mul'.
	operation := graph operationAt: context.
	self assert: operation isNull
]

{ #category : 'testing graph' }
TensorFlowCAPITest >> testGraphOperationsCount [
	| graph |
	graph := self mulGraphTwoInputsInt64.
	self assert: graph operationsCount equals: 5
]

{ #category : 'testing graph' }
TensorFlowCAPITest >> testGraphOperationsDo [
	| graph operations |
	graph := self mulGraphTwoInputsInt64.
	operations := OrderedCollection new.
	graph operationsDo: [ :op | operations add: op name ].
	self assert: operations size equals: 5.
	self assert: operations first equals: 'in1'.
	self assert: operations second equals: 'in2'.
	self assert: operations third equals: 'const'.
	self assert: operations fourth equals: 'mul1'.
	self assert: (operations at: 5) equals: 'mul2'
]

{ #category : 'testing graph' }
TensorFlowCAPITest >> testGraphOperationsSelect [
	| operations |
	operations := self mulGraphTwoInputsInt64 allInputs.
	self assert: operations size equals: 2.
	self assert: operations first name equals: 'in1'.
	self assert: operations second name equals: 'in2'
]

{ #category : 'testing graph' }
TensorFlowCAPITest >> testGraphOperationsSelectEmpty [
	| graph operations |
	graph := self mulGraphTwoInputsInt64.
	operations := graph operationsSelect: [ :op | false ].
	self assert: operations size equals: 0
]

{ #category : 'testing graph' }
TensorFlowCAPITest >> testImportBad [
	| graph buffer |
	graph := TFGraph create.
	buffer := TFBuffer fromString: 'ouch'.
	self
		should: [ graph import: buffer ]
		raiseError: 'INVALID_ARGUMENT: Invalid GraphDef'.
	buffer delete
]

{ #category : 'testing graph' }
TensorFlowCAPITest >> testImportConstantGraph [
	self
		shouldnt: [ self constantFloatGraphFromDef.
			self constantInt32GraphFromDef.
			self constantInt64GraphFromDef ]
		raise: Error
]

{ #category : 'testing graph' }
TensorFlowCAPITest >> testImportEmpty [
	self emptyGraph.
	self assert: true
	" really we just want the first line not to raise an error,
	 but #shouldnt:raise: doesn't let you debug if it fails,
	 and it only shows a very generic message, so, this is our approach"
]

{ #category : 'testing graph' }
TensorFlowCAPITest >> testInitializeOn [
	| graph session |
	graph := TFGraph create.
	session := TFSession on: graph.
	self shouldnt: [ graph initializeOn: session ] raise: Error
]

{ #category : 'testing buffer' }
TensorFlowCAPITest >> testNewBufferFromFileNamed [
	| buffer string data temporaryFile |
	string := ' hola manola'.
	temporaryFile := 'temporaryFile.txt'.
	temporaryFile asPath writeStreamDo: [:strm | strm nextPutAll: string].
	buffer := TFBuffer fromFileNamed: temporaryFile.
	temporaryFile asPath delete.
	
	self deny: buffer isNull.
	self assert: buffer length equals: string size.
	data := buffer data byteArrayAt: 0 size: string size.
	self assert: string equals: data asString.
	buffer delete.
	
	self assert: buffer isNull
]

{ #category : 'testing buffer' }
TensorFlowCAPITest >> testNewBufferFromString [
	| buffer string data |
	string := ' hola manola'.
	buffer := TFBuffer fromString: string.
	self deny: buffer isNull.
	self assert: buffer length equals: string size.
	data := buffer data byteArrayAt: 0 size: string size.
	self assert: string equals: data asString.
	buffer delete.
	self assert: buffer isNull.
	
	
]

{ #category : 'testing graph' }
TensorFlowCAPITest >> testNewGraph [
	| graph |
	graph := TFGraph create.
	self deny: graph isNull.
	graph delete.
	self assert: graph isNull
]

{ #category : 'testing options' }
TensorFlowCAPITest >> testNewImportGraphDefOptions [
	| options |
	options := TFImportGraphDefOptions create.
	self deny: options isNull.
	options delete.
	self assert: options isNull
]

{ #category : 'testing operation' }
TensorFlowCAPITest >> testNewOperationDescription [
	| graph description |
	graph := TFGraph create.
	description := graph
		newOperationDescription: 'Const'
		named: 'first_operation'.
	self deny: description isNull.
	self
		should: [ description finish ]
		raise: Error
		description: 'This should have complained of missing attributes'
]

{ #category : 'testing operation' }
TensorFlowCAPITest >> testNewOperationPlaceholderNoType [
	| graph noType |
	noType := 'INVALID_ARGUMENT: NodeDef missing attr ''dtype'' from Op'.
	graph := TFGraph create.
	self
		should: [ (graph newOperationDescription: 'Placeholder' named: 'placeholder')
				finish ]
		raiseError: noType
]

{ #category : 'testing session' }
TensorFlowCAPITest >> testNewSession [
	| graph session |
	graph := TFGraph create.
	session := TFSession on: graph.
	session ignoreFinalization.
	self deny: session isNull.
	session delete.
	self assert: session isNull
]

{ #category : 'testing options' }
TensorFlowCAPITest >> testNewSessionOptions [
	| options |
	options := TFSessionOptions create.
	self deny: options isNull.
	options delete.
	self assert: options isNull
]

{ #category : 'testing status' }
TensorFlowCAPITest >> testNewStatus [
	| status |
	status := TFStatus create.
	status ignoreFinalization.
	self deny: status isNull.
	status delete.
	self assert: status isNull
]

{ #category : 'testing operation' }
TensorFlowCAPITest >> testNewVariableNoAttributes [
	| graph error |
	graph := TFGraph create.
	error := 'INVALID_ARGUMENT: NodeDef missing attrs '''.
	self
		should: [ graph newOperation: 'Variable' named: 'var' ]
		raiseError: error
]

{ #category : 'testing operation' }
TensorFlowCAPITest >> testOperationOutputTypeFloat [

	^self testGraph: self constantFloatGraphFromDef outputType: FloatDataType new
]

{ #category : 'testing operation' }
TensorFlowCAPITest >> testOperationOutputTypeInt32 [

	^self testGraph: self constantInt32GraphFromDef outputType: Int32DataType new
]

{ #category : 'testing operation' }
TensorFlowCAPITest >> testOperationOutputTypeInt64 [

	^self testGraph: self constantInt64GraphFromDef outputType: Int64DataType new
]

{ #category : 'testing graph' }
TensorFlowCAPITest >> testOutputDims [
	| graph operation output |
	graph := self constantInt64GraphFromDef.
	operation := graph operationNamed: 'a'.
	output := operation output: 0.
	self assert: (graph outputDimensionsCount: output) equals: 0.
	output free
]

{ #category : 'testing operation' }
TensorFlowCAPITest >> testPrintOn [
	| graph printString |
	graph := self addGraphTwoInputsInt64.
	printString := (graph operationNamed: 'in1') printString.
	self assert: (printString includesSubString: 'TFOperation').
	self assert: (printString endsWith: '''Placeholder'' ''in1''').
	printString := (graph operationNamed: 'add') printString.
	self assert: (printString includesSubString: 'TFOperation').
	self assert: (printString  endsWith: '''Add'' ''add''')
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testRanks [
	self assertRankOf: -13123213 is: 0.
	self assertRankOf: #(123 123 123 123) is: 1.
	self assertRankOf: #(#(1 2 3) #(4 5 6) #(7 8 9)) is: 2.
	self
		assertRankOf: #(#(#(1) #(2) #(3)) #(#(4) #(5) #(6)) #(#(7) #(8) #(9)))
		is: 3
]

{ #category : 'testing operation' }
TensorFlowCAPITest >> testRunGraphAddTwoInputs [
	| graph inputs inputValues add output session results |
	graph := self addGraphTwoInputsInt64.
	inputs := Array
		with: ((graph operationNamed: 'in1') input: 0)
		with: ((graph operationNamed: 'in2') input: 0).
	inputValues := Array
		with: (TFTensor fromInt64: 16r2021222021222021)
		with: (TFTensor fromInt64: 16r2221202221202221).
	add := graph operationNamed: 'add'.
	output := add output: 0.
	session := TFSession on: graph.
	results := session
		runInputs: inputs
		values: inputValues
		outputs: (Array with: output).
	self deny: results isNull.
	self deny: results first isNull.
	self deny: results first data isNull.
	self
		assert: results first asNumbers
		equals: 16r4242424242424242.
	graph delete.
	results first delete
]

{ #category : 'testing session' }
TensorFlowCAPITest >> testRunGraphMulOneInput [
	| graph input inputValue result mul output session |
	graph := self mulGraphOneInputInt64.
	input := (graph operationNamed: 'in') input: 0.
	inputValue := TFTensor fromInt64: 11.
	mul := graph operationNamed: 'mul'.
	output := mul output: 0.
	session := TFSession on: graph.
	result := (session
		runInputs: (Array with: input) 
		values: (Array with: inputValue) 
		outputs: (Array with: output)) first.
	self deny: result isNull.
	self deny: result data isNull.
	self
		assert: result asNumbers
		equals: 16r4242424242424242.
	result delete.
	input free.
	output free.
	graph delete
]

{ #category : 'testing session' }
TensorFlowCAPITest >> testRunGraphMulTwoInputs [
	| graph inputs inputValues mul output session results |
	graph := self mulGraphTwoInputsInt64.
	inputs := Array
		with: ((graph operationNamed: 'in1') input: 0)
		with: ((graph operationNamed: 'in2') input: 0).
	inputValues := Array
		with: (TFTensor fromInt64: 6)
		with: (TFTensor fromInt64: 11).
	mul := graph operationNamed: 'mul2'.
	output := mul output: 0.
	session := TFSession on: graph.
	results := session
		runInputs: inputs
		values: inputValues
		outputs: (Array with: output).
	self deny: results isNull.
	self deny: results first isNull.
	self deny: results first data isNull.
	self
		assert: results first asNumbers
		equals: 16r4242424242424242.
	graph delete.
	results first delete
]

{ #category : 'testing session' }
TensorFlowCAPITest >> testRunGraphMulTwoInputsRunInputsOutputs [
	| graph inputs inputValues mul output session results |
	graph := self mulGraphTwoInputsInt64.
	inputs := Array
		with: ((graph operationNamed: 'in1') input: 0)
		with: ((graph operationNamed: 'in2') input: 0).
	inputValues := Array
		with: (TFTensor fromInt64: 6)
		with: (TFTensor fromInt64: 11).
	mul := graph operationNamed: 'mul2'.
	output := mul output: 0.
	session := TFSession on: graph.
	results := session
		runInputs: inputs
		values: inputValues
		outputs:
			((Array new: 1)
				at: 1 put: output;
				yourself).
	self deny: results isNull.
	self deny: results first isNull.
	self deny: results first data isNull.
	self
		assert: results first asNumbers
		equals: 16r4242424242424242.
	graph delete.
	results first delete
]

{ #category : 'testing operation' }
TensorFlowCAPITest >> testRunOperationArray [
	| graph operation session |
	graph := self constantFloatGraphFromDef.
	session := TFSession on: graph.
	operation := graph operationNamed: 'a'.
	self
		shouldnt: [ session runOperations: (Array with: operation) ]
		raise: Error.
	graph delete
]

{ #category : 'testing graph' }
TensorFlowCAPITest >> testSessionDeletionDoesntDeleteGraphs [

	| session graph allocatedObjects |

	graph := TFGraph create.
	session := TFSession on: graph.
	session ignoreFinalization.
	session close.
	session delete.

	" Allocate some external objects using the library, if the graph was released, we expect its space to be reused "
	allocatedObjects := OrderedCollection new: 10.
	10 timesRepeat: [allocatedObjects add: TFStatus create].
	self
		shouldnt: [
			graph
				newOperation: 'Placeholder'
				named: 'a'
				described: [:description | description at: 'dtype' putType: Int64DataType new]]
		raise: Error
		description: 'The FFI call would crash if the graph was released by deleting the session'
]

{ #category : 'testing device list' }
TensorFlowCAPITest >> testSessionDevices [
	| graph session devices |
	graph := TFGraph create.
	session := TFSession on: graph.
	devices := session devices.
	self assert: devices first type equals: 'CPU'.
	self assert: (devices first name endsWith: 'CPU:0')
]

{ #category : 'testing device list' }
TensorFlowCAPITest >> testSessionDevicesNames [
	| graph session list |
	graph := TFGraph create.
	session := TFSession on: graph.
	list := (TFDeviceList on: session) names.
	self assert: session devices first name equals: list first
]

{ #category : 'testing session' }
TensorFlowCAPITest >> testSessionOnEmptyGraph [
	| session |
	session := TFSession on: self emptyGraph.
	self
		should: [ session run ]
		raiseError:
			'INVALID_ARGUMENT: Must specify at least one target to fetch or execute.'
]

{ #category : 'testing options' }
TensorFlowCAPITest >> testSessionOptionsFromProtoBufEmpty [
	TFSessionOptions fromProtoBuf: ''
]

{ #category : 'testing options' }
TensorFlowCAPITest >> testSessionOptionsFromProtoBufInvalid [
	self
		should: [ TFSessionOptions fromProtoBuf: '.' ]
		raiseError: 'INVALID_ARGUMENT: Unparseable ConfigProto'
]

{ #category : 'testing options' }
TensorFlowCAPITest >> testSessionOptionsFromProtoBufValid [
	"
	In [241]: tf.ConfigProto(allow_soft_placement=True, log_device_placement=True).SerializeToString()
	Out[241]: b'8\x01@\x01'
	"

	| config |
	config := #[16r38 1 16r40 1].
	TFSessionOptions fromProtoBuf: config
]

{ #category : 'testing options' }
TensorFlowCAPITest >> testSessionOptionsSetTarget [
	| options |
	options := library newSessionOptions.
	self deny: options isNull.
	options target: 'local'.
	options delete.
	self assert: options isNull
]

{ #category : 'testing session' }
TensorFlowCAPITest >> testSessionRunOutput [
	^ self testSessionRunOutputOnGraph: self constantInt64GraphFromDef
]

{ #category : 'testing session' }
TensorFlowCAPITest >> testSessionRunOutputOnGraph: graph [
	| operation session output tensor |
	session := TFSession on: graph.
	operation := graph operationNamed: 'a'.
	output := operation output: 0.
	tensor := session runOutput: output.
	self deny: tensor isNull.
	self deny: tensor data isNull.
	self
		assert: tensor asNumbers
		equals: 16r4242424242424242.
	output free.
	graph delete
]

{ #category : 'testing session' }
TensorFlowCAPITest >> testSessionRunTarget [
	| graph operation session |
	graph := self constantFloatGraphFromDef.
	session := TFSession on: graph.
	operation := graph operationNamed: 'a'.
	self shouldnt: [ session runOperation: operation ] raise: Error.
	graph delete
]

{ #category : 'testing session' }
TensorFlowCAPITest >> testSessionRunTargetOutput [
	^ self
		testSessionRunTargetOutputOnGraph: self constantInt64GraphFromDef
]

{ #category : 'testing session' }
TensorFlowCAPITest >> testSessionRunTargetOutputOnGraph: graph [
	| operation session output tensor |
	session := TFSession on: graph.
	operation := graph operationNamed: 'a'.
	output := operation output: 0.
	tensor := session runOperation: operation output: output.
	self deny: tensor isNull.
	self deny: tensor data isNull.
	self assert: tensor asNumbers equals: 16r4242424242424242.
	output free.
	graph delete
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testShape [
	self assertShapeOf: -13123213 is: #().
	self assertShapeOf: #(123 123 123 123) is: #(4).
	self
		assertShapeOf: #(#(1 2 3) #(4 5 6) #(7 8 9) #(10 11 12))
		is: #(4 3).
	self
		assertShapeOf: #(#(#(1) #(2) #(3)) #(#(4) #(5) #(6)) #(#(7) #(8) #(9)))
		is: #(3 3 1)
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testSizes [
	self assertSizeOf: -13123213 is: 1.
	self assertSizeOf: #(123 123 123 123) is: 4.
	self
		assertSizeOf: #(#(1 2 3) #(4 5 6) #(7 8 9) #(10 11 12))
		is: 4 * 3.
	self
		assertSizeOf: #(#(#(1) #(2) #(3)) #(#(4) #(5) #(6)) #(#(7) #(8) #(9)))
		is: 3 * 3 * 1
]

{ #category : 'testing status' }
TensorFlowCAPITest >> testStatusCodes [
	| status msg |
	status := TFStatus create.
	self assert: status isOk.
	self assert: status codeText equals: 'OK'.
	self shouldnt: [ status check ] raise: Error.
	msg := 'You cancelled it!'.
	status code: 1 message: msg.
	self assert: status codeText equals: 'CANCELLED'.
	self should: [ status check ] raiseError: 'CANCELLED: ' , msg
]

{ #category : 'testing status' }
TensorFlowCAPITest >> testStatusGetMessage [
	| status message |
	status := TFStatus create.
	status code: 1 message: 'All is one'.
	message := status message.
	self assert: message equals: 'All is one'.
	status code: 7 message: 'Something is very seven'.
	message := status message.
	self assert: message equals: 'Something is very seven'
]

{ #category : 'testing status' }
TensorFlowCAPITest >> testStatusSetGetCode [
	| status code |
	status := TFStatus create.
	status code: 1 message: ''.
	code := status code.
	self assert: code equals: 1.
	status code: 2 message: ''.
	code := status code.
	self assert: code equals: 2
]

{ #category : 'testing strings' }
TensorFlowCAPITest >> testStringAsTensor [
	| tensor template |
	template := 'hola manola'.
	tensor := template asTensor.
	self assert: tensor dataBytes first equals: template size.
	self assert: tensor dataBytes allButFirst asString equals: template
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorAllElements [
	self
		assertTensor: -13123213 asInt32Tensor
		elementsEquals: #(-13123213).
	self
		assertTensor: #(123 123 123 123) asInt32Tensor
		elementsEquals: #(123 123 123 123).
	self
		assertTensor: #(#(1 2 3) #(4 5 6) #(7 8 9) #(10 11 12)) asFloatTensor
		elementsEquals: #(1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 9.0 10.0 11.0 12.0).
	self
		assertTensor:
			#(#(#(1 100) #(2 100) #(3 100)) #(#(4 100) #(5 100) #(6 100)) #(#(7 100) #(8 100) #(9 100)))
				asFloatTensor
		elementsEquals:
			#(1.0 100.0 2.0 100.0 3.0 100.0 4.0 100.0 5.0 100.0 6.0 100.0 7.0 100.0 8.0 100.0 9.0 100.0)
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorArrayNumbersAt [
	| graph inputValues inputs mul numbers output results session |
	graph := self mulGraphTwoInputsInt64.
	inputs := Array
		with: ((graph operationNamed: 'in1') input: 0)
		with: ((graph operationNamed: 'in2') input: 0).
	inputValues := Array
		with: (TFTensor fromInt64: 6)
		with: (TFTensor fromInt64: 11).
	mul := graph operationNamed: 'mul2'.
	output := mul output: 0.
	session := TFSession on: graph.
	results := session
		runInputs: inputs
		values: inputValues
		outputs: (Array with: output).
	numbers := results numbersAt: 1.
	self assert: numbers equals: 16r4242424242424242
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorAsNumbers [
	| tensor template array |
	template := #(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16).
	tensor := TFTensor fromFloats: template shape: #(16) asTensorShape.
	array := tensor asNumbers.
	self assert: template equals: array.
	tensor := TFTensor fromFloats: template shape: #(2 8) asTensorShape.
	array := tensor asNumbers.
	self
		assert: #(#(1 2 3 4 5 6 7 8) #(9 10 11 12 13 14 15 16))
		equals: array.
	tensor := TFTensor fromFloats: template shape: #(2 4 2) asTensorShape.
	array := tensor asNumbers.
	self
		assert: #(#(#(1 2) #(3 4) #(5 6) #(7 8)) #(#(9 10) #(11 12) #(13 14) #(15 16)))
		equals: array
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorAsNumbersFloats [
	| tensor template array |
	template := #(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16).
	tensor := TFTensor fromFloats: template shape: #(16) asTensorShape.
	array := tensor asNumbers.
	self assert: #(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16) equals: array.
	tensor := TFTensor fromFloats: template shape: #(2 8) asTensorShape.
	array := tensor asNumbers.
	self
		assert: #(#(1 2 3 4 5 6 7 8) #(9 10 11 12 13 14 15 16))
		equals: array.
	tensor := TFTensor fromFloats: template shape: #(2 4 2) asTensorShape.
	array := tensor asNumbers.
	self
		assert: #(#(#(1 2) #(3 4) #(5 6) #(7 8)) #(#(9 10) #(11 12) #(13 14) #(15 16)))
		equals: array
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorAsNumbersInt32 [
	| tensor template array |
	template := #(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16).
	tensor := TFTensor fromInt32s: template shape: #(16) asTensorShape.
	array := tensor asNumbers.
	self assert: #(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16) equals: array.
	tensor := TFTensor fromInt32s: template shape: #(2 8) asTensorShape.
	array := tensor asNumbers.
	self
		assert: #(#(1 2 3 4 5 6 7 8) #(9 10 11 12 13 14 15 16))
		equals: array.
	tensor := TFTensor fromInt32s: template shape: #(2 4 2) asTensorShape.
	array := tensor asNumbers.
	self
		assert: #(#(#(1 2) #(3 4) #(5 6) #(7 8)) #(#(9 10) #(11 12) #(13 14) #(15 16)))
		equals: array
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorAsNumbersRank0 [
	self assert: 1 equals: 1 asInt32Tensor asNumbers.
	self assert: 1.0 equals: 1.0 asTensor asNumbers
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorAsStream [
	self assertTensor: -13123213 asInt32Tensor streamEquals: #(-13123213).
	self
		assertTensor: #(123 123 123 123) asInt32Tensor
		streamEquals: #(123 123 123 123).
	self
		assertTensor: #(#(1 2 3) #(4 5 6) #(7 8 9) #(10 11 12)) asFloatTensor
		streamEquals: #(1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 9.0 10.0 11.0 12.0).
	self
		assertTensor:
			#(#(#(1 100) #(2 100) #(3 100)) #(#(4 100) #(5 100) #(6 100)) #(#(7 100) #(8 100) #(9 100)))
				asFloatTensor
		streamEquals:
			#(1.0 100.0 2.0 100.0 3.0 100.0 4.0 100.0 5.0 100.0 6.0 100.0 7.0 100.0 8.0 100.0 9.0 100.0)
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorByteSize [
	| tensor |
	tensor := TFTensor newTyped: Int64DataType new shaped: #(2 3) asTensorShape.
	self assert: tensor byteSize equals: 8 * 2 * 3
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorData [
	| tensor |
	tensor := TFTensor newTyped: Int64DataType new shaped: #(2 3) asTensorShape.
	self assert: tensor rank equals: 2.
	self deny: tensor isNull.
	self deny: tensor isUndefined
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorDataTypeSize [

	OrderedCollection new
		add: ResourceDataType new;
		add: StringDataType new;
		add: VariantDataType new;
		do: [:type | self assert: type dataSize equals: 0].

	OrderedCollection new
		add: BooleanDataType new;
		add: Int8DataType new;
		add: QuantizedInt8DataType new;
		add: QuantizedUnsignedInt8DataType new;
		add: UnsignedInt8DataType new;
		do: [:type | self assert: type dataSize equals: 1].

	OrderedCollection new
		add: HalfDataType new;
		add: Int16DataType new;
		add: QuantizedInt16DataType new;
		add: QuantizedUnsignedInt16DataType new;
		add: ReducedFloat16DataType new;
		add: UnsignedInt16DataType new;
		do: [:type | self assert: type dataSize equals: 2].

	OrderedCollection new
		add: FloatDataType new;
		add: Int32DataType new;
		add: QuantizedInt32DataType new;
		add: UnsignedInt32DataType new;
		do: [:type | self assert: type dataSize equals: 4].

	OrderedCollection new
		add: Complex64DataType new;
		add: DoubleDataType new;
		add: Int64DataType new;
		add: UnsignedInt64DataType new;
		do: [:type | self assert: type dataSize equals: 8].

	self assert: Complex128DataType new dataSize equals: 16
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorElementsOf [
	self assertElementsOf: -13123213 are: #(-13123213).
	self assertElementsOf: #(123 123 123 123) are: #(123 123 123 123).
	self
		assertElementsOf: #(#(1 2 3) #(4 5 6) #(7 8 9) #(10 11 12))
		are: (1 to: 12) asArray.
	self
		assertElementsOf: #(#(#(1) #(2) #(3)) #(#(4) #(5) #(6)) #(#(7) #(8) #(9)))
		are: (1 to: 9) asArray.
	self
		assertElementsOf:
			#(#(#(1 100) #(2 100) #(3 100)) #(#(4 100) #(5 100) #(6 100)) #(#(7 100) #(8 100) #(9 100)))
		are: #(1 100 2 100 3 100 4 100 5 100 6 100 7 100 8 100 9 100)
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorFromDoublesOutOfRange [
"The following source failed to compile (all double quotes have been doubled):
	| tensor template values |
	template := #(1.23456 0.0 -1.234567 1.0e39 1.0e-50 '<an unprintable nonliteral value>' 1.0e-324)
		copy.
	tensor := TFTensor fromDoubles: template.
	template at: 6 put: Float infinity.
	values := tensor allElements.
	self assert: tensor shape equals: #(7).
	self assert: tensor size equals: 7.
	self assert: tensor byteSize equals: 7 * 8.
	template
		with: values
		do: [ :expected :actual | self assert: expected closeTo: actual ].
	self assert: 0.0 equals: values last
"

	^ self skip. "This source code make VAST irresponsive. It's something to do with the large Float"
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorFromDoublesOutOfRangeForFloats [
	| tensor template values |
	template := #(1.23456 0.0 -1.234567 3.402824e38 1.175494351e-46 1.0e39 1.0e-50)
		copy.
	tensor := TFTensor fromDoubles: template.
	values := tensor allElements.
	self assert: tensor shape equals: #(7).
	self assert: tensor size equals: 7.
	self assert: tensor byteSize equals: 7 * 8.
	template
		with: values
		do: [ :expected :actual | self assert: expected closeTo: actual ].
	self assert: 0.0 ~= values last.
	self assert: 0.0 ~= (values at: 5)
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorFromDoublesShape [
	| tensor template values |
	template := #(1.23456 0.0 -1.234567 1.1).
	tensor := TFTensor fromDoubles: template shape: #(2 2) asTensorShape.
	values := tensor allElements.
	self assert: tensor shape equals: #(2 2).
	self assert: tensor size equals: 4.
	self assert: tensor byteSize equals: tensor size * 8.
	template
		with: values
		do: [ :templ :actual | self assert: templ closeTo: actual ]
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorFromFloats [
	| tensor template values |
	template := #(1.23456 0.0 -1.234567 3.402823466e38 1.175494351e-38).
	tensor := TFTensor fromFloats: template.
	values := tensor allFloats.
	self assert: tensor shape equals: #(5).
	self assert: tensor size equals: 5.
	self assert: tensor byteSize equals: 5 * 4.
	template with: values
		do: [:templ :value | self assert: templ closeTo: value ]
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorFromFloats2x2 [
	| tensor template values |
	template := #(#(-1.1 -2.1) #(-1.2 -2.2)).
	tensor := TFTensor fromFloats: template.
	values := tensor allFloats.
	self assert: tensor shape equals: #(2 2).
	self assert: tensor size equals: 4.
	self assert: tensor byteSize equals: 4 * 4.
	#(-1.1 -2.1 -1.2 -2.2)
		with: values
		do: [ :reference :value | self assert: reference closeTo: value ]
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorFromFloats2x2SameElementsOrder [
	| tensor template values constTensor consts |
	template := #(#(-1.1 -2.1) #(-1.2 -2.2)).
	tensor := TFTensor fromFloats: template.
	values := tensor allFloats.
	constTensor := self get2x2FloatFromGraphDef.
	consts := constTensor allFloats.
	consts
		with: values
		do: [ :const :value | self assert: const closeTo: value ]
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorFromFloatsInfinity [
	| tensor template values |
	template := #(1.23456 0.0 -1.234567 +101010 -101010)
		copy.
	template at: 4 put: Float infinity.
	template at: 5 put: Float infinity negated.
	tensor := TFTensor fromFloats: template.
	values := tensor allElements.
	self assert: tensor shape equals: (Array with: template size).
	self assert: tensor size equals: template size.
	self assert: tensor byteSize equals: template size * 4.
	template
		with: values
		do: [ :expected :actual | self assert: expected closeTo: actual ].

]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorFromFloatsOutOfRange [
	" This test actually depends on #floatAt:put: bounding the out of range floats and
	 'invisibly' replacing them for +Inf or 0.0 "
	
	| tensor template values |
	self error: 'This tests crashes the VAST VM. Evaluate twice:
	
	(OSPtr calloc: 100) float32At: 4 put: 3.402824e38
	'.
	
	template := #(1.23456 0.0 -1.234567 3.402824e38 1.175494351e-46 1.0e39 1.0e-50)
		copy.
	tensor := TFTensor fromFloats: template.
	template at: 4 put: Float infinity.
	template at: 6 put: Float infinity.
	values := tensor allElements.
	self assert: tensor shape equals: #(7).
	self assert: tensor size equals: 7.
	self assert: tensor byteSize equals: 7 * 4.
	template
		with: values
		do: [ :expected :actual | self assert: expected closeTo: actual ].
	self assert: 0.0 equals: values last.
	self assert: 0.0 equals: (values at: 5)
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorFromFloatsScalar [
	| tensor template values |
	template := 3.141516.
	tensor := TFTensor fromFloats: template.
	values := tensor allFloats.
	self assert: tensor shape equals: #().
	self assert: tensor size equals: 1.
	self assert: tensor byteSize equals: 1 * 4.
	self assert: template closeTo: values first
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorFromFloatsShape [
	| tensor template values |
	template := #(1.23456 0.0 -1.234567 1.1).
	tensor := TFTensor fromFloats: template shape: #(2 2) asTensorShape.
	values := tensor allFloats.
	self assert: tensor shape equals: #(2 2).
	self assert: tensor size equals: 4.
	self assert: tensor byteSize equals: tensor size * 4.
	template
		with: values
		do: [ :templ :actual | self assert: templ closeTo: actual ]
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorFromFloatsShapeUndefinedSize [
	| template |
	template := #(1.23456 0.0 -1.234567 1.1).
	self
		should: [ TFTensor fromFloats: template shape: #(2 2 -1) asTensorShape ]
		raiseError: 'Inferred size and real size don''t match.'
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorFromInt32 [
	| tensor template values |
	template := -1123123123.
	tensor := TFTensor fromInt32: template.
	values := tensor allInt32s.
	self assert: tensor shape equals: #().
	self assert: tensor size equals: 1.
	self assert: tensor byteSize equals: 4.
	self
		assert: values
		equals:
			((Array new: 1)
				at: 1 put: template;
				yourself)
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorFromInt32s [
	| tensor template values |
	template := #(0 -1 1 -2 2 32768 65536 -1123123123).
	tensor := TFTensor fromInt32s: template.
	values := tensor allInt32s.
	self
		assert: tensor shape
		equals:
			((Array new: 1)
				at: 1 put: template size;
				yourself).
	self assert: tensor size equals: template size.
	self assert: tensor byteSize equals: template size * 4.
	self assert: values equals: template
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorFromInt32Shape [
	| tensor template values |
	template := #(123456 0 -1234567 11).
	tensor := TFTensor fromInt32s: template shape: #(2 2) asTensorShape.
	values := tensor allFloats.
	self assert: tensor type equals: Int32DataType new.
	self assert: tensor shape equals: #(2 2) asTensorShape.
	self assert: tensor size equals: 4.
	self assert: tensor byteSize equals: tensor size * 4.
	template
		with: values
		do: [ :templ :actual | self assert: templ closeTo: actual ]
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorFromInt64 [
	| tensor template values |
	template := -1123123123727272.
	tensor := TFTensor fromInt64: template.
	values := tensor allInt64s.
	self assert: tensor shape equals: #().
	self assert: tensor size equals: 1.
	self assert: tensor byteSize equals: 8.
	self
		assert: values
		equals:
			((Array new: 1)
				at: 1 put: template;
				yourself)
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorFromInt64s [
	| tensor template values |
	template := #(16r1234567812345678 0 -12345678910111213).
	tensor := TFTensor fromInt64s: template.
	values := tensor allInt64s.
	self assert: tensor shape equals: #(3).
	self assert: tensor size equals: 3.
	self assert: tensor byteSize equals: 3 * 8.
	self assert: template equals: values
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorFromInt64Shape [
	| tensor template values |
	template := #(123456 0 -1234567 11).
	tensor := TFTensor fromInt64s: template shape: #(2 2) asTensorShape.
	values := tensor allFloats.
	self assert: tensor type equals: Int64DataType new.
	self assert: tensor shape equals: #(2 2) asTensorShape.
	self assert: tensor size equals: 4.
	self assert: tensor byteSize equals: tensor size * 8.
	template
		with: values
		do: [ :templ :actual | self assert: templ closeTo: actual ]
]

{ #category : 'testing strings' }
TensorFlowCAPITest >> testTensorFromString [
	| tensor template |
	template := 'hola manola'.
	tensor := TFTensor fromString: template.
	self assert: tensor dataBytes first equals: template size.
	self assert: tensor dataBytes allButFirst asString equals: template
]

{ #category : 'testing strings' }
TensorFlowCAPITest >> testTensorFromStringArray [
	| tensor template |
	template := #('hola manola' 'te traje una lola' 'pamela' 'que pandulce!').
	tensor := TFTensor fromStringArray: template.
	self assert: tensor allStrings equals: template
]

{ #category : 'testing strings' }
TensorFlowCAPITest >> testTensorFromStrings [

	| tensor template flatten |

	template := #(('hola manola' 'te traje una lola') ('pamela' 'que pandulce!') ('habia una vez' 'truz')).
	tensor := TFTensor fromStrings: template.
	
	self assert: #(3 2) asTensorShape equals: tensor shape.
	self assert: (template flatCollect: #yourself as: OrderedCollection) asArray equals: tensor allStrings
]

{ #category : 'testing strings' }
TensorFlowCAPITest >> testTensorFromStringsShape [
	| template |
	template := #('hola manola' 'te traje una lola' 'pamela' 'que pandulce!' 'habia una vez' 'truz').
	self assertTensorFromStrings: template shape: #(6).
	self assertTensorFromStrings: template shape: #(3 2).
	self assertTensorFromStrings: template shape: #(1 1 6 1 1).
	self assertTensorFromStrings: #('hola como estas?') shape: #()
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorNewScalar [
	| tensor |
	tensor := TFTensor newTyped: Int64DataType new shaped: TensorShape scalar.
	tensor ignoreFinalization.
	self deny: tensor isNull.
	tensor delete.
	self assert: tensor isNull
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorShape: anArray [
	| tensor shape size |
	tensor := TFTensor newTyped: Int64DataType new shaped: anArray asTensorShape.
	self assert: tensor rank equals: anArray size.
	1 to: anArray size do: [:index |
		self assert: (tensor sizeOn: index - 1) equals: (anArray at: index)].
	shape := tensor shape.
	size := anArray isEmpty
		ifTrue: [ 1 ]
		ifFalse: [ anArray inject: 1 into: [:prev :next | prev*next] ].
	self assert: shape equals: anArray.
	self assert: tensor size equals: size
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorShape0D [
	^ self testTensorShape: #()
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorShape10D [
	^ self testTensorShape: #(1 2 3 4 5 6 7 8 9 10)
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorShape1D [
	^ self testTensorShape: #(7)
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorShape2D [
	^ self testTensorShape: #(1 4)
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorType [

	| tensor |

	tensor := TFTensor newTyped: Int64DataType new shaped: TensorShape scalar.
	self assert: tensor type equals: Int64DataType new.
	tensor := TFTensor newTyped: FloatDataType new shaped: TensorShape scalar.
	self assert: tensor type equals: FloatDataType new
]

{ #category : 'testing tensor' }
TensorFlowCAPITest >> testTensorTypes [

	| types |

	types := #(Float 1 Double 2 Int32 3 UInt8 4 Int16 5 Int8 6 String 7 Complex64 8 Int64 9 Boolean
	10 QInt8 11 QUInt8 12 QInt32 13 BFloat16 14 QInt16 15 QUInt16 16 UInt16 17 Complex128 18 Half 19
	Resource 20 Variant 21 Uint32 22 Uint64 23).
	1
		to: types size
		by: 2
		do: [:index | | name value |
			name := (types at: index) asString.
			value := types at: index + 1.
			self assert: (TensorDataType identifiedWith: value) description equals: name]
]

{ #category : 'testing library' }
TensorFlowCAPITest >> testVersion [

	| version |

	version := library version.
	self assert: version equals: '2.3.1'
]

{ #category : 'testing graph' }
TensorFlowCAPITest >> testWriteDefTo [
	| graph strm |
	graph := self constantInt64GraphFromDef.
	strm := WriteStream on: String new.
	graph writeDefTo: strm.
	self
		assert: self constantInt64GraphDef size
		equals: strm contents size
]

{ #category : 'testing graph' }
TensorFlowCAPITest >> testWriteDefToFileNamed [
	| graph filename filedata |
	filename := 'temporaryGraph.pb'.
	graph := self constantInt64GraphFromDef.
	graph writeDefToFileNamed: filename.
	filename asPath readStreamDo: [:strm | filedata := strm upToEnd].
	filename asPath delete.
	self assert: self constantInt64GraphDef size equals: filedata size
]
