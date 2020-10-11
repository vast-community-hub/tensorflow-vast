Class {
	#name : 'ReciprocalTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Tests' }
ReciprocalTest >> testFloatScalarReciprocal [

	| x reciprocal |

	x := tf floatConstantWith: 5.
	reciprocal := Reciprocal named: 'recip' of: x.

	self assertOutputOf: reciprocal isFloatScalarCloseTo: 0.2
]

{ #category : 'Tests' }
ReciprocalTest >> testFloatVectorReciprocal [

	| x |

	x := tf floatConstantWith: #(5 10 -0.5).
	
	self assertOutputOf: x reciprocal isFloatVectorCloseTo: #(0.2 0.1 -2)
]

{ #category : 'Tests' }
ReciprocalTest >> testIntegerScalarReciprocal [

	| x reciprocal |

	x := tf integerConstantWith: 5.
	reciprocal := Reciprocal named: 'recip' of: x.

	self
		assert: [tf compute: reciprocal]
		raisesExceptionWith:
			'INVALID_ARGUMENT: No OpKernel was registered to support Op ''Reciprocal'' used by {{node recip}}with these attrs: [T=DT_INT32]
Registered devices: [CPU]
Registered kernels:
  device=''CPU''; T in [DT_FLOAT]
  device=''CPU''; T in [DT_HALF]
  device=''CPU''; T in [DT_DOUBLE]
  device=''CPU''; T in [DT_COMPLEX64]
  device=''CPU''; T in [DT_COMPLEX128]

	 [[recip]]'
]

{ #category : 'Tests' }
ReciprocalTest >> testOperationName [

	| x |

	x := tf floatConstantWith: 5.

	self assert: (Reciprocal of: x) isNamedInGraphAs: 'Reciprocal'.
	self assert: (Reciprocal of: x) isNamedInGraphAs: 'Reciprocal_1'.
	self assert: (Reciprocal named: 'recip' of: x) isNamedInGraphAs: 'recip'.
	self assert: (Reciprocal named: 'recip' of: x) isNamedInGraphAs: 'recip_1'
]

{ #category : 'Tests' }
ReciprocalTest >> testPrintString [

	| x |

	x := tf floatConstantWith: 5 named: 'input'.

	self assert: (Reciprocal of: x) printString equals: '1 / (input)'
]