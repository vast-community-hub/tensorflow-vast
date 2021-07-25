Class {
	#name : 'GradientTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationGradientModelTests'
}

{ #category : 'Test' }
GradientTest >> testAccessingGradientIndependently [

	| weights input output grad result |

	weights := tf floatInputNamed: 'var'.
	input := tf constantWith: Float pi.

	output := weights * input.

	grad := Gradient of: output withRespectTo: (Array with: weights with: input).

	result :=
		tf
			compute: (grad valueWithRespectTo: input)
			feedingInputsWith: (
				Dictionary new
					at: 'var' put: 1.0 asTensor;
					yourself).

	self assertOutputOf: result isFloatScalarCloseTo: 1.0
]

{ #category : 'Test' }
GradientTest >> testCotangentVectorWithOnlyOnesIsTheDefault [
	" According documentation. https://github.com/tensorflow/tensorflow/blob/master/tensorflow/c/c_api.h,
	 when no cotangent vector provided, the API will feed with a `OnesLike` for all shapes in `y`
	 f(x,y) = x.y 
	 vjp( f, x, v ) = v * df/dx = y . v^T
	 vjp( f, y, v ) = v * df/dy = v^T . x"

	| x0 x1 output grads vjp gradsResult vjpResult vdfdx vdfdy |

	x1 := tf floatInputNamed: 'x1'.
	x0 := tf floatConstantWith: #((1.1) (2.1) (3.1)).

	output := x0 dot: x1.

	grads := (Gradient of: output withRespectTo: (Array with: x0 with: x1)) allPartialDerivatives.
	vjp :=
		(Gradient
			of: output
			withRespectTo: (Array with: x0 with: x1)
			product: (Array with: #((1 1 1) (1 1 1) (1 1 1)) asFloatTensor))
				allPartialDerivatives.

	gradsResult :=
		tf
			computeAll: grads
			feedingInputsWith: (
				Dictionary new
					at: 'x1' put: #((1.1 1.2 1.3)) asFloatTensor;
					yourself).
	vjpResult :=
		tf
			computeAll: vjp
			feedingInputsWith: (
				Dictionary new
					at: 'x1' put: #((1.1 1.2 1.3)) asFloatTensor;
					yourself).

	vdfdx :=
		OrderedCollection new
			add: (1.1 + 1.2 + 1.3);
			add: (1.1 + 1.2 + 1.3);
			add: (1.1 + 1.2 + 1.3);
			yourself.
	vdfdy :=
		OrderedCollection new
			add: (Array with: (1.1 + 2.1 + 3.1) with: (1.1 + 2.1 + 3.1) with: (1.1 + 2.1 + 3.1));
			yourself.

	self
		assert: (gradsResult at: grads first) isMatrixCloseTo: vdfdx;
		assert: (vjpResult at: vjp first) isMatrixCloseTo: vdfdx.
	self
		assert: (gradsResult at: grads second) isMatrixCloseTo: vdfdy;
		assert: (vjpResult at: vjp second) isMatrixCloseTo: vdfdy
]

{ #category : 'Test' }
GradientTest >> testElementMultiplicationGradient [

	| weights input output gradWeight result |

	weights := tf floatInputNamed: 'var'.
	input := tf constantWith: Float pi.

	output := weights * input.

	gradWeight := Gradient of: output withRespectTo: (Array with: weights).

	result :=
		tf
			compute: gradWeight
			feedingInputsWith: (
				Dictionary new
					at: 'var' put: 1.0 asTensor;
					yourself).

	self assert: result isFloatScalarCloseTo: Float pi
]

{ #category : 'Test' }
GradientTest >> testElementMultiplicationGradientWithRespectToSeveralVariables [

	| weights input output grads result |

	weights := tf floatInputNamed: 'var'.
	input := tf constantWith: Float pi.

	output := weights * input.

	grads :=
		(Gradient of: output withRespectTo: (Array with: weights with: input)) allPartialDerivatives.

	result :=
		tf
			computeAll: grads
			feedingInputsWith: (
				Dictionary new
					at: 'var' put: 1.0 asTensor;
					yourself).

	self assert: (result at: grads first) isFloatScalarCloseTo: Float pi.
	self assert: (result at: grads second) isFloatScalarCloseTo: 1.0
]

{ #category : 'Test' }
GradientTest >> testMSEGradientWithConstants [

	| prediction expected mse gradWeight |

	prediction := tf floatConstantWith: 3.
	expected := tf constantWith: Float pi.

	mse := MeanSquaredError of: prediction whenExpectedIs: expected.

	gradWeight := Gradient of: mse withRespectTo: prediction.

	self assertOutputOf: (tf compute: gradWeight) isFloatScalarCloseTo: 2 * (3 - Float pi)
]

{ #category : 'Test' }
GradientTest >> testNumberOfDifferentiatedFunctionsShouldMatchNumberOfCotangentVectors [
	"f(x,y) = xy 
	 vjp( f, x, v ) = v * df/dx = v * y
	 vjp( f, y, v ) = v * df/dy = v * x"

	| weights input output |

	weights := tf floatInputNamed: 'weight'.
	input := tf constantWith: Float pi.

	output := weights * input.

	self
		should: [
			Gradient
				of: output
				withRespectTo: (Array with: weights with: input)
				product: (Array with: 5.0 asTensor with: 3 asTensor)]
		raise: AssertionFailure
		withDescription: 'Collections sizes do not match'
]

{ #category : 'Test' }
GradientTest >> testProductCotangentMatrixCase1 [
	" f(x,y) = x.y 
	 vjp( f, x, v ) = v * df/dx = y . v^T
	 vjp( f, y, v ) = v * df/dy = v^T . x"

	| x0 x1 output grads result |

	x1 := tf floatInputNamed: 'x1'.
	x0 := tf floatConstantWith: #((1.1) (2.1) (3.1)).

	output := x0 dot: x1.

	grads :=
		(Gradient
			of: output
			withRespectTo: (Array with: x0 with: x1)
			product: (Array with: #((1 1 1) (1 1 1) (1 1 1)) asFloatTensor))
				allPartialDerivatives.

	result :=
		tf
			computeAll: grads
			feedingInputsWith: (
				Dictionary new
					at: 'x1' put: #((1.1 1.2 1.3)) asFloatTensor;
					yourself).

	self
		assert: (result at: grads first)
		isMatrixCloseTo: (
			OrderedCollection new
				add: (1.1 + 1.2 + 1.3);
				add: (1.1 + 1.2 + 1.3);
				add: (1.1 + 1.2 + 1.3);
				yourself).
	self
		assert: (result at: grads second)
		isMatrixCloseTo: (
			OrderedCollection new
				add: (Array with: (1.1 + 2.1 + 3.1) with: (1.1 + 2.1 + 3.1) with: (1.1 + 2.1 + 3.1));
				yourself)
]

{ #category : 'Test' }
GradientTest >> testProductCotangentMatrixCase2 [
	" f(x,y) = x.y 
	 vjp( f, x, v ) = v * df/dx = y . v^T
	 vjp( f, y, v ) = v * df/dy = v^T . x"

	| x0 x1 output grads result |

	x1 := tf floatInputNamed: 'x1'.
	x0 := tf floatConstantWith: #((1.1) (2.1) (3.1)).

	output := x0 dot: x1.

	grads :=
		(Gradient
			of: output
			withRespectTo: (Array with: x0 with: x1)
			product: (Array with: #((0 1 0) (0 0 0) (0 0 0)) asFloatTensor))
				allPartialDerivatives.

	result :=
		tf
			computeAll: grads
			feedingInputsWith: (
				Dictionary new
					at: 'x1' put: #((-1.1 -1.2 -1.3)) asFloatTensor;
					yourself).

	self
		assert: (result at: grads first)
		isMatrixCloseTo: (
			OrderedCollection new
				add: (-1.1 * 0 + (-1.2 * 1) + (-1.3 * 0));
				add: (-1.1 * 0 + (-1.2 * 0) + (-1.3 * 0));
				add: (-1.1 * 0 + (-1.2 * 0) + (-1.3 * 0));
				yourself).
	self
		assert: (result at: grads second)
		isMatrixCloseTo: (
			OrderedCollection new
				add: (
					OrderedCollection new
						add: (1.1 * 0 + (2.1 * 0) + (3.1 * 0));
						add: (1.1 * 1 + (2.1 * 0) + (3.1 * 0));
						add: (1.1 * 0 + (2.1 * 0) + (3.1 * 0));
						yourself);
				yourself)
]

{ #category : 'Test' }
GradientTest >> testProductCotangentMatrixCase3 [
	" f(x,y) = x.y 
	 vjp( f, x, v ) = v * df/dx = y . v^T
	 vjp( f, y, v ) = v * df/dy = v^T . x"

	| x0 x1 output grads result |

	x1 := tf floatInputNamed: 'x1'.
	x0 := tf floatConstantWith: #((1.1) (2.1) (3.1)).

	output := x0 dot: x1.

	grads :=
		(Gradient
			of: output
			withRespectTo: (Array with: x0 with: x1)
			product: (Array with: #((0 1 0) (9.1 0 0) (0 0 0)) asFloatTensor))
				allPartialDerivatives.

	result :=
		tf
			computeAll: grads
			feedingInputsWith: (
				Dictionary new
					at: 'x1' put: #((-1.1 -1.2 -1.3)) asFloatTensor;
					yourself).

	self
		assert: (result at: grads first)
		isMatrixCloseTo: (
			OrderedCollection new
				add: (-1.1 * 0 + (-1.2 * 1) + (-1.3 * 0));
				add: (-1.1 * 9.1 + (-1.2 * 0) + (-1.3 * 0));
				add: (-1.1 * 0 + (-1.2 * 0) + (-1.3 * 0));
				yourself).
	self
		assert: (result at: grads second)
		isMatrixCloseTo: (
			OrderedCollection new
				add: (
					OrderedCollection new
						add: (1.1 * 0 + (2.1 * 9.1) + (3.1 * 0));
						add: (1.1 * 1 + (2.1 * 0) + (3.1 * 0));
						add: (1.1 * 0 + (2.1 * 0) + (3.1 * 0));
						yourself);
				yourself)
]

{ #category : 'Test' }
GradientTest >> testProductCotangentMatrixCase4 [
	" f(x,y) = x.y 
	 vjp( f, x, v ) = v * df/dx = y . v^T
	 vjp( f, y, v ) = v * df/dy = v^T . x"

	| x0 x1 output grads result |

	x1 := tf floatConstantWith: #((1.1) (2.1) (3.1)).
	x0 := tf floatInputNamed: 'x0'.

	output := x0 dot: x1.

	grads :=
		(Gradient
			of: output
			withRespectTo: (Array with: x0 with: x1)
			product: (Array with: #((10)) asFloatTensor))
				allPartialDerivatives.

	result :=
		tf
			computeAll: grads
			feedingInputsWith: (
				Dictionary new
					at: 'x0' put: #((-1.1 -1.2 -1.3)) asFloatTensor;
					yourself).

	self
		assert: (result at: grads first)
		isMatrixCloseTo: (
			OrderedCollection new
				add: (
					OrderedCollection new
						add: (1.1 * 10);
						add: (2.1 * 10);
						add: (3.1 * 10);
						yourself);
				yourself).
	self
		assert: (result at: grads second)
		isMatrixCloseTo: (
			OrderedCollection new
				add: (-1.1 * 10);
				add: (-1.2 * 10);
				add: (-1.3 * 10);
				yourself)
]

{ #category : 'Test' }
GradientTest >> testProductCotangentMatrixCase5 [
	" f(x,y) = x.y 
	 vjp( f, x, v ) = v * df/dx = y . v^T
	 vjp( f, y, v ) = v * df/dy = v^T . x"

	| x0 x1 output grads result |

	x1 := tf floatInputNamed: 'x1'.
	x0 := tf floatConstantWith: #((1.1) (2.1)).

	output := x0 dot: x1.

	grads :=
		(Gradient
			of: output
			withRespectTo: (Array with: x0 with: x1)
			product: (Array with: #((1 0 0.5) (0 1 0.3)) asFloatTensor))
				allPartialDerivatives.

	result :=
		tf
			computeAll: grads
			feedingInputsWith: (
				Dictionary new
					at: 'x1' put: #((-1.1 -1.2 -1.3)) asFloatTensor;
					yourself).

	self
		assert: (result at: grads first)
		isMatrixCloseTo: (
			OrderedCollection new
				add: (-1.1 * 1 + (-1.2 * 0) + (-1.3 * 0.5));
				add: (-1.1 * 0 + (-1.2 * 1) + (-1.3 * 0.3));
				yourself).
	self
		assert: (result at: grads second)
		isMatrixCloseTo: (
			OrderedCollection new
				add: (
					OrderedCollection new
						add: (1.1 * 1 + (2.1 * 0));
						add: (1.1 * 0 + (2.1 * 1));
						add: (1.1 * 0.5 + (2.1 * 0.3));
						yourself);
				yourself)


]

{ #category : 'Test' }
GradientTest >> testProductCotangentScalar [
	" f(x,y) = xy 
	 vjp( f, x, v ) = v * df/dx = v * y
	 vjp( f, y, v ) = v * df/dy = v * x"

	| weights input output grads result |

	weights := tf floatInputNamed: 'weight'.
	input := tf constantWith: Float pi.

	output := weights * input.

	grads :=
		(Gradient
			of: output
			withRespectTo: (Array with: weights with: input)
			product: (Array with: 5.0 asTensor))
				allPartialDerivatives.

	result :=
		tf
			computeAll: grads
			feedingInputsWith: (
				Dictionary new
					at: 'weight' put: Float e asTensor;
					yourself).

	self assert: (result at: grads first) isFloatScalarCloseTo: Float pi * 5.0.
	self assert: (result at: grads second) isFloatScalarCloseTo: Float e * 5.0
]

{ #category : 'Test' }
GradientTest >> testProductCotangentVector [
	" f(x,y) = xy 
	 vjp( f, x, v ) = v * df/dx = v * y
	 vjp( f, y, v ) = v * df/dy = v * x"

	| x1 x2 output grads result |

	x1 := tf floatInputNamed: 'x1'.
	x2 := tf floatConstantWith: (Array with: Float pi with: -2).

	output := x1 * x2.

	grads :=
		(Gradient
			of: output
			withRespectTo: (Array with: x1 with: x2)
			product: (Array with: #(5.0 -3) asFloatTensor))
				allPartialDerivatives.

	result :=
		tf
			computeAll: grads
			feedingInputsWith: (
				Dictionary new
					at: 'x1' put: (Array with: Float e with: -7) asFloatTensor;
					yourself).

	self
		assert: (result at: grads first)
		isFloatVectorCloseTo: (Array with: Float pi * 5.0 with: -2 * -3).
	self
		assert: (result at: grads second)
		isFloatVectorCloseTo: (Array with: Float e * 5.0 with: -7 * -3)
]
