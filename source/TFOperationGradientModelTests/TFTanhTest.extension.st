Extension {
	#name : 'TFTanhTest'
}

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFTanhTest >> testPartialDerivativeWithRespectToAnotherMatrixVariable [

	| input tanh dTanh x |

	input :=
		tf
			variableNamed: 'input'
			with: (
				OrderedCollection new
					add: #(0.549306 0.693147);
					add: #(0.867301 1.09861);
					asFloatTensor).
	tanh := TFTanhActivation activating: input.

	x := tf variableNamed: 'x' with: 1 asInt32Tensor.
	dTanh := tanh partialDerivativeWithRespectTo: x.

	self assertOutputOf: dTanh isMatrixCloseTo: #((0 0) (0 0))
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFTanhTest >> testPartialDerivativeWithRespectToAnotherScalarVariable [

	| input tanh dTanh x |

	input := tf variableNamed: 'input' with: 0.549306 asFloatTensor.
	tanh := TFTanhActivation activating: input.

	x := tf variableNamed: 'x' with: 1 asFloatTensor.
	dTanh := tanh partialDerivativeWithRespectTo: x.

	self assertOutputOf: dTanh isFloatScalarCloseTo: 0
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFTanhTest >> testPartialDerivativeWithRespectToAnotherVectorVariable [

	| input tanh dTanh x |

	input := tf variableNamed: 'input' with: #(0.549306 0.693147) asFloatTensor.
	tanh := TFTanhActivation activating: input.

	x := tf variableNamed: 'x' with: 1 asFloatTensor.
	dTanh := tanh partialDerivativeWithRespectTo: x.

	self assertOutputOf: dTanh isFloatVectorCloseTo: #(0 0)
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFTanhTest >> testPartialDerivativeWithRespectToMatrixInput [
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

	tanh := TFTanhActivation activating: input.

	self
		assertPartialDerivativeOf: tanh
		withRespectTo: input
		isMatrixCloseTo: (
			OrderedCollection new
				add: (Array with: 1 - (0.5 squared) with: 1 - (0.6 squared));
				add: (Array with: 1 - (0.7 squared) with: 1 - (0.8 squared));
				yourself)
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFTanhTest >> testPartialDerivativeWithRespectToScalarInput [
	"f(x) = tanh(x) 
	 df/dx = 1 - tanh(x)^2"

	| input tanh |

	input := tf variableNamed: 'input' with: 0.549306 asFloatTensor.
	tanh := TFTanhActivation activating: input.
	
	self assertPartialDerivativeOf: tanh withRespectTo: input isCloseTo: 1 - (0.5 squared)
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test'] }
TFTanhTest >> testPartialDerivativeWithRespectToVectorInput [
	" f(x) = tanh(x) 
	 df/dx = 1 - tanh(x)^2"

	| input tanh |

	input := tf floatConstantWith: #(0.549306 0.693147).
	tanh := TFTanhActivation activating: input.

	self
		assertPartialDerivativeOf: tanh
		withRespectTo: input
		isVectorCloseTo: (Array with: 1 - (0.5 squared) with: 1 - (0.6 squared))
]
