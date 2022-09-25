Class {
	#name : 'ElementWiseDivisionTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TensorFlowOperationMathModelTests'
}

{ #category : 'Test' }
ElementWiseDivisionTest >> testDivideByVector [

	| input result |

	input :=
		tf
			variableNamed: 'input'
			with: (
				OrderedCollection new
					add: #(10 12 24);
					add: #(3 -6 -16);
					asFloatTensor).

	result := input / #(2 3 4) asFloatTensor.

	self
		assertOutputOf: result
		isMatrixCloseTo: (
			OrderedCollection new
				add: #(5 4 6);
				add: #(1.5 -2 -4);
				yourself)
]

{ #category : 'Test' }
ElementWiseDivisionTest >> testDivideByVerticalVector [

	| input result |

	input :=
		tf
			variableNamed: 'input'
			with: (
				OrderedCollection new
					add: #(10 12);
					add: #(3 -6);
					add: #(24 -16);
					asFloatTensor).

	result := input / #((2) (3) (4)) asFloatTensor.

	self
		assertOutputOf: result
		isMatrixCloseTo: (
			OrderedCollection new
				add: #(5 6);
				add: #(1 -2);
				add: #(6 -4);
				yourself)
]

{ #category : 'Test' }
ElementWiseDivisionTest >> testDivideFailsWhenMixingTypes [

	| input |

	input := tf variableNamed: 'input' with: #(10 11 17) asFloatTensor.

	self
		assert: [input / 2 asInt32Tensor]
		raisesExceptionWith:
			'INVALID_ARGUMENT: Inconsistent values for attr ''T'' DT_FLOAT vs. DT_INT32 while building NodeDef ''Div'' using Op<name=Div; signature=x:T, y:T -> z:T; attr=T:type,allowed=[DT_BFLOAT16, DT_HALF, DT_FLOAT, DT_DOUBLE, DT_UINT8, DT_INT8, DT_UINT16, DT_INT16, DT_INT32, DT_UINT32, DT_UINT64, DT_INT64, DT_COMPLEX64, DT_COMPLEX128]>'
]

{ #category : 'Test' }
ElementWiseDivisionTest >> testDivideFloatMatrix [

	| input result |

	input :=
		tf
			variableNamed: 'input'
			with: (
				OrderedCollection new
					add: #(10 11 17);
					add: #(3 -4 18.4);
					asFloatTensor).

	result := input / 2 asFloatTensor.

	self
		assertOutputOf: result
		isMatrixCloseTo: (
			OrderedCollection new
				add: #(5 5.5 8.5);
				add: #(1.5 -2 9.2);
				yourself)
]

{ #category : 'Test' }
ElementWiseDivisionTest >> testDivideFloatVector [

	| input result |

	input := tf variableNamed: 'input' with: #(10 11 17) asFloatTensor.

	result := input / 2 asFloatTensor.

	self assertOutputOf: result isFloatVectorCloseTo: #(5 5.5 8.5)
]

{ #category : 'Test' }
ElementWiseDivisionTest >> testDivideIntegerVector [

	| input result |

	input := tf variableNamed: 'input' with: #(10 11 17) asInt32Tensor.

	result := input / 2 asInt32Tensor.

	self assertOutputOf: result isIntegerVectorEqualsTo: #(5 5 8)
]

{ #category : 'Test' }
ElementWiseDivisionTest >> testDivideScalar [

	| input result |

	input := tf variableNamed: 'input' with: 10 asInt32Tensor.

	result := input / 2 asInt32Tensor.

	self assertOutputOf: result isIntegerScalarEqualTo: 5
]

{ #category : 'Test' }
ElementWiseDivisionTest >> testOperationName [

	| input |

	input := tf variableNamed: 'input' with: 10 asTensor.

	self assert: (ElementWiseDivision of: input and: 2 asTensor) isNamedInGraphAs: 'Div'.
	self assert: (ElementWiseDivision of: input and: 2 asTensor) isNamedInGraphAs: 'Div_1'.
	self
		assert: (ElementWiseDivision named: 'output' of: input and: 2 asTensor)
		isNamedInGraphAs: 'output'.
	self
		assert: (ElementWiseDivision named: 'output' of: input and: 2 asTensor)
		isNamedInGraphAs: 'output_1'
]

{ #category : 'Test' }
ElementWiseDivisionTest >> testPrintString [

	| input |

	input := tf variableNamed: 'input' with: 10 asTensor.

	self
		assert: (ElementWiseDivision of: input and: 2 asTensor) printString
		equals: '(input / Int32 scalar)'
]
