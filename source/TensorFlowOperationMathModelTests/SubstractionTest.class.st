Class {
	#name : 'SubstractionTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TensorFlowOperationMathModelTests'
}

{ #category : 'Tests' }
SubstractionTest >> testMatrixMinusVector [

	| x y |

	x := tf floatConstantWith: #((3 -4) (-0.5 9)).
	y := tf floatConstantWith: #(3 -2).
	
	self assertOutputOf: x - y isMatrixCloseTo: #((0 -2) (-3.5 11))
]

{ #category : 'Tests' }
SubstractionTest >> testOperationName [

	| x y |

	x := tf constantWith: 3.0.
	y := tf constantWith: 5.0.

	self assert: (Substraction of: x minus: y) isNamedInGraphAs: 'Sub'.
	self assert: (Substraction of: x minus: y) isNamedInGraphAs: 'Sub_1'.
	self assert: (Substraction named: 'output' of: x minus: y) isNamedInGraphAs: 'output'.
	self assert: (Substraction named: 'output' of: x minus: y) isNamedInGraphAs: 'output_1'
]

{ #category : 'Tests' }
SubstractionTest >> testPrintString [

	| x y |

	x := tf floatConstantWith: 3.0 named: 'x'.
	y := tf floatConstantWith: -1 named: 'y'.

	self assert: (x - y) printString equals: '(x - y)'
]

{ #category : 'Tests' }
SubstractionTest >> testSubstractionOfFloarScalars [

	| x y |

	x := tf constantWith: 3.0.
	y := tf constantWith: 5.0.

	self assertOutputOf: x - y isFloatScalarCloseTo: -2
]

{ #category : 'Tests' }
SubstractionTest >> testSubstractionOfFloatMatrices [

	| x y |

	x := tf floatConstantWith: #((3 -4) (-0.5 9)).
	y := tf floatConstantWith: #((3 -2) (1 -5)).

	self assertOutputOf: x - y isMatrixCloseTo: #((0 -2) (-1.5 14))
]

{ #category : 'Tests' }
SubstractionTest >> testSubstractionOfFloatVectors [

	| x y |

	x := tf floatConstantWith: #(3 -4).
	y := tf floatConstantWith: #(5 -1).

	self assertOutputOf: x - y isFloatVectorCloseTo: #(-2 -3)
]

{ #category : 'Tests' }
SubstractionTest >> testSubstractionOfIntegerScalars [

	| x y |

	x := tf integerConstantWith: 3.
	y := tf integerConstantWith: 5.

	self assertOutputOf: x - y isIntegerScalarEqualTo: -2
]
