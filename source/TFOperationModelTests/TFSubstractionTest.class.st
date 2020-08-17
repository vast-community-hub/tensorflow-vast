Class {
	#name : 'TFSubstractionTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Tests' }
TFSubstractionTest >> testMatrixMinusVector [

	| x y |

	x := tf floatConstantWith: #((3 -4) (-0.5 9)).
	y := tf floatConstantWith: #(3 -2).
	
	self assertOutputOf: x - y isMatrixCloseTo: #((0 -2) (-3.5 11))
]

{ #category : 'Tests' }
TFSubstractionTest >> testOperationName [

	| x y |

	x := tf constantWith: 3.0.
	y := tf constantWith: 5.0.

	self assert: (TFSubstraction of: x minus: y) isNamedInGraphAs: 'Sub'.
	self assert: (TFSubstraction of: x minus: y) isNamedInGraphAs: 'Sub_1'.
	self assert: (TFSubstraction named: 'output' of: x minus: y) isNamedInGraphAs: 'output'.
	self assert: (TFSubstraction named: 'output' of: x minus: y) isNamedInGraphAs: 'output_1'
]

{ #category : 'Tests' }
TFSubstractionTest >> testPrintString [

	| x y |

	x := tf floatConstantWith: 3.0 named: 'x'.
	y := tf floatConstantWith: -1 named: 'y'.

	self assert: (x - y) printString equals: '(x - y)'
]

{ #category : 'Tests' }
TFSubstractionTest >> testSubstractionOfFloarScalars [

	| x y |

	x := tf constantWith: 3.0.
	y := tf constantWith: 5.0.

	self assertOutputOf: x - y isFloatScalarCloseTo: -2
]

{ #category : 'Tests' }
TFSubstractionTest >> testSubstractionOfFloatMatrices [

	| x y |

	x := tf floatConstantWith: #((3 -4) (-0.5 9)).
	y := tf floatConstantWith: #((3 -2) (1 -5)).

	self assertOutputOf: x - y isMatrixCloseTo: #((0 -2) (-1.5 14))
]

{ #category : 'Tests' }
TFSubstractionTest >> testSubstractionOfFloatVectors [

	| x y |

	x := tf floatConstantWith: #(3 -4).
	y := tf floatConstantWith: #(5 -1).

	self assertOutputOf: x - y isFloatVectorCloseTo: #(-2 -3)
]

{ #category : 'Tests' }
TFSubstractionTest >> testSubstractionOfIntegerScalars [

	| x y |

	x := tf integerConstantWith: 3.
	y := tf integerConstantWith: 5.

	self assertOutputOf: x - y isIntegerScalarEqualTo: -2
]
