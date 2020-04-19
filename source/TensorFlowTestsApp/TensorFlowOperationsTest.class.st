Class {
	#name : 'TensorFlowOperationsTest',
	#superclass : 'TensorFlowTestCase',
	#instVars : [
		'library'
	],
	#category : 'TensorFlowTestsApp'
}

{ #category : 'other operations' }
TensorFlowOperationsTest >> assert: integers sizeOn: dimension is: expected [
	| graph session const result size |
	graph := TFGraph create.
	const := graph const: integers asInt32Tensor.
	size := const sizeOn: dimension.
	session := TFSession on: graph.
	result := session runOutput: size firstOutput.
	self assert: expected equals: result asNumbers
]

{ #category : 'other operations' }
TensorFlowOperationsTest >> assertSlice: integers from: begin size: size is: expected [
	| graph session const result slice |
	graph := TFGraph create.
	const := graph const: integers asInt32Tensor.
	slice := const
		sliceFrom: begin asInt32Tensor
		size: size asInt32Tensor.
	session := TFSession on: graph.
	result := session runOutput: slice firstOutput.
	self assert: expected equals: result asNumbers
]

{ #category : 'initialization' }
TensorFlowOperationsTest >> expectedFailures [
	^ #(
		testOperationMatMulABTransposed
	)
]

{ #category : 'private' }
TensorFlowOperationsTest >> percentile: percent from: collection [
	| position sorted |
	position := (collection size * percent) ceiling.
	sorted := collection sorted: nil.
	^ sorted at: position
]

{ #category : 'initialization' }
TensorFlowOperationsTest >> setUp [
	library := TensorFlowCAPI current
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testGraphTruncatedNormal [
	| graph session result random values std theoreticalDecile expected |
	graph := TFGraph create.
	random := graph truncatedNormalRandomShaped: #(100 100 10).
	session := TFSession on: graph.
	result := session runOutput: (random output: 0).
	values := result allFloats.
	theoreticalDecile := -1.1840324666939051.
	std := values standardDeviation.
	self assert: result shape equals: #(100 100 10).
	self assert: values size equals: 100 * 100 * 10.
	self assert: values min + 2 < 0.01.
	self assert: 2 - values max < 0.01.
	self assert: values mean abs < (0.01 * std).
	expected := (Array new: 2)
		at: 1 put: theoreticalDecile;
		at: 2 put: theoreticalDecile negated;
		yourself.
	#(0.1 0.9)
		with: expected
		do: [ :p :e | 
			| observed |
			observed := self percentile: p from: values.
			self assert: (observed - e) abs < 0.2 ]
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testGraphTruncatedNormalStddev [
	| graph session result random values sigma twoSigma std theoreticalDecile expected |
	graph := TFGraph create.
	sigma := 3.14.
	twoSigma := 2 * sigma.
	random := graph
		truncatedNormalRandomShaped: #(100 100 10)
		stddev: sigma.
	session := TFSession on: graph.
	result := session runOutput: (random output: 0).
	values := result allFloats.
	std := values standardDeviation.
	theoreticalDecile := -1.1840324666939051.
	self assert: result shape equals: #(100 100 10).
	self assert: values size equals: 100 * 100 * 10.
	self assert: twoSigma - values min abs < 0.1.
	self assert: twoSigma - values max < 0.1.
	self assert: values mean abs < (0.01 * std).
	expected := (Array new: 4)
		at: 1 put: theoreticalDecile * sigma;
		at: 2 put: theoreticalDecile negated * sigma;
		at: 3 put: -2;
		at: 4 put: 2;
		yourself.
	#(0.1 0.9 0.25 0.75)
		with: expected
		do: [ :p :e | 
			| observed |
			observed := self percentile: p from: values.
			self assert: (observed - e) abs < 0.2 ]
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testGraphUnnamedConst [
	| graph session result const |
	graph := TFGraph create.
	const := graph const: #(1 2 3 4) asFloatTensor.
	session := TFSession on: graph.
	result := session runOutput: (const output: 0).
	self assert: result shape equals: #(4).
	self assert: result allFloats equals: #(1 2 3 4)
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testGraphVariableFromTruncatedNormalStddev [
	| graph session result1 result2 var random values1 values2 init sigma std twoSigma |
	graph := TFGraph create.
	sigma := 3.14.
	twoSigma := 2 * sigma.
	random := graph
		truncatedNormalRandomShaped: #(100 100 10)
		stddev: sigma.
	var := graph variable: 'var' initialValueFrom: random.
	session := TFSession on: graph.
	init := graph operationNamed: 'var_initializer'.
	result1 := session runOutput: (init output: 0).
	result2 := session runOutput: (var output: 0).
	self assert: result1 shape equals: #(100 100 10).
	values1 := result1 allFloats.
	std := values1 standardDeviation.
	self assert: values1 size equals: 100 * 100 * 10.
	self assert: twoSigma - values1 min abs < 0.1.
	self assert: twoSigma - values1 max < 0.1.
	self assert: values1 mean abs < (0.01 * std).
	self assert: result1 shape equals: result2 shape.
	values2 := result2 allFloats.
	self assert: values1 equals: values2
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testGraphZeros [
	| graph session result zeros values |
	graph := TFGraph create.
	zeros := graph zerosShaped: #(100 100 10).
	session := TFSession on: graph.
	result := session runOutput: (zeros output: 0).
	values := result allFloats.
	self assert: #(100 100 10) equals: result shape.
	self assert: 100 * 100 * 10 equals: values size.
	self assert: 0 equals: values min.
	self assert: 0 equals: values max
]

{ #category : 'unary operations' }
TensorFlowOperationsTest >> testOperationAbs [
	| graph template session const result output |
	template := TFTensor fromFloats: #(#(-1.1 1.2) #(-2.1 -2.2)).
	graph := TFGraph create.
	const := graph const: 'const' value: template.
	output := const abs output: 0.
	session := TFSession on: graph.
	result := session runOutput: output.
	self assert: result shape equals: template shape.
	self assert: result allFloats equals: template allFloats abs.
	output free
]

{ #category : 'unary operations' }
TensorFlowOperationsTest >> testOperationAcos [
	| graph template session const result output intput |
	template := #(1.1 0.2 2.34 0.717273).
	intput := TFTensor fromFloats: template cos.
	graph := TFGraph create.
	const := graph const: 'const' value: intput.
	output := const arcCos output: 0.
	session := TFSession on: graph.
	result := session runOutput: output.
	self assert: result shape equals: intput shape.
	result allFloats
		with: template
		do: [ :res :temp | self assert: res closeTo: temp ].
	output free
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testOperationArgMax [
	| graph a session const result output0 output1 axis0 axis1 |
	a := TFTensor fromFloats: #(#(1.1 1.2) #(2.1 2.2) #(3.1 0.2)).
	graph := TFGraph create.
	const := graph const: 'a' value: a.
	axis0 := graph const: 'axis0' value: (TFTensor fromInt32: 0).
	axis1 := graph const: 'axis1' value: (TFTensor fromInt32: 1).
	output0 := const findMaxOn: axis0.
	output1 := const findMaxOn: axis1.
	session := TFSession on: graph.
	result := session runOutput: (output0 output: 0).
	self assert: result shape equals: #(2).
	result allInt64s
		with: #(2 1)
		do: [ :r :t | self assert: r equals: t ].
	result := session runOutput: (output1 output: 0).
	self assert: result shape equals: #(3).
	result allInt64s
		with: #(1 1 0)
		do: [ :r :t | self assert: r equals: t ]
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testOperationArgMin [
	| graph a session const result output0 output1 axis0 axis1 |
	a := TFTensor fromFloats: #(#(1.1 1.2) #(2.1 2.2) #(3.1 0.2)).
	graph := TFGraph create.
	const := graph const: 'a' value: a.
	axis0 := graph const: 'axis0' value: (TFTensor fromInt32: 0).
	axis1 := graph const: 'axis1' value: (TFTensor fromInt32: 1).
	output0 := const findMinOn: axis0.
	output1 := const findMinOn: axis1.
	session := TFSession on: graph.
	result := session runOutput: (output0 output: 0).
	self assert: result shape equals: #(2).
	result allInt64s
		with: #(0 2)
		do: [ :r :t | self assert: r equals: t ].
	result := session runOutput: (output1 output: 0).
	self assert: result shape equals: #(3).
	result allInt64s
		with: #(0 0 1)
		do: [ :r :t | self assert: r equals: t ]
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testOperationArgMinTwoOutputs [
	| graph a session const results first second output0 output1 axis0 axis1 |
	a := TFTensor fromFloats: #(#(1.1 1.2) #(2.1 2.2) #(3.1 0.2)).
	graph := TFGraph create.
	const := graph const: 'a' value: a.
	axis0 := graph const: 'axis0' value: (TFTensor fromInt32: 0).
	axis1 := graph const: 'axis1' value: (TFTensor fromInt32: 1).
	output0 := (const findMinOn: axis0) output: 0.
	output1 := (const findMinOn: axis1) output: 0.
	session := TFSession on: graph.
	results := session
		runOutputs:
			((Array new: 2)
				at: 1 put: output0;
				at: 2 put: output1;
				yourself).
	first := results at: 1.
	second := results at: 2.
	self assert: first shape equals: #(2).
	first allInt64s with: #(0 2) do: [ :r :t | self assert: r equals: t ].
	self assert: second shape equals: #(3).
	second allInt64s
		with: #(0 0 1)
		do: [ :r :t | self assert: r equals: t ]
]

{ #category : 'unary operations' }
TensorFlowOperationsTest >> testOperationAsin [
	| graph template session const result output intput |
	template := #(1.1 0.2 -1.34 0.717273).
	intput := TFTensor fromFloats: template sin.
	graph := TFGraph create.
	const := graph const: 'const' value: intput.
	output := const arcSin output: 0.
	session := TFSession on: graph.
	result := session runOutput: output.
	self assert: result shape equals: intput shape.
	result allFloats
		with: template
		do: [ :res :temp | self assert: res closeTo: temp ].
	output free
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testOperationAssignSub [
	| graph var output pi result session |
	graph := TFGraph create.
	var := graph variable: 'var' initialValue: 1.0 asTensor.
	pi := graph const: 'pi' value: TFTensor pi.
	output := var -= pi.
	session := TFSession on: graph.
	graph initializeOn: session.
	result := session runOutput: (output output: 0).
	self assert: 1 - Float pi closeTo: result allFloats first
]

{ #category : 'unary operations' }
TensorFlowOperationsTest >> testOperationAtan [
	| graph template session const result output intput |
	template := #(1.1 0.2 -1.34 0.717273).
	intput := TFTensor fromFloats: template tan.
	graph := TFGraph create.
	const := graph const: 'const' value: intput.
	output := const arcTan output: 0.
	session := TFSession on: graph.
	result := session runOutput: output.
	self assert: result shape equals: intput shape.
	result allFloats
		with: template
		do: [ :res :temp | self assert: res closeTo: temp ].
	output free
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testOperationCastTo [
	| graph template cast input result |
	template := #(#(1.1 1.2) #(2.1 2.2)).
	graph := TFGraph create.
	input := graph const: template asFloatTensor.
	cast := input castTo: TFTensor typeInt32.
	result := graph runOutput: cast firstOutput.
	self assert: template truncated equals: result asNumbers
]

{ #category : 'unary operations' }
TensorFlowOperationsTest >> testOperationCos [
	| graph template session const result output intput |
	template := #(0.1 0.0 -0.94 0.717273).
	intput := TFTensor fromFloats: template.
	graph := TFGraph create.
	const := graph const: 'const' value: intput.
	output := const cos output: 0.
	session := TFSession on: graph.
	result := session runOutput: output.
	self assert: result shape equals: intput shape.
	result allFloats
		with: template cos
		do: [ :res :temp | self assert: res closeTo: temp ].
	output free
]

{ #category : 'other operations' }
TensorFlowOperationsTest >> testOperationDescentRate [
	| graph var output pi result session rate |
	graph := TFGraph create.
	var := graph variable: 'var' initialValue: 1.0 asTensor.
	pi := graph const: 'pi' value: TFTensor pi.
	rate := graph const: 'rate' value: 0.7 asTensor.
	output := var descent: pi rate: rate.
	session := TFSession on: graph.
	graph initializeOn: session.
	result := session runOutput: (output output: 0).
	self assert: 1 - (Float pi * 0.7) closeTo: result allFloats first
]

{ #category : 'other operations' }
TensorFlowOperationsTest >> testOperationDescentRateConstants [
	| graph var output pi result session rate |
	graph := TFGraph create.
	var := graph variable: 'var' initialValue: 1.0 asTensor.
	pi := Float pi asTensor.
	rate := 0.7 asTensor.
	output := var descent: pi rate: rate.
	session := TFSession on: graph.
	graph initializeOn: session.
	result := session runOutput: (output output: 0).
	self assert: 1 - (Float pi * 0.7) closeTo: result allFloats first
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testOperationDiv [
	| graph a b session constA constB result output template |
	a := TFTensor fromFloats: #(#(1.1 1.2) #(2.1 2.2)).
	b := TFTensor fromFloats: #(#(2.0 4.0) #(8.0 16.0)).
	graph := TFGraph create.
	constA := graph const: 'a' value: a.
	constB := graph const: 'b' value: b.
	output := constA @/ constB.
	template := a allFloats / b allFloats.
	session := TFSession on: graph.
	result := session runOutput: (output output: 0).
	self assert: result shape equals: a shape.
	result allFloats
		with: template
		do: [ :r :t | self assert: r closeTo: t ]
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testOperationDivScalar [
	| graph a b session constA constB result div template |
	a := TFTensor fromFloats: #(#(1.1 1.2) #(2.1 2.2)).
	b := TFTensor fromFloats: 2.0.
	graph := TFGraph create.
	constA := graph const: 'a' value: a.
	constB := graph const: 'b' value: b.
	div := constA @/ constB.
	template := a allFloats collect: [:each  | each / 2.0].
	session := TFSession on: graph.
	result := session runOutput: (div output: 0).
	self assert: result shape equals: a shape.
	result allFloats
		with: template
		do: [ :r :t | self assert: r closeTo: t ]
]

{ #category : 'unary operations' }
TensorFlowOperationsTest >> testOperationExp [
	| graph inputs template session const result output |
	template := #(-1.1 1.2).
	inputs := TFTensor fromFloats: template.
	graph := TFGraph create.
	const := graph const: 'const' value: inputs.
	output := const exp output: 0.
	session := TFSession on: graph.
	result := session runOutput: output.
	self assert: result shape equals: inputs shape.
	result allFloats
		with: template exp
		do: [ :res :temp | self assert: res closeTo: temp ].
	output free
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testOperationGreater [
	| graph a b session constA constB result template comparisons |
	a := TFTensor fromFloats: #(#(1.1 1.2) #(3.14 2.2)).
	b := TFTensor fromFloats: #(#(3.14 3.14) #(2.1 3.14)).
	graph := TFGraph create.
	constA := graph const: 'a' value: a.
	constB := graph const: 'b' value: b.
	comparisons := constA > constB.
	template := a allFloats with: b allFloats collect: [ :x :y | x > y ].
	session := TFSession on: graph.
	result := session runOutput: (comparisons output: 0).
	self assert: result shape equals: a shape.
	result allElements
		with: template
		do: [ :r :t | self assert: r equals: t ]
]

{ #category : 'unary operations' }
TensorFlowOperationsTest >> testOperationIAlias [
	| graph template const result same1 same2 |
	graph := TFGraph create.
	template := TFTensor
		fromFloats: #(#(#(1) #(2) #(3)) #(#(4) #(5) #(6))).
	const := graph const: 'const' value: template.
	same1 := const alias: 'another_name'.
	same2 := graph operationNamed: 'another_name'.
	result := (TFSession on: graph) runOutput: (same1 output: 0).
	self assert: template shape equals: result shape.
	self assert: #(1 2 3 4 5 6) equals: result allFloats.
	result := (TFSession on: graph) runOutput: (same2 output: 0).
	self assert: template shape equals: result shape.
	self assert: #(1 2 3 4 5 6) equals: result allFloats
]

{ #category : 'unary operations' }
TensorFlowOperationsTest >> testOperationIdentity [
	| graph template const result same |
	graph := TFGraph create.
	template := TFTensor
		fromFloats: #(#(#(1) #(2) #(3)) #(#(4) #(5) #(6))).
	const := graph const: 'const' value: template.
	same := const identity output: 0.
	result := (TFSession on: graph) runOutput: same.
	self assert: template shape equals: result shape.
	self assert: #(1 2 3 4 5 6) equals: result allFloats
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testOperationMatMul [
	| graph a b session constA constB result output template |
	a := TFTensor fromFloats: #(#(1.1 1.2) #(2.1 2.2)).
	b := TFTensor fromFloats: #(#(2.0 4.0) #(8.0 16.0)).
	graph := TFGraph create.
	constA := graph const: 'a' value: a.
	constB := graph const: 'b' value: b.
	output := constA * constB.
	template := (Array new: 4)
		at: 1 put: 1.1 * 2.0 + (1.2 * 8.0);
		at: 2 put: 1.1 * 4.0 + (1.2 * 16.0);
		at: 3 put: 2.1 * 2.0 + (2.2 * 8.0);
		at: 4 put: 2.1 * 4.0 + (2.2 * 16.0);
		yourself.
	session := TFSession on: graph.
	result := session runOutput: (output output: 0).
	self assert: result shape equals: a shape.
	result allFloats
		with: template
		do: [ :r :t | self assert: r closeTo: t ]
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testOperationMatMul1x1 [
	| graph a b session constA constB output result |
	a := #(#(1.1)) asFloatTensor.
	b := #(#(3.14)) asFloatTensor.
	graph := TFGraph create.
	constA := graph const: 'a' value: a.
	constB := graph const: 'b' value: b.
	output := constA * constB.
	session := TFSession on: graph.
	result := session runOutput: (output output: 0).
	self assert: 1.1 * 3.14 closeTo: result allFloats first
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testOperationMatMul1x1Wrong [
	| graph a b session constA constB output |
	a := #(1.1) asFloatTensor.
	b := #(2.02) asFloatTensor.
	graph := TFGraph create.
	constA := graph const: 'a' value: a.
	constB := graph const: 'b' value: b.
	self
		should: [constA * constB]
		raiseError: 'INVALID_ARGUMENT: Shape must be rank 2 but is rank 1 for'.
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testOperationMatMulABTransposed [
"	This method doesn't compile because /*/ is not a valid binary selector in VAST
	| graph a b session constA constB result output template |
	a := TFTensor fromFloats: #(#(1.1 1.2) #(2.1 2.2)).
	b := TFTensor fromFloats: #(#(2.0 4.0) #(8.0 16.0)).
	graph := TFGraph create.
	constA := graph const: 'a' value: a.
	constB := graph const: 'b' value: b.
	output := constA \*\ constB.
	template := (Array new: 4)
		at: 1 put: 1.1 * 2.0 + (2.1 * 4.0);
		at: 2 put: 1.1 * 8.0 + (2.1 * 16.0);
		at: 3 put: 1.2 * 2.0 + (2.2 * 4.0);
		at: 4 put: 1.2 * 8.0 + (2.2 * 16.0);
		yourself.
	session := TFSession on: graph.
	result := session runOutput: (output output: 0).
	self assert: result shape equals: a shape.
	result allFloats
		with: template
		do: [ :r :t | self assert: r closeTo: t ]
"

	^ self error: 'The source for this method failed to compile'
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testOperationMatMulATransposed [
	| graph a b session constA constB result output template |
	a := TFTensor fromFloats: #(#(1.1 1.2) #(2.1 2.2)).
	b := TFTensor fromFloats: #(#(2.0 4.0) #(8.0 16.0)).
	graph := TFGraph create.
	constA := graph const: 'a' value: a.
	constB := graph const: 'b' value: b.
	output := constA \* constB.
	template := (Array new: 4)
		at: 1 put: 1.1 * 2.0 + (2.1 * 8.0);
		at: 2 put: 1.1 * 4.0 + (2.1 * 16.0);
		at: 3 put: 1.2 * 2.0 + (2.2 * 8.0);
		at: 4 put: 1.2 * 4.0 + (2.2 * 16.0);
		yourself.
	session := TFSession on: graph.
	result := session runOutput: (output output: 0).
	self assert: result shape equals: a shape.
	result allFloats
		with: template
		do: [ :r :t | self assert: r closeTo: t ]
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testOperationMatMulBTransposed [
	| graph a b session constA constB result output template |
	a := TFTensor fromFloats: #(#(1.1 1.2) #(2.1 2.2)).
	b := TFTensor fromFloats: #(#(2.0 4.0) #(8.0 16.0)).
	graph := TFGraph create.
	constA := graph const: 'a' value: a.
	constB := graph const: 'b' value: b.
	output := constA *\ constB.
	template := (Array new: 4)
		at: 1 put: 1.1 * 2.0 + (1.2 * 4.0);
		at: 2 put: 1.1 * 8.0 + (1.2 * 16.0);
		at: 3 put: 2.1 * 2.0 + (2.2 * 4.0);
		at: 4 put: 2.1 * 8.0 + (2.2 * 16.0);
		yourself.
	session := TFSession on: graph.
	result := session runOutput: (output output: 0).
	self assert: result shape equals: a shape.
	result allFloats
		with: template
		do: [ :r :t | self assert: r closeTo: t ]
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testOperationMatMulWrongType [
	| graph a b constA constB |
	a := TFTensor fromFloats: #(#(1.1 1.2) #(2.1 2.2)).
	b := #(#(2 4) #(8 16)) asInt32Tensor.
	graph := TFGraph create.
	constA := graph const: 'a' value: a.
	constB := graph const: 'b' value: b.
	self
		should: [ constA * constB ]
		raiseError:
			'INVALID_ARGUMENT: Inconsistent values for attr ''T'' DT_FLOAT vs. DT_INT32 while building NodeDef ''MatMul'' using Op'
]

{ #category : 'unary operations' }
TensorFlowOperationsTest >> testOperationMatrixInverse [
	| graph template session const result identity inverse |
	template := TFTensor fromFloats: #(#(-1.1 1.2) #(-2.1 -2.2)).
	graph := TFGraph create.
	const := graph const: 'const' value: template.
	inverse := const inverse.
	identity := const * inverse output: 0.
	session := TFSession on: graph.
	result := session runOutput: identity.
	self assert: result shape equals: template shape.
	result allFloats
		with: #(1.0 0.0 0.0 1.0)
		do: [ :real :expected | self assert: real closeTo: expected ].
	identity free
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testOperationMeanOn [
	| graph a session mean0 mean01 mean1 results meanNone |
	graph := TFGraph create.
	a := graph const: #(#(1.1 1.2) #(2.1 2.2) #(3.1 0.2)) asFloatTensor.
	mean0 := a meanOn: #(0) asInt32Tensor.
	mean1 := a meanOn: #(1) asInt32Tensor.
	mean01 := a meanOn: #(0 1) asInt32Tensor.
	meanNone := a meanOn: #() asInt32Tensor.
	session := TFSession on: graph.
	results := session
		runOutputs:
			((Array new: 4)
				at: 1 put: (mean0 output: 0);
				at: 2 put: (mean1 output: 0);
				at: 3 put: (mean01 output: 0);
				at: 4 put: (meanNone output: 0);
				yourself).	" mean01bis output: 0}."
	self assert: #(2) equals: results first shape.
	self assert: #(3) equals: results second shape.
	self assert: #() equals: results third shape.
	self assert: #(3 2) equals: results fourth shape.
	self assertAll: #(2.1 1.2) closeTo: results first allFloats.
	self assertAll: #(1.15 2.15 1.65) closeTo: results second allFloats.
	self assertAll: #(1.65) closeTo: results third allFloats.
	self
		assertAll: #(1.1 1.2 2.1 2.2 3.1 0.2)
		closeTo: results fourth allFloats
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testOperationMinus [
	| graph a b session constA constB result sum template |
	a := TFTensor fromFloats: #(#(1.1 1.2) #(2.1 2.2)).
	b := TFTensor fromFloats: #(#(3.14 3.14) #(3.14 3.14)).
	graph := TFGraph create.
	constA := graph const: 'a' value: a.
	constB := graph const: 'b' value: b.
	sum := constA - constB.
	session := TFSession on: graph.
	result := session runOutput: (sum output: 0).
	template := a allFloats - b allFloats.
	self assert: result shape equals: a shape.
	result allFloats
		with: template
		do: [ :r :t | self assert: r closeTo: t ]
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testOperationMod [
	| graph a b session constA constB result output template |
	a := TFTensor fromFloats: #(#(10.0 11.0) #(12.0 13.0)).
	b := TFTensor fromFloats: #(#(3.0 2.0) #(7.0 5.0)).
	graph := TFGraph create.
	constA := graph const: 'a' value: a.
	constB := graph const: 'b' value: b.
	output := constA \\ constB.
	template := a allFloats \\ b allFloats.
	session := TFSession on: graph.
	result := session runOutput: (output output: 0).
	self assert: result shape equals: a shape.
	result allFloats
		with: template
		do: [ :r :t | self assert: r closeTo: t ]
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testOperationMul [
	| graph a b session constA constB result output template |
	a := TFTensor fromFloats: #(#(1.1 1.2) #(2.1 2.2)).
	b := TFTensor fromFloats: #(#(2.0 4.0) #(8.0 16.0)).
	graph := TFGraph create.
	constA := graph const: 'a' value: a.
	constB := graph const: 'b' value: b.
	output := constA @* constB.
	template := a allFloats * b allFloats.
	session := TFSession on: graph.
	result := session runOutput: (output output: 0).
	self assert: result shape equals: a shape.
	result allFloats
		with: template
		do: [ :r :t | self assert: r closeTo: t ]
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testOperationMulScalar [
	| graph a b session constA constB result mul template |
	a := TFTensor fromFloats: #(#(1.1 1.2) #(2.1 2.2)).
	b := TFTensor fromFloats: 2.0.
	graph := TFGraph create.
	constA := graph const: 'a' value: a.
	constB := graph const: 'b' value: b.
	mul := constA @* constB.
	template := a allFloats collect: [:each | each * 2.0].
	session := TFSession on: graph.
	result := session runOutput: (mul output: 0).
	self assert: result shape equals: a shape.
	self assertAll: result allFloats closeTo: template
]

{ #category : 'unary operations' }
TensorFlowOperationsTest >> testOperationNegated [
	| graph template session const result negated |
	template := TFTensor fromFloats: #(#(1.1 1.2) #(2.1 2.2)).
	graph := TFGraph create.
	const := graph const: 'const' value: template.
	negated := const negated output: 0.
	session := TFSession on: graph.
	result := session runOutput: negated.
	self assert: result shape equals: template shape.
	self assert: result allFloats equals: template allFloats negated.
	negated free
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testOperationPlus [
	| graph a b session constA constB result sum template |
	a := TFTensor fromFloats: #(#(1.1 1.2) #(2.1 2.2)).
	b := TFTensor fromFloats: #(#(3.14 3.14) #(3.14 3.14)).
	graph := TFGraph create.
	constA := graph const: 'a' value: a.
	constB := graph const: 'b' value: b.
	sum := constA + constB.
	template := a allFloats + b allFloats.
	session := TFSession on: graph.
	result := session runOutput: (sum output: 0).
	self assert: result shape equals: a shape.
	result allFloats
		with: template
		do: [ :r :t | self assert: r closeTo: t ]
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testOperationPlusNegated [
	| graph a b session constA constB result sum template |
	a := TFTensor fromFloats: #(#(1.1 1.2) #(2.1 2.2)).
	b := TFTensor fromFloats: #(#(3.14 3.14) #(3.14 3.14)).
	graph := TFGraph create.
	constA := graph const: 'a' value: a.
	constB := graph const: 'b' value: b.
	sum := constA + constB negated.
	session := TFSession on: graph.
	result := session runOutput: (sum output: 0).
	template := a allFloats - b allFloats.
	self assert: result shape equals: a shape.
	result allFloats
		with: template
		do: [ :r :t | self assert: r closeTo: t ]
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testOperationPlusNegatedNegated [
	| graph a b session constA constB result sum template |
	a := TFTensor fromFloats: #(#(1.1 1.2) #(2.1 2.2)).
	b := TFTensor fromFloats: #(#(3.14 3.14) #(3.14 3.14)).
	graph := TFGraph create.
	constA := graph const: 'a' value: a.
	constB := graph const: 'b' value: b.
	sum := (constA + constB negated) negated.
	template := (a allFloats + b allFloats negated) negated.
	session := TFSession on: graph.
	result := session runOutput: (sum output: 0).
	self assert: result shape equals: a shape.
	result allFloats
		with: template
		do: [ :r :t | self assert: r closeTo: t ]
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testOperationPlusNegatedNegatedPlus [
	| graph a b session constA constB result sum template |
	a := TFTensor fromFloats: #(#(1.1 1.2) #(2.1 2.2)).
	b := TFTensor fromFloats: #(#(3.14 3.14) #(3.14 3.14)).
	graph := TFGraph create.
	constA := graph const: 'a' value: a.
	constB := graph const: 'b' value: b.
	sum := (constA + constB negated) negated + constB negated.
	template := (a allFloats + b allFloats negated) negated
		+ b allFloats negated.
	session := TFSession on: graph.
	result := session runOutput: (sum output: 0).
	self assert: result shape equals: a shape.
	result allFloats
		with: a allFloats negated
		do: [ :r :t | self assert: r closeTo: t ].
	result allFloats
		with: template
		do: [ :r :t | self assert: r closeTo: t ]
]

{ #category : 'unary operations' }
TensorFlowOperationsTest >> testOperationRelu [
	| graph template session const result output |
	template := #(#(-1.1 1.2) #(-2.1 2.2) #(0 -0)) asFloatTensor.
	graph := TFGraph create.
	const := graph const: 'const' value: template.
	output := const rectified output: 0.
	session := TFSession on: graph.
	result := session runOutput: output.
	self assert: result shape equals: template shape.
	self
		assert: result allFloats
		equals: (template allFloats collect: [ :each | each max: 0 ])
]

{ #category : 'unary operations' }
TensorFlowOperationsTest >> testOperationReluGrad [
	| graph template session result previousGradient rectifiedGrad expected previousGradientTemplate |
	template := #(#(-1.1 1.2) #(-2.1 2.2) #(0 -0)) asFloatTensor.
	graph := TFGraph create.
	previousGradientTemplate := #(#(0 1) #(1 0) #(1 1)) asFloatTensor.
	previousGradient := previousGradientTemplate asOperationOn: graph.
	rectifiedGrad := previousGradient timesRectifiedGradOf: template.
	session := TFSession on: graph.
	result := session runOutput: rectifiedGrad firstOutput.
	self assert: result shape equals: template shape.
	expected := template allFloats
		with: previousGradientTemplate allFloats
		collect: [ :x :y | (x sign max: 0) * y ].
	self assert: result allFloats equals: expected
]

{ #category : 'unary operations' }
TensorFlowOperationsTest >> testOperationShape [
	| graph template session const result shape |
	template := TFTensor
		fromFloats: #(#(#(#(#(-1.1 1.2 1)) #(#(-2.1 -2.2 0))))).
	graph := TFGraph create.
	const := graph const: 'const' value: template.
	shape := const shape firstOutput.
	session := TFSession on: graph.
	result := session runOutput: shape.
	self
		assert:
			((Array new: 1)
				at: 1 put: template rank;
				yourself)
		equals: result shape.
	self assert: #(1 1 2 1 3) equals: result asNumbers
]

{ #category : 'unary operations' }
TensorFlowOperationsTest >> testOperationSigmoid [
	| graph inputs template session const result output transformed |
	template := #(-1.1 1.2 0 4).
	inputs := TFTensor fromFloats: template.
	graph := TFGraph create.
	const := graph const: 'const' value: inputs.
	output := const sigmoid output: 0.
	session := TFSession on: graph.
	result := session runOutput: output.
	transformed := template
		collect: [ :x | (x negated exp + 1) reciprocal ].
	self assert: result shape equals: inputs shape.
	result allFloats
		with: transformed
		do: [ :res :temp | self assert: res closeTo: temp ].
	output free
]

{ #category : 'unary operations' }
TensorFlowOperationsTest >> testOperationSin [
	| graph template session const result output intput |
	template := #(0.1 0.0 -0.94 0.717273).
	intput := TFTensor fromFloats: template arcSin.
	graph := TFGraph create.
	const := graph const: 'const' value: intput.
	output := const sin output: 0.
	session := TFSession on: graph.
	result := session runOutput: output.
	self assert: result shape equals: intput shape.
	result allFloats
		with: template
		do: [ :res :temp | self assert: res closeTo: temp ].
	output free
]

{ #category : 'other operations' }
TensorFlowOperationsTest >> testOperationSizeOn [
	| t3x1x4 |
	t3x1x4 := #(#(#(1 2 3 0)) #(#(4 5 6 0)) #(#(7 8 9 0))).	"shape: (3 1 3)"
	self assert: #(1 2 3 4 5 6 7) sizeOn: 0 is: #(7).
	self assert: t3x1x4 sizeOn: 0 is: #(3).
	self assert: t3x1x4 sizeOn: 1 is: #(1).
	self assert: t3x1x4 sizeOn: 2 is: #(4)
]

{ #category : 'other operations' }
TensorFlowOperationsTest >> testOperationSlice [
	| m3x3 |
	m3x3 := #(#(#(1 2 3)) #(#(4 5 6)) #(#(7 8 9))).	"shape: (3 1 3)"
	self
		assertSlice: #(1 2 3 4 5 6 7)
		from: #(0)
		size: #(1)
		is: #(1).
	self
		assertSlice: m3x3
		from: #(0 0 0)
		size: #(1 1 1)
		is: #(#(#(1))).
	self
		assertSlice: m3x3
		from: #(1 0 1)
		size: #(1 1 1)
		is: #(#(#(5))).
	self
		assertSlice: m3x3
		from: #(1 0 1)
		size: #(1 -1 1)
		is: #(#(#(5))).
	self
		assertSlice: m3x3
		from: #(1 0 1)
		size: #(1 1 -1)
		is: #(#(#(5 6))).
	self
		assertSlice: m3x3
		from: #(1 0 1)
		size: #(1 -1 -1)
		is: #(#(#(5 6))).
	self
		assertSlice: m3x3
		from: #(1 0 1)
		size: #(-1 1 -1)
		is: #(#(#(5 6)) #(#(8 9)))
]

{ #category : 'other operations' }
TensorFlowOperationsTest >> testOperationSliceSimple [
	| graph session const result slice |
	graph := TFGraph create.
	const := graph const: #(1 2 3 4 5 6 7) asInt32Tensor.
	slice := const sliceFrom: #(0) asInt32Tensor size: #(1) asInt32Tensor.
	session := TFSession on: graph.
	result := session runOutput: slice firstOutput.
	self assert: #(1) equals: result asNumbers
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testOperationSparseSoftmaxCrossEntropyWithLogits [
	| graph label prediction results session xentropy gradient lastVector loss |
	graph := TFGraph create.
	prediction := graph
		const:
			#(#(0.1 0.2 0.3 0.9 0.0 0.5 0.4) #(0.1 0.2 0.1 0.1 0.8 0.1 0.1) #(0 0 0 0 0 0 1))
				asFloatTensor.
	label := graph const: #(3 4 6) asInt32Tensor.
	xentropy := prediction sparseSoftmaxCrossEntropyWithLogits: label.
	session := TFSession on: graph.
	results := session
		runOutputs:
			((Array new: 2)
				at: 1 put: (xentropy output: 0);
				at: 2 put: (xentropy output: 1);
				yourself).
	loss := results first.
	self assert: #(3) equals: loss shape.
	self assert: (loss allFloats first between: 1 and: 1.5).
	self assert: (loss allFloats second between: 1 and: 1.5).
	self assert: (loss allFloats third between: 1 and: 1.2).
	gradient := results second.
	self assert: #(3 7) equals: gradient shape.
	lastVector := gradient allFloats last: 7.
	self assert: lastVector last < 0.
	lastVector allButLast do: [ :x | self assert: x > 0 ]
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testOperationSparseSoftmaxCrossEntropyWithLogitsUseOutput [
	| graph label prediction results session xentropy gradient lastVector loss |
	graph := TFGraph create.
	prediction := graph
		const:
			#(#(0.1 0.2 0.3 0.9 0.0 0.5 0.4) #(0.1 0.2 0.1 0.1 0.8 0.1 0.1) #(0 0 0 0 0 0 1))
				asFloatTensor.
	label := graph const: #(3 4 6) asInt32Tensor.
	xentropy := prediction sparseSoftmaxCrossEntropyWithLogits: label.
	session := TFSession on: graph.
	results := session
		runOutputs:
			((Array new: 2)
				at: 1 put: xentropy firstOutput;
				at: 2 put: (xentropy useOutput: 1) firstOutput;
				yourself).
	loss := results first.
	self assert: #(3) equals: loss shape.
	self assert: (loss allFloats first between: 1 and: 1.5).
	self assert: (loss allFloats second between: 1 and: 1.5).
	self assert: (loss allFloats third between: 1 and: 1.2).
	gradient := results second.
	self assert: #(3 7) equals: gradient shape.
	lastVector := gradient allFloats last: 7.
	self assert: lastVector last < 0.
	lastVector allButLast do: [ :x | self assert: x > 0 ]
]

{ #category : 'unary operations' }
TensorFlowOperationsTest >> testOperationSquared [
	| graph template session const result output |
	template := TFTensor fromFloats: #(#(-1.1 1.2) #(-2.1 -2.2)).
	graph := TFGraph create.
	const := graph const: 'const' value: template.
	output := const squared output: 0.
	session := TFSession on: graph.
	result := session runOutput: output.
	self assert: result shape equals: template shape.
	result allFloats
		with: template allFloats squared
		do: [ :res :temp | self assert: res closeTo: temp ].
	output free
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testOperationSub [
	| graph a b session constA constB result sub template |
	a := TFTensor fromFloats: #(#(1.1 1.2) #(2.1 2.2)).
	b := TFTensor fromFloats: #(#(3.14 3.14) #(3.14 3.14)).
	graph := TFGraph create.
	constA := graph const: 'a' value: a.
	constB := graph const: 'b' value: b.
	sub := constA - constB.
	session := TFSession on: graph.
	result := session runOutput: (sub output: 0).
	template := a allFloats - b allFloats.
	self assert: result shape equals: a shape.
	result allFloats
		with: template
		do: [ :r :t | self assert: r closeTo: t ]
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testOperationSum [
	| graph a session const result output0 output1 axis0 axis1 template sumOn1 sumOn0 |
	template := #(#(1.1 1.2) #(2.1 2.2) #(3.1 0.2)).
	sumOn0 := template sum.
	sumOn1 := template collect: [ :line | line sum ].
	a := TFTensor fromFloats: template.
	graph := TFGraph create.
	const := graph const: 'a' value: a.
	axis0 := graph const: 'axis0' value: (TFTensor fromInt32: 0).
	axis1 := graph const: 'axis1' value: (TFTensor fromInt32: 1).
	output0 := const sumOn: axis0.
	output1 := const sumOn: axis1.
	session := TFSession on: graph.
	result := session runOperation: output0 output: (output0 output: 0).
	self assert: result shape equals: #(2).
	result allFloats
		with: sumOn0
		do: [ :r :t | self assert: r closeTo: t ].
	result := session runOperation: output1 output: (output1 output: 0).
	self assert: result shape equals: #(3).
	result allFloats
		with: sumOn1
		do: [ :r :t | self assert: r closeTo: t ]
]

{ #category : 'binary operations' }
TensorFlowOperationsTest >> testOperationSumOnOutputs [
	| graph a session const results first second output0 output1 axis0 axis1 template sumOn1 sumOn0 |
	template := #(#(1.1 1.2) #(2.1 2.2) #(3.1 0.2)).
	sumOn0 := template sum.
	sumOn1 := template collect: [ :line | line sum ].
	a := TFTensor fromFloats: template.
	graph := TFGraph create.
	const := graph const: 'a' value: a.
	axis0 := graph const: 'axis0' value: (TFTensor fromInt32: 0).
	axis1 := graph const: 'axis1' value: (TFTensor fromInt32: 1).
	output0 := const sumOn: axis0.
	output1 := const sumOn: axis1.
	session := TFSession on: graph.
	results := session
		runOutputs:
			((Array new: 2)
				at: 1 put: (output0 output: 0);
				at: 2 put: (output1 output: 0);
				yourself).
	first := results at: 1.
	second := results at: 2.
	self assert: first shape equals: #(2).
	first allFloats
		with: sumOn0
		do: [ :r :t | self assert: r closeTo: t ].
	self assert: second shape equals: #(3).
	second allFloats
		with: sumOn1
		do: [ :r :t | self assert: r closeTo: t ]
]

{ #category : 'unary operations' }
TensorFlowOperationsTest >> testOperationTan [
	| graph template session const result output intput |
	template := #(0.1 0.0 -0.94 0.717273).
	intput := TFTensor fromFloats: template arcTan.
	graph := TFGraph create.
	const := graph const: 'const' value: intput.
	output := const tan output: 0.
	session := TFSession on: graph.
	result := session runOutput: output.
	self assert: result shape equals: intput shape.
	result allFloats
		with: template
		do: [ :res :temp | self assert: res closeTo: temp ].
	output free
]

{ #category : 'unary operations' }
TensorFlowOperationsTest >> testSoftmax [
	| graph template session const result output denominator |
	template := TFTensor
		fromFloats:
			((Array new: 1)
				at: 1
					put:
					((Array new: 2)
						at: 1 put: 0;
						at: 2 put: 3 ln;
						yourself);
				yourself).
	graph := TFGraph create.
	const := graph const: 'const' value: template.
	output := const softmax firstOutput.
	session := TFSession on: graph.
	result := session runOutput: output.
	self assert: result shape equals: template shape.
	denominator := template allFloats exp sum.
	result allFloats
		with: (template allFloats exp collect: [:each | each / denominator])
		do: [ :res :temp | 
			| delta |
			delta := (res - temp) abs.
			self assert: delta < 0.001 ].
	output free
]
