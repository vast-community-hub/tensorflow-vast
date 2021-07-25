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
		should: [tf compute: reciprocal]
		raise: Error
		withSignalDo: [:exception | | errorText | 
			errorText := exception messageText.
			self assert: (errorText includesSubstring: 'INVALID_ARGUMENT: 2 root error(s) found.').
			self assert: (errorText includesSubstring: '(0) Invalid argument: Invalid cast from floating point type to S32 in ConstantR0WithType.').
			self assert: (errorText includesSubstring: '(1) Invalid argument: Invalid cast from floating point type to S32 in ConstantR0WithType.')	.
			self assert: (errorText includesSubstring: '0 successful operations.').
			self assert: (errorText includesSubstring: '0 derived errors ignored.')].

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
