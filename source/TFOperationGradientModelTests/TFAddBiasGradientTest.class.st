Class {
	#name : 'TFAddBiasGradientTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationGradientModelTests'
}

{ #category : 'Tests' }
TFAddBiasGradientTest >> testInputCantHaveRankLowerThanTwo [

	| input |

	input := tf variableNamed: 'input' with: #(2 3) asInt32Tensor.

	self
		assert: [TFAddBiasGradient withGradientsOfInputs: input]
		raisesExceptionWith:
			'INVALID_ARGUMENT: Shape must be at least rank 2 but is rank 1 for ''BiasAddGrad'' (op: ''BiasAddGrad'') with input shapes: [2].'
]

{ #category : 'Tests' }
TFAddBiasGradientTest >> testInputWithMatrixOfShape2x1 [

	| input output |

	input := tf variableNamed: 'input' with: #((2) (3)) asInt32Tensor.

	output := TFAddBiasGradient withGradientsOfInputs: input.

	self assertOutputOf: output isIntegerVectorEqualsTo: (Array with: 2 + 3)
]

{ #category : 'Tests' }
TFAddBiasGradientTest >> testInputWithMatrixOfShape2x2 [

	| input output |

	input := tf variableNamed: 'input' with: #((2 5) (3 7)) asInt32Tensor.

	output := TFAddBiasGradient withGradientsOfInputs: input.

	self
		assertOutputOf: output
		isIntegerVectorEqualsTo: (
			OrderedCollection new
				add: 2 + 3;
				add: 5 + 7;
				yourself)
]

{ #category : 'Tests' }
TFAddBiasGradientTest >> testInputWithMatrixOfShape2x3 [

	| input output |

	input := tf variableNamed: 'input' with: #((2 5 -1) (3 7 16)) asFloatTensor.

	output := TFAddBiasGradient withGradientsOfInputs: input.
	
	self
		assertOutputOf: output
		isFloatVectorCloseTo: (
			OrderedCollection new
				add: 2 + 3;
				add: 5 + 7;
				add: -1 + 16;
				yourself)
]

{ #category : 'Tests' }
TFAddBiasGradientTest >> testInputWithMatrixOfShape3x3 [

	| input output |

	input := tf variableNamed: 'input' with: #((2 5 -1) (3 7 16) (10 -4 0.5)) asFloatTensor.

	output := TFAddBiasGradient withGradientsOfInputs: input.

	self
		assertOutputOf: output
		isFloatVectorCloseTo: (
			OrderedCollection new
				add: 2 + 3 + 10;
				add: 5 + 7 - 4;
				add: -1 + 16 + 0.5;
				yourself)
]
