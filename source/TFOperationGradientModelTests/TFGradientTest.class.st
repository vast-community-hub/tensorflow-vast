Class {
	#name : 'TFGradientTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationGradientModelTests'
}

{ #category : 'Test' }
TFGradientTest >> testAccessingGradientIndependently [

	| weights input output grads result |

	weights := tf floatInputNamed: 'var'.
	input := tf constantWith: Float pi.

	output := weights * input.

	grads := TFGradient of: (Array with: output) withRespectTo: (Array with: weights with: input).

	result :=
		tf
			compute: (grads gradientRespectTo: input)
			feedingInputsWith: (
				Dictionary new
					at: 'var' put: 1.0 asTensor;
					yourself).

	self assertOutputOf: result isFloatScalarCloseTo: 1.0
]

{ #category : 'Test' }
TFGradientTest >> testElementMultiplicationGradient [

	| weights input output gradWeight result |

	weights := tf floatInputNamed: 'var'.
	input := tf constantWith: Float pi.

	output := weights * input.

	gradWeight := TFGradient of: (Array with: output) withRespectTo: (Array with: weights).

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
TFGradientTest >> testElementMultiplicationGradientWithRespectToSeveralVariables [

	| weights input output grads result |

	weights := tf floatInputNamed: 'var'.
	input := tf constantWith: Float pi.

	output := weights * input.

	grads :=
		(TFGradient of: (Array with: output) withRespectTo: (Array with: weights with: input))
			allGradients.

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
