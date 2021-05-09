Extension {
	#name : 'TensorFlowCAPITest'
}

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['graphs'] }
TensorFlowCAPITest >> asStringGraphType: type [
	| graph in |
	graph := TFGraph create.
	in := graph placeholder: 'in' type: type.
	graph
		asString: 'out'
		described: [ :description | description addInput: (in output: 0) ].
	^ graph
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['graphs'] }
TensorFlowCAPITest >> concatGraphInputList [
	| graph in1 in2 concat dimension dimensionValue inputs |
	graph := TFGraph create.
	dimensionValue := TFTensor fromInt32: 0.
	dimension := graph const: 'const' value: dimensionValue.
	in1 := graph placeholder: 'in1' type: TFTensor typeInt64.
	in2 := graph placeholder: 'in2' type: TFTensor typeInt64.
	inputs := Array with: (in1 output: 0) with: (in2 output: 0).
	concat := graph
		concat: 'concat'
		described: [ :description | 
			description addInput: (dimension output: 0).
			description addInputs: inputs.
			description at: 'N' putInt: 2.
			description at: 'T' putType: TFTensor typeInt64 ].
	concat.
	^ graph
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['graphs'] }
TensorFlowCAPITest >> concatGraphInputListNoSizeNoType [
	| graph in1 in2 concat dimension dimensionValue inputs |
	graph := TFGraph create.
	dimensionValue := TFTensor fromInt32: 0.
	dimension := graph const: 'const' value: dimensionValue.
	in1 := graph placeholder: 'in1' type: TFTensor typeInt64.
	in2 := graph placeholder: 'in2' type: TFTensor typeInt64.
	inputs := Array with: (in1 output: 0) with: (in2 output: 0).
	concat := graph
		concat: 'concat'
		described: [ :description | 
			description addInput: (dimension output: 0).
			description addInputs: inputs ].
	concat.
	^ graph
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['graphs'] }
TensorFlowCAPITest >> concatGraphInputListWrongSize [
	| graph in1 in2 concat dimension dimensionValue inputs |
	graph := TFGraph create.
	dimensionValue := TFTensor fromInt32: 0.
	dimension := graph const: 'const' value: dimensionValue.
	in1 := graph placeholder: 'in1' type: TFTensor typeInt64.
	in2 := graph placeholder: 'in2' type: TFTensor typeInt64.
	inputs := Array with: (in1 output: 0) with: (in2 output: 0).
	concat := graph
		concat: 'concat'
		described: [ :description | 
			description addInput: (dimension output: 0).
			description addInputs: inputs.
			description at: 'N' putInt: 0 ].
	concat.
	^ graph
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['graphs'] }
TensorFlowCAPITest >> concatGraphInputListWrongType [
	| graph in1 in2 concat dimension dimensionValue inputs |
	graph := TFGraph create.
	dimensionValue := TFTensor fromInt32: 0.
	dimension := graph const: 'const' value: dimensionValue.
	in1 := graph placeholder: 'in1' type: TFTensor typeInt64.
	in2 := graph placeholder: 'in2' type: TFTensor typeInt64.
	inputs := Array with: (in1 output: 0) with: (in2 output: 0).
	concat := graph
		concat: 'concat'
		described: [ :description | 
			description addInput: (dimension output: 0).
			description addInputs: inputs.
			description at: 'T' putType: TFTensor typeInt32 ].
	concat.
	^ graph
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['graphs'] }
TensorFlowCAPITest >> constantInt64Graph [
	| graph operation constant |
	graph := TFGraph create.
	constant := TFTensor fromInt64: 16r4242424242424242.
	self
		shouldnt: [ operation := graph const: 'a' value: constant ]
		raise: Error.
	self deny: operation isNull.
	^ graph
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['graphs'] }
TensorFlowCAPITest >> decodeCSVGraphDefaults: anArrayOfTFTensors [
	| graph records defaults |
	graph := TFGraph create.
	records := (graph placeholder: 'records' type: TFTensor typeString)
		output: 0.
	defaults := Array new: anArrayOfTFTensors size.
	1 to: anArrayOfTFTensors size do: [:index |
			| one |
			one := (graph const: 'default' , index printString value: (anArrayOfTFTensors at: index))
				output: 0.
			defaults at: index put: one ].
	graph
		newOperation: 'DecodeCSV'
		named: 'output'
		described: [ :description | 
			description addInput: records.
			description addInputs: defaults ].
	^ graph
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['graphs'] }
TensorFlowCAPITest >> floatAsStringGraph [
	| graph const |
	graph := self constantFloatGraphFromDef.
	const := graph operationNamed: 'a'.
	graph
		asString: 'output'
		described: [ :description | description addInput: (const output: 0) ].
	^ graph
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['graphs'] }
TensorFlowCAPITest >> mulGraphTwoInputsInt64ConstTensorDeleted [
	| graph constant const in1 in2 mul1 |
	graph := TFGraph create.
	constant := TFTensor fromInt64: 16r2121212121212121.
	in1 := graph placeholder: 'in1' type: constant type.
	in2 := graph placeholder: 'in2' type: constant type.
	const := graph const: 'const' value: constant.
	constant delete.
	constant := TFTensor fromInt64: 16r2222222222222222.
	constant delete.
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
	^ graph
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> runFloatAsStringGraph [
	| session graph output result |
	graph := self floatAsStringGraph.
	session := TFSession on: graph.
	output := graph operationNamed: 'output'.
	result := session runOperation: output output: (output output: 0).
	graph delete.
	^ result
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testAddControlInput [
	| graph in op result |
	graph := TFGraph create.
	in := graph const: 'const' value: (TFTensor fromInt64: 12345678).
	op := graph
		newOperation: 'Mul'
		named: 'out'
		described: [ :description | 
			description
				addInput: (in output: 0);
				addInput: (in output: 0);
				addControlInput: in].
	result := (TFSession on: graph) runOutput: (op output: 0).
	self assert: 12345678 * 12345678 equals: result allInt64s first
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testAllInitializers [
	| graph pisTensor initializers |
	graph := TFGraph create.
	pisTensor := TFTensor fromFloats: #(3.14 3.1415 3.141516).
	graph variable: 'var1' initialValue: pisTensor.
	graph variable: 'var2' initialValue: pisTensor.
	graph variable: 'var3' initialValue: pisTensor.
	initializers := graph allInitializers.
	self assert: initializers size = 3.
	self assert: 'var1_initializer' equals: initializers first name.
	self assert: 'var2_initializer' equals: initializers second name.
	self assert: 'var3_initializer' equals: initializers third name
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing graph'] }
TensorFlowCAPITest >> testAllOperations [
	| graph pisTensor operations names |
	graph := TFGraph create.
	pisTensor := TFTensor fromFloats: #(3.14 3.1415 3.141516).
	graph variable: 'var1' initialValue: pisTensor.
	graph variable: 'var2' initialValue: pisTensor.
	graph variable: 'var3' initialValue: pisTensor.
	operations := graph allOperations.
	self assert: operations size = 9.
	names := #('var1' 'var1_initialValue' 'var1_initializer' 'var2' 'var2_initialValue' 'var2_initializer' 'var3' 'var3_initialValue' 'var3_initializer').
	names
		with: operations
		do: [ :name :op | self assert: name equals: op name ]
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testAllVariables [
	| graph pisTensor var1 vars var2 var3 |
	graph := TFGraph create.
	pisTensor := TFTensor fromFloats: #(3.14 3.1415 3.141516).
	var1 := graph variable: 'var1' initialValue: pisTensor.
	var2 := graph variable: 'var2' initialValue: pisTensor.
	var3 := graph variable: 'var3' initialValue: pisTensor.
	vars := graph allVariables.
	self assert: vars size = 3.
	self assert: vars first = var1.
	self assert: vars second = var2.
	self assert: vars third = var3
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testAsStringGraphRunOn: tensor [
	| graph session in out result |
	graph := self asStringGraphType: tensor type.
	session := TFSession on: graph.
	in := graph operationNamed: 'in'.
	out := graph operationNamed: 'out'.
	result := session
		runInputs: (Array with: (in input: 0)) 
		values: (Array with: tensor)
		outputs: (Array with: (out output: 0)).
	graph delete.
	^ result first
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testAttrGetBoolFalse [
	" See https://www.tensorflow.org/api_docs/cc/struct/tensorflow/ops/as-string/attrs "
	| graph in op |
	graph := TFGraph create.
	in := graph placeholder: 'in' type: TFTensor typeDouble.
	op := graph
		asString: 'out'
		described: [ :description | description addInput: (in output: 0) ].
	self assert: (op boolAt: 'scientific') equals: false
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testAttrGetBoolTrue [
	" see https://www.tensorflow.org/api_docs/cc/struct/tensorflow/ops/gather/attrs "
	| graph in op |
	graph := TFGraph create.
	in := graph placeholder: 'in' type: TFTensor typeInt32.
	op := graph
		newOperation: 'Gather'
		named: 'out'
		described: [ :description |
			description
				addInput: (in output: 0);
				addInput: (in output: 0)				].
	self assert: (op boolAt: 'validate_indices') equals: true
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testAttrGetFloat [
	| graph in op |
	graph := TFGraph create.
	in := graph placeholder: 'in' type: TFTensor typeFloat.
	op := graph
		newOperation: 'FakeQuantWithMinMaxArgs'
		named: 'out'
		described: [ :description | description addInput: (in output: 0) ].
	self assert: (op floatAt: 'min') equals: -6.0.
	self assert: (op floatAt: 'max') equals: 6.0
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testAttrGetInt [
	| op graph |
	graph := self concatGraphInputList.
	op := graph operationNamed: 'concat'.
	self assert: (op intAt: 'N') equals: 2.
	graph delete
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testAttrGetShape [
	| graph op |
	graph := TFGraph create.
	op := graph variable: 'in' type: TFTensor typeDouble shape: (TensorShape withDimensionsSized: #(1 2 3)).
	self assert: (op shapeAt: 'shape') equals: #(1 2 3)
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testAttrGetString [
	| graph in op |
	graph := TFGraph create.
	in := graph placeholder: 'in' type: TFTensor typeDouble.
	op := graph
		newOperation: 'AsString'
		named: 'out'
		described: [ :description | description addInput: (in output: 0) ].
	self assert: (op stringAt: 'fill') equals: ''
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testAttrGetStringNotEmpty [
	| graph in op |
	graph := TFGraph create.
	in := graph placeholder: 'in' type: TFTensor typeDouble.
	op := graph
		newOperation: 'AsString'
		named: 'out'
		described: [ :description |
			description
				at: 'fill' putString: 'hola';
				addInput: (in output: 0) ].
	self assert: (op stringAt: 'fill') equals: 'hola'
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testAttrGetStrings [
	| graph template in op strings |
	graph := TFGraph create.
	template := #('hola' 'como' 'estas?').
	in := graph const: 'in' value: (TFTensor fromFloats: 1).
	op := graph
		newOperation: 'DebugIdentity'
		named: 'out'
		described: [ :description | 
			description at: 'debug_urls' putStrings: template.
			description addInput: (in output: 0) ].
	strings := op stringsAt: 'debug_urls'.
	self assert: template equals: strings
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testAttrGetTensor [
	| op graph tensor |
	graph := self constantInt64Graph.
	op := graph operationNamed: 'a'.
	tensor := op tensorAt: 'value'.
	self assert: tensor type equals: TFTensor typeInt64.
	self assert: tensor shape equals: #().
	self assert: tensor allInt64s equals: #(16r4242424242424242).
	graph delete
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testAttrGetType [
	| op graph |
	graph := self concatGraphInputList.
	op := graph operationNamed: 'concat'.
	self assert: (op typeAt: 'T') equals: TFTensor typeInt64.
	graph delete
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testAttrSetBoolFalse [
	| graph in op |
	graph := TFGraph create.
	in := graph placeholder: 'in' type: TFTensor typeInt32.
	op := graph
		newOperation: 'Gather'
		named: 'out'
		described: [ :description | 
			description
				addInput: (in output: 0);
				addInput: (in output: 0);
				at: 'validate_indices' putBoolean: false].
	self assert: (op boolAt: 'validate_indices') equals: false
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testAttrSetBoolTrue [
	| graph in op |
	graph := TFGraph create.
	in := graph placeholder: 'in' type: TFTensor typeDouble.
	op := graph
		asString: 'out'
		described: [ :description | 
			description at: 'scientific' putBoolean: true.
			description addInput: (in output: 0) ].
	self assert: (op boolAt: 'scientific') equals: true
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testAttrSetFloat [
	| graph in op min max |
	min := -1234.5678e10.
	max := 12345678e-10 asFraction.
	graph := TFGraph create.
	in := graph placeholder: 'in' type: TFTensor typeFloat.
	op := graph
		newOperation: 'FakeQuantWithMinMaxArgs'
		named: 'out'
		described: [ :description | 
			description at: 'min' putFloat: min.
			description at: 'max' putFloat: max.
			description addInput: (in output: 0) ].
	self assert: (op floatAt: 'min') closeTo: min.
	self assert: (op floatAt: 'max') closeTo: max
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testAttrSetString [
	self testAttrSetString: '1'.
	self testAttrSetString: '12'.
	self testAttrSetString: '1234'.
	self testAttrSetString: '1234567'.
	self testAttrSetString: '12345678'.
	self testAttrSetString: '123456789'.
	self testAttrSetString: ((ByteArray new: 100) atAllPut: 65) asString
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testAttrSetString: aString [
	| graph in op copy |
	graph := TFGraph create.
	copy := aString asByteArray.
	in := graph placeholder: 'in' type: TFTensor typeDouble.
	op := graph
		newOperation: 'AsString'
		named: 'out'
		described: [ :description | 
			description at: 'fill' putString: copy.
			description addInput: (in output: 0) ].
	copy at: 1 put: 65.	"Change Smalltalk String to see if TensorFlow makes a copy"
	self assert: (op stringAt: 'fill') equals: aString
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testAttrSetStrings [
	self testAttrSetStrings: #('file://./TFDebug.log').
	self
		testAttrSetStrings: #('file://./TFDebug.log' 'file://./TFDebug.2.log')
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testAttrSetStrings: aAnArrayOfStrings [
	| graph template in op |
	graph := TFGraph create.
	template := #(#(1 2 3) #(4 5 6) #(7 8 9)).
	in := graph const: 'in' value: (TFTensor fromFloats: template).
	op := graph
		newOperation: 'DebugIdentity'
		named: 'out'
		described: [ :description | 
			description
				at: 'debug_urls' putStrings: aAnArrayOfStrings;
				at: 'tensor_name' putString: 'input';
				addInput: (in output: 0) ].
	(TFSession on: graph) runOutput: (op output: 0)
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testAttrSetStringsInvalid [
	| graph template in notAList |
	graph := TFGraph create.
	template := #(#(1 2 3) #(4 5 6) #(7 8 9)).
	in := graph const: 'in' value: (TFTensor fromFloats: template).
	notAList := 'INVALID_ARGUMENT: AttrValue had value with type ''list(string)'' when ''string'' expected',
	String lf, '	 for attr ''tensor_name'''.
	self
		should: [ graph
				newOperation: 'DebugIdentity'
				named: 'out'
				described: [ :description | 
					description at: 'tensor_name' putStrings: #('hola' 'como' 'estas?').
					description addInput: (in output: 0) ] ]
		raiseError: notAList
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testConcatGraphInputList [
	| wrongSize wrongType |
	wrongSize := 'INVALID_ARGUMENT: Inconsistent values for attr ''N'' 2 vs. 0 while building NodeDef ''concat'' using Op<name=Concat; signature=concat_dim:int32, values:N*T -> output:T; attr=N:int,min=2; attr=T:type>'.
	wrongType := 'INVALID_ARGUMENT: Inconsistent values for attr ''T'' DT_INT64 vs. DT_INT32 while building NodeDef ''concat'' using Op<name=Concat; signature=concat_dim:int32, values:N*T -> output:T; attr=N:int,min=2; attr=T:type>'.
	self concatGraphInputListNoSizeNoType.
	self concatGraphInputList.
	self
		should: [ self concatGraphInputListWrongSize ]
		raiseError: wrongSize.
	self
		should: [ self concatGraphInputListWrongType ]
		raiseError: wrongType
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testCreateGraphAddTwoInputs [
	| graph |
	graph := self addGraphTwoInputsInt64.
	graph delete
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testCreateGraphMulOneInput [
	| graph input mul |
	graph := self mulGraphOneInputInt64.
	self shouldnt: [ input := graph operationNamed: 'in' ] raise: Error.
	self shouldnt: [ mul := graph operationNamed: 'mul' ] raise: Error.
	self assert: input name equals: 'in'.
	self assert: mul name equals: 'mul'.
	graph delete
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testDecodeCSVGraphCreate [
	| defaults |
	defaults := (Array new: 4)
		at: 1 put: (TFTensor fromInt64s: #(-1));
		at: 2 put: (TFTensor fromInt64s: #(-1));
		at: 3 put: (TFTensor fromInt64s: #(-1));
		at: 4 put: (TFTensor fromInt64s: #(-1));
		yourself.
	self decodeCSVGraphDefaults: defaults
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testDecodeCSVGraphRunManyLines [
	| cols |
	cols := self
		testDecodeCSVGraphRunCSV:
			'1,2,3,4
	 11,22,33,44
	 111,222,333,444
	 1111,2222,3333,4444' lines.
	self assert: cols first equals: #(1 11 111 1111).
	self assert: cols second equals: #(2 22 222 2222).
	self assert: cols third equals: #(3 33 333 3333).
	self assert: cols fourth equals: #(4 44 444 4444)
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testDecodeCSVGraphRunOneLine [
	| cols |
	cols := self
		testDecodeCSVGraphRunCSV: '11111111111,22222222,33333333,44444444' lines.
	self assert: cols first equals: #(11111111111).
	self assert: cols second equals: #(22222222).
	self assert: cols third equals: #(33333333).
	self assert: cols fourth equals: #(44444444)
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testDescriptionDevice [
	| graph in op expected |
	graph := TFGraph create.
	in := graph const: 'const' value: (TFTensor fromInt64: 12345678).
	op := graph
		newOperation: 'Mul'
		named: 'out'
		described: [ :description | 
			description
				device: 'anInvalidDevice';
				addInput: (in output: 0);
				addInput: (in output: 0) ].
	expected := 'INVALID_ARGUMENT: Malformed device specification ''anInvalidDevice'''.
	self
		should: [ (TFSession on: graph) runOutput: (op output: 0) ]
		raiseError: expected
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testFloatAsStringGraphCreate [
	self floatAsStringGraph
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testFloatAsStringGraphRun [
	| result str expected |
	expected := '0.420000'.
	result := self runFloatAsStringGraph.
	self deny: result isNull.
	self deny: result data isNull.
	str := result dataBytes.
	self assert: 8 + 1 + expected size equals: str size.
	self assert: (str uint64At: 0) equals: 0.
	self assert: (str at: 9) equals: expected size.
	self
		assert: (str memcpyStringFrom: 9 to: expected size + 9 - 1)
		equals: expected.
	result delete
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing tensor'] }
TensorFlowCAPITest >> testGet2x2FloatFromGraphDef [
	| templates consts |
	templates := #(-1.1 -2.1 -1.2 -2.2).
	consts := self get2x2FloatFromGraphDef allFloats.
	templates
		with: consts
		do: [ :temp :const | self assert: temp closeTo: const ]
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing library'] }
TensorFlowCAPITest >> testGetAllOps [
	| ops |
	ops := library getAllOps.
	self assert: (ops dataBytes asString includesSubString: 'tensor').
	ops delete
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testGetAttrMetadataBoolean [
	| graph in op template metadata |
	template := '1234567890abc'.
	graph := TFGraph create.
	in := graph placeholder: 'in' type: TFTensor typeDouble.
	op := graph
		newOperation: 'AsString'
		named: 'out'
		described: [ :description | 
			description at: 'fill' putString: template.
			description addInput: (in output: 0) ].
	metadata := op attrMetadata: 'scientific'.
	self assert: metadata isBoolean.
	self assert: metadata isList equals: false
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testGetAttrMetadataFloat [
	| graph in op metadata |
	graph := TFGraph create.
	in := graph placeholder: 'in' type: TFTensor typeFloat.
	op := graph
		newOperation: 'FakeQuantWithMinMaxArgs'
		named: 'out'
		described: [ :description | description addInput: (in output: 0) ].
	metadata := op attrMetadata: 'min'.
	self assert: metadata isFloat.
	self assert: metadata isList equals: false
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testGetAttrMetadataInt [
	| graph in op template metadata |
	template := '1234567890abc'.
	graph := TFGraph create.
	in := graph placeholder: 'in' type: TFTensor typeDouble.
	op := graph
		newOperation: 'AsString'
		named: 'out'
		described: [ :description | 
			description at: 'fill' putString: template.
			description addInput: (in output: 0) ].
	metadata := op attrMetadata: 'precision'.
	self assert: metadata isInt.
	self assert: metadata isList equals: false
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testGetAttrMetadataShape [
	| graph op template metadata |
	template := #(1 2 3 4 5) asTensorShape.
	graph := TFGraph create.
	op := graph
		newOperation: 'Placeholder'
		named: 'const'
		described: [ :description | 
			description at: 'shape' putShape: template.
			description at: 'dtype' putType: TFTensor typeInt64 ].
	metadata := op attrMetadata: 'shape'.
	self assert: metadata isShape.
	self assert: metadata isList equals: false.
	self assert: metadata totalSize equals: template size
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testGetAttrMetadataString [
	| graph in op template metadata |
	template := '1234567890abc'.
	graph := TFGraph create.
	in := graph placeholder: 'in' type: TFTensor typeDouble.
	op := graph
		newOperation: 'AsString'
		named: 'out'
		described: [ :description | 
			description at: 'fill' putString: template.
			description addInput: (in output: 0) ].
	self assert: (op stringAt: 'fill') equals: template.
	metadata := op attrMetadata: 'fill'.
	self assert: metadata isString.
	self assert: metadata isList equals: false.
	self assert: metadata totalSize equals: template size
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testGetAttrMetadataTensor [
	| graph op template metadata |
	template := #(1 2 3 4 5).
	graph := TFGraph create.
	op := graph const: 'const' value: (TFTensor fromInt64s: template).
	metadata := op attrMetadata: 'value'.
	self assert: metadata isTensor.
	self assert: metadata isList equals: false
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing gradients'] }
TensorFlowCAPITest >> testGradientTwoInputs [
	| graph x1 x2 y dy grad |
	graph := TFGraph fromBlock: [:input1 :input2 |
		x1 := input1.
		x2 := input2.
		y := x1 @* x2].
	dy := graph
		gradientsOf: (Array with: y firstOutput)
		withRespectTo: (Array with: x1 firstOutput).
	grad := graph
		runInputs: (Array with: x1 firstInput with: x2 firstInput)
		values: (Array with: 3.0 asTensor with: 7.0 asTensor)
		outputs: (Array with: dy first).
	self assert: grad first asNumbers equals: 7.0.

	dy := graph
		gradientsOf: (Array with: y firstOutput)
		withRespectTo: (Array with: x2 firstOutput).
	grad := graph
		runInputs: (Array with: x1 firstInput with: x2 firstInput)
		values: (Array with: 3.0 asTensor with: 7.0 asTensor)
		outputs: (Array with: dy first).
	self assert: grad first asNumbers equals: 3.0.

	dy := graph
		gradientsOf: (Array with: y firstOutput)
		withRespectTo: (Array with: x1 firstOutput with: x2 firstOutput).
	grad := graph
		runInputs: (Array with: x1 firstInput with: x2 firstInput)
		values: (Array with: 3.0 asTensor with: 7.0 asTensor)
		outputs: (Array with: dy first with: dy second).
	self assert: grad first asNumbers equals: 7.0.
	self assert: grad second asNumbers equals: 3.0.
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing gradients'] }
TensorFlowCAPITest >> testGradientTwoInputsTwoOutputs [
	| graph x1 x2 y1 y2 dy grad |
	graph := TFGraph fromBlock: [:input1 :input2 |
		x1 := input1.
		x2 := input2.
		y1 := x1 @* x2.
		y2 := x1 + x2].
		
	dy := graph
		gradientsOf: (Array with: y1 firstOutput)
		withRespectTo: (Array with: x1 firstOutput).
	grad := graph
		runInputs: (Array with: x1 firstInput with: x2 firstInput)
		values: (Array with: 3.0 asTensor with: 7.0 asTensor)
		outputs: (Array with: dy first).
	self assert: grad first asNumbers equals: 7.0.

	dy := graph
		gradientsOf: (Array with: y1 firstOutput with: y2 firstOutput)
		withRespectTo: (Array with: x2 firstOutput).
	grad := graph
		runInputs: (Array with: x1 firstInput with: x2 firstInput)
		values: (Array with: 3.0 asTensor with: 7.0 asTensor)
		outputs: (Array with: dy first).
	self assert: grad first asNumbers equals: 3.0+1.0.

	dy := graph
		gradientsOf: (Array with: y1 firstOutput with: y2 firstOutput)
		withRespectTo: (Array with: x1 firstOutput with: x2 firstOutput).
	grad := graph
		runInputs: (Array with: x1 firstInput with: x2 firstInput)
		values: (Array with: 3.0 asTensor with: 7.0 asTensor)
		outputs: (Array with: dy first with: dy second).
	self assert: grad first asNumbers equals: 7.0+1.0.
	self assert: grad second asNumbers equals: 3.0+1.0.
	
	graph writeDefToFileNamed: 'grad.pb'
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testGraphCreationConst [
	| graph operation |
	graph := self constantInt64Graph.
	operation := graph operationNamed: 'a'.
	self assert: operation type equals: 'Const'.
	self assert: operation name equals: 'a'.
	self assert: operation inputsCount equals: 0.
	self assert: operation outputsCount equals: 1
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing graph'] }
TensorFlowCAPITest >> testGraphFromBlockIdentity [
	| graph output inputs results |
	graph := TFGraph fromBlock: [ :a | a ].
	inputs := graph allInputs
		collect: [ :placeholder | placeholder input: 0 ].
	output := graph operationNamed: 'output'.
	results := (TFSession on: graph)
		runInputs: inputs
		values:
			((Array new: 1)
				at: 1 put: (TFTensor fromFloats: 3.1415);
				yourself)
		outputs:
			((Array new: 1)
				at: 1 put: (output output: 0);
				yourself).
	self assert: results first allFloats first closeTo: 3.1415
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing graph'] }
TensorFlowCAPITest >> testGraphFromBlockIdentityInstance [
	| graph output inputs results |
	graph := TFGraph create.
	output := graph fromBlock: [ :a | a alias: 'a_1' ].
	inputs := graph allInputs collect: [ :input | input input: 0 ].
	results := (TFSession on: graph)
		runInputs: inputs
		values:
			((Array new: 1)
				at: 1 put: (TFTensor fromFloats: 3.1415);
				yourself)
		outputs:
			((Array new: 1)
				at: 1 put: (output output: 0);
				yourself).
	self assert: results first allFloats first closeTo: 3.1415
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing graph'] }
TensorFlowCAPITest >> testGraphFromBlockSimple [
	| graph output inputs results |
	graph := TFGraph fromBlock: [ :a :b | a + b ].
	inputs := graph allInputs
		collect: [ :placeholder | placeholder input: 0 ].
	output := graph operationNamed: 'output'.
	results := (TFSession on: graph)
		runInputs: inputs
		values:
			((Array new: 2)
				at: 1 put: (TFTensor fromFloats: 3.1415);
				at: 2 put: (TFTensor fromFloats: 1.2345);
				yourself)
		outputs:
			((Array new: 1)
				at: 1 put: (output output: 0);
				yourself).
	self assert: results first allFloats first closeTo: 3.1415 + 1.2345
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing graph'] }
TensorFlowCAPITest >> testGraphFromBlockSimpleInstance [
	| graph output inputs results |
	graph := TFGraph create.
	output := graph fromBlock: [ :a :b | a + b ].
	inputs := graph allInputs
		collect: [ :placeholder | placeholder input: 0 ].
	results := (TFSession on: graph)
		runInputs: inputs
		values:
			((Array new: 2)
				at: 1 put: (TFTensor fromFloats: 3.1415);
				at: 2 put: (TFTensor fromFloats: 1.2345);
				yourself)
		outputs:
			((Array new: 1)
				at: 1 put: (output output: 0);
				yourself).
	self assert: results first allFloats first closeTo: 3.1415 + 1.2345
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing graph'] }
TensorFlowCAPITest >> testGraphFromBlockSimpler [
	| graph output inputs results |
	graph := TFGraph fromBlock: [ :a :b | a + b ].
	inputs := graph allInputs
		collect: [ :placeholder | placeholder input: 0 ].
	output := graph operationNamed: 'output'.
	results := graph
		runInputs: inputs
		values: (Array with: 3.1415 asFloatTensor with: 1.2345 asFloatTensor)
		outputs: (Array with: output firstOutput).
	self assert: results first allFloats first closeTo: 3.1415 + 1.2345
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing graph'] }
TensorFlowCAPITest >> testGraphFromBlockSimplerer [
	| graph output inputs results |
	graph := TFGraph fromBlock: [ :a :b |
		inputs := Array with: a firstInput with: b firstInput.
		output := a + b ].
		
	results := graph
		runInputs: inputs
		values: (Array with: 3.1415 asFloatTensor with: 1.2345 asFloatTensor)
		outputs: (Array with: output firstOutput).
		
	self assert: results first allFloats first closeTo: 3.1415 + 1.2345
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing graph'] }
TensorFlowCAPITest >> testGraphRunOutput [
	| graph output result |
	graph := TFGraph create.
	output := graph const: TFTensor pi.
	result := graph runOutput: output firstOutput.
	self assert: Float pi closeTo: result asNumbers
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testInt64AsStringGraph [
	| result tensor |
	tensor := TFTensor fromInt64: 101010101.
	result := self testAsStringGraphRunOn: tensor.
	self assert: result allStrings first equals: '101010101'.
	result delete
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testInt64rrayAsStringGraph [
	| result tensor strings template |
	template := #(101010101 -123321 1 2 3 4).
	tensor := TFTensor fromInt64s: template.
	result := self testAsStringGraphRunOn: tensor.
	strings := result allStrings.
	1 to: strings size do: [:index |
		self assert: (strings at: index) equals: (template at: index) asString ].
	result delete
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testNewOperationMul [
	| graph operation a b |
	graph := TFGraph create.
	a := graph placeholder: 'a' type: TFTensor typeInt64.
	b := graph placeholder: 'b' type: TFTensor typeInt64.
	operation := graph
		mul: 'aMultiplication'
		described: [ :description | 
			description addInputFromOutput: 0 of: a.
			description addInputFromOutput: 0 of: b ].
	self assert: operation type equals: 'Mul'.
	self assert: operation name equals: 'aMultiplication'.
	self assert: operation inputsCount equals: 2.
	self assert: operation outputsCount equals: 1.
	operation := graph operationNamed: 'aMultiplication'.
	self assert: operation type equals: 'Mul'.
	self assert: operation name equals: 'aMultiplication'.
	self assert: operation inputsCount equals: 2.
	self assert: operation outputsCount equals: 1
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testNewOperationPlaceholder [
	| graph operation |
	graph := TFGraph create.
	self
		shouldnt: [ operation := graph
				placeholder: 'aPlaceholder'
				type: TFTensor typeInt64 ]
		raise: Error.
	self assert: operation type equals: 'Placeholder'.
	self assert: operation name equals: 'aPlaceholder'.
	self assert: operation inputsCount equals: 0.
	self assert: operation outputsCount equals: 1.
	operation := graph operationNamed: 'aPlaceholder'.
	self assert: operation type equals: 'Placeholder'.
	self assert: operation name equals: 'aPlaceholder'.
	self assert: operation inputsCount equals: 0.
	self assert: operation outputsCount equals: 1
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testNewVariableForTensor [
	| graph var assign result session pisTensor pis |
	graph := TFGraph create.
	pisTensor := TFTensor fromFloats: #(3.14 3.1415 3.141516).
	var := graph variable: 'var' forTensor: pisTensor.
	pis := graph const: 'pis' value: pisTensor.
	assign := graph
		newOperation: 'Assign'
		named: 'assign'
		described: [ :description | 
			description
				addInput: (var output: 0);
				addInput: (pis output: 0) ].
	session := TFSession on: graph.
	session runOutput: (assign output: 0).
	result := session runOutput: (var output: 0).
	self assert: result allFloats equals: pisTensor allFloats
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testNewVariableInitialization [
	| graph var assign pi result session |
	graph := TFGraph create.
	var := graph variable: 'var' type: TFTensor typeFloat shape: #().
	pi := graph const: 'pi' value: (TFTensor fromFloats: 3.14).
	assign := graph
		newOperation: 'Assign'
		named: 'assign'
		described: [ :description | 
			description
				addInput: (var output: 0);
				addInput: (pi output: 0) ].
	session := TFSession on: graph.
	session runOutput: (assign output: 0).
	result := session runOutput: (var output: 0).
	self assert: result allFloats first closeTo: 3.14
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testNewVariableInitializationNodeNotRun [
	| graph var pi lastError |
	graph := TFGraph create.
	var := graph variable: 'var' type: TFTensor typeFloat shape: #().
	pi := graph const: 'pi' value: (TFTensor fromFloats: 3.14).
	graph
		newOperation: 'Assign'
		named: 'assign'
		described: [ :description | 
			description
				addInput: var firstOutput;
				addInput: pi firstOutput ].
	self
		should: [(TFSession on: graph) runOutput: var firstOutput]
		raiseError: 'Attempting to use uninitialized value var'
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testNewVariableInitialValue [
	| graph var assign result session pisTensor |
	graph := TFGraph create.
	pisTensor := TFTensor fromFloats: #(3.14 3.1415 3.141516).
	var := graph variable: 'var' initialValue: pisTensor.
	assign := graph operationNamed: 'var_initializer'.
	session := TFSession on: graph.
	session runOutput: (assign output: 0).
	result := session runOutput: (var output: 0).
	self assert: result allFloats equals: pisTensor allFloats
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testNewVariableInitialValueAutomaticInitialization [
	| graph var result session pisTensor |
	graph := TFGraph create.
	pisTensor := TFTensor fromFloats: #(3.14 3.1415 3.141516).
	var := graph variable: 'var' initialValue: pisTensor.
	session := TFSession on: graph.
	graph initializeOn: session.
	result := session runOutput: (var output: 0).
	self assert: result allFloats equals: pisTensor allFloats
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testNewVariableNoInitialization [
	| graph var expectedError lastError |
	graph := TFGraph create.
	var := graph variable: 'var' type: TFTensor typeFloat shape: #().
	self
		should: [(TFSession on: graph) runOutput: var firstOutput]
		raiseError: 'Attempting to use uninitialized value var'.
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testOperationAsOperationDifferentGraph [
	| const graph1 graph2 |
	graph1 := TFGraph create.
	graph2 := TFGraph create.
	const := graph1 const: 1.0 asTensor.
	self
		should: [ const asOperationOn: graph2 ]
		raiseError: 'Can''t move an operation to another Graph'
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testOperationAsOperationOk [
	| const1 const2 graph |
	graph := TFGraph create.
	const1 := graph const: 1.0 asTensor.
	const2 := const1 asOperationOn: graph.
	self assert: const1 == const2
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testOperationEquals [
	| graph in1 |
	graph := TFGraph create.
	in1 := graph placeholder: 'in1' type: TFTensor typeFloat.
	self assert: in1 = in1.
	self deny: in1 = 'in1'
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testPlaceholderType: type [
	| graph var session result tensor abs |
	graph := TFGraph create.
	tensor := TFTensor newTyped: type shaped: TensorShape scalar.
	var := graph placeholder: 'var' type: type.
	abs := graph
		newOperation: 'Abs'
		named: 'abs'
		described: [ :description | description addInput: (var output: 0) ].
	session := TFSession on: graph.
	result := session
		runInputs: (Array with: (var input: 0))
		values: (Array with: tensor)
		outputs: (Array with: (abs output: 0)).
	result delete
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testPlaceholderTypes [
	self testPlaceholderType: TFTensor typeInt64.
	self testPlaceholderType: TFTensor typeInt32.
	self testPlaceholderType: TFTensor typeFloat
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testRankOfOutput [
	| graph template const rank |
	graph := TFGraph create.
	template := TFTensor
		fromFloats: #(#(#(1) #(2) #(3)) #(#(4) #(5) #(6))).
	const := graph const: 'const' value: template.
	rank := graph rankOf: (const output: 0).
	self assert: template shape size equals: rank
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testShapeOfInput [
	| graph template const shape same |
	graph := TFGraph create.
	template := TFTensor
		fromFloats: #(#(#(1) #(2) #(3)) #(#(4) #(5) #(6))).
	const := graph const: 'const' value: template.
	same := const identity.
	shape := graph shapeOf: (same input: 0).
	self assert: template shape equals: shape
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testShapeOfOutput [
	| graph template const shape |
	graph := TFGraph create.
	template := TFTensor
		fromFloats: #(#(#(1) #(2) #(3)) #(#(4) #(5) #(6))).
	const := graph const: 'const' value: template.
	shape := graph shapeOf: (const output: 0).
	self assert: template shape equals: shape
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testShapeOfOutputSet [
	| graph var shape output |
	graph := TFGraph create.
	var := graph
		newOperation: 'Placeholder'
		named: 'var'
		described: [ :description | 
			description
				at: 'dtype' putType: TFTensor typeInt64;
				at: 'shape' putShape: #(3 -1 -1) asTensorShape].
	output := var output: 0.
	shape := graph shapeOf: output.
	self assert: shape equals: #(3 -1 -1) asTensorShape.
	graph shapeOf: output set: #(-1 3 -1).
	shape := graph shapeOf: output.
	self assert: shape equals: #(3 3 -1) asTensorShape
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testShapeOfOutputSetInvalid [
	| graph template const output |
	graph := TFGraph create.
	template := TFTensor
		fromFloats: #(#(#(1) #(2) #(3)) #(#(4) #(5) #(6))).
	const := graph const: 'const' value: template.
	output := const output: 0.
	self
		should: [ graph shapeOf: output set: #(1 2 3) ]
		raiseError:
			'INVALID_ARGUMENT: Dimension 0 in both shapes must be equal, but are 2 and 1'
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing operation'] }
TensorFlowCAPITest >> testShapeOfOutputSetInvalidRank [
	| graph template const output |
	graph := TFGraph create.
	template := TFTensor
		fromFloats: #(#(#(1) #(2) #(3)) #(#(4) #(5) #(6))).
	const := graph const: 'const' value: template.
	output := const output: 0.
	self
		should: [ graph shapeOf: output set: #(1 2 3 -1) ]
		raiseError: 'INVALID_ARGUMENT: Shapes must be equal rank, but are 3 and 4'
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing tensor'] }
TensorFlowCAPITest >> testTensorAllStrings [
	| result strings expected |
	expected := #('0.420000').
	result := self runFloatAsStringGraph.
	strings := result allStrings.
	self assert: strings equals: expected.
	result delete
]
