Extension {
	#name : 'TanhTest'
}

{ #category : 'Test' }
TanhTest >> testPartialDerivativeWithRespectToAnotherMatrixVariable [

	| input tanh x |

	input :=
		tf
			variableNamed: 'input'
			with: (
				OrderedCollection new
					add: #(0.549306 0.693147);
					add: #(0.867301 1.09861);
					asFloatTensor).
	tanh := Tanh activating: input.

	x := tf variableNamed: 'x' with: 1 asInt32Tensor.

	self assert: tanh isNotDifferentiableRespectTo: x
]

{ #category : 'Test' }
TanhTest >> testPartialDerivativeWithRespectToAnotherScalarVariable [
	"f(x) = tanh(x) 
	 df/dx = 1 - tanh(x)^2"

	| input tanh x |

	input := tf variableNamed: 'input' with: 0.549306 asFloatTensor.
	tanh := Tanh activating: input.

	x := tf variableNamed: 'x' with: 1 asFloatTensor.

	self assert: tanh isNotDifferentiableRespectTo: x
]

{ #category : 'Test' }
TanhTest >> testPartialDerivativeWithRespectToAnotherVectorVariable [

	| input tanh x |

	input := tf variableNamed: 'input' with: #(0.549306 0.693147) asFloatTensor.
	tanh := Tanh activating: input.

	x := tf variableNamed: 'x' with: 1 asFloatTensor.

	self assert: tanh isNotDifferentiableRespectTo: x
]

{ #category : 'Test' }
TanhTest >> testPartialDerivativeWithRespectToMatrixInput [
	" f(x) = tanh(x) 
	 df/dx = 1 - tanh(x)^2"

	| input tanh |

	input :=
		tf
			variableNamed: 'input'
			with: (
				OrderedCollection new
					add: #(0.549306 0.693147);
					add: #(0.867301 1.09861);
					asFloatTensor).

	tanh := Tanh activating: input.

	self
		assertPartialDerivativeOf: tanh
		withRespectTo: input
		isMatrixCloseTo: (
			OrderedCollection new
				add: (Array with: 1 - (0.5 squared) with: 1 - (0.6 squared));
				add: (Array with: 1 - (0.7 squared) with: 1 - (0.8 squared));
				yourself)
]

{ #category : 'Test' }
TanhTest >> testPartialDerivativeWithRespectToScalarInput [
	"f(x) = tanh(x) 
	 df/dx = 1 - tanh(x)^2"

	| input tanh |

	input := tf variableNamed: 'input' with: 0.549306 asFloatTensor.
	tanh := Tanh activating: input.
	
	self assertPartialDerivativeOf: tanh withRespectTo: input isCloseTo: 1 - (0.5 squared)
]

{ #category : 'Test' }
TanhTest >> testPartialDerivativeWithRespectToVectorInput [
	" f(x) = tanh(x) 
	 df/dx = 1 - tanh(x)^2"

	| input tanh |

	input := tf floatConstantWith: #(0.549306 0.693147).
	tanh := Tanh activating: input.

	self
		assertPartialDerivativeOf: tanh
		withRespectTo: input
		isVectorCloseTo: (Array with: 1 - (0.5 squared) with: 1 - (0.6 squared))
]
