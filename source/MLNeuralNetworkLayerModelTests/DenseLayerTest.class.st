Class {
	#name : 'DenseLayerTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#instVars : [
		'tff1'
	],
	#category : 'MLNeuralNetworkLayerModelTests'
}

{ #category : 'Test' }
DenseLayerTest >> testCreating [

	| layer input result |

	input := tf integerInputNamed: 'input'.
	layer :=
		DenseLayer
			receiving: input
			featuresOfInput: 2
			featuresOfOutput: 1
			weightSpecifiedBy: (
				TFVariableSpecification
					of: TFTensor typeInt32
					initializedWith: (TFConstantInitializer with: #((2) (3)) asInt32Tensor)).

	result :=
		tf
			compute: layer
			feedingInputsWith: (
				Dictionary new
					at: 'input' put: #((1 2)) asInt32Tensor;
					yourself).

	self
		assert: result
		isIntegerMatrixCloseTo: (
			OrderedCollection new
				add: 1 * 2 + (2 * 3);
				yourself)
]

{ #category : 'Test' }
DenseLayerTest >> testCreatingWithBias [

	| layer input result |

	input := tf floatInputNamed: 'input'.
	layer :=
		DenseLayer
			receiving: input
			featuresOfInput: 2
			featuresOfOutput: 1
			weightSpecifiedBy: (
				TFVariableSpecification
					of: TFTensor typeFloat
					initializedWith: (TFConstantInitializer with: #((2) (3)) asFloatTensor))
			biasSpecifiedBy: (
				TFVariableSpecification
					of: TFTensor typeFloat
					initializedWith: (TFConstantInitializer with: #(4) asFloatTensor)).

	result :=
		tf
			compute: layer
			feedingInputsWith: (
				Dictionary new
					at: 'input' put: #((1 2)) asFloatTensor;
					yourself).

	self
		assert: result
		isMatrixCloseTo: (
			OrderedCollection new
				add: (1 * 2 + (2 * 3)) + 4;
				yourself)
]

{ #category : 'Test' }
DenseLayerTest >> testCreatingWithBiasAndActivation [

	| layer input result |

	input := tf floatInputNamed: 'input'.
	layer :=
		DenseLayer
			receiving: input
			featuresOfInput: 2
			featuresOfOutput: 1
			weightSpecifiedBy: (
				TFVariableSpecification
					of: TFTensor typeFloat
					initializedWith: (TFConstantInitializer with: #((2) (3)) asFloatTensor))
			biasSpecifiedBy: (
				TFVariableSpecification
					of: TFTensor typeFloat
					initializedWith: (TFConstantInitializer with: #(4) asFloatTensor))
			activatedBy: TFSigmoidActivation.

	result :=
		tf
			compute: layer
			feedingInputsWith: (
				Dictionary new
					at: 'input' put: #((1 2)) asFloatTensor;
					yourself).

	self
		assert: result
		isMatrixCloseTo: (
			OrderedCollection new
				add: ((1 * 2 + (2 * 3)) + 4) sigmoid;
				yourself)
]

{ #category : 'Test' }
DenseLayerTest >> testCreatingWithBiasAndActivationUsingFloats [

	| layer result input |

	layer :=
		DenseLayer
			receiving: (tf floatInputNamed: 'input')
			featuresOfInput: 2
			featuresOfOutput: 1
			weightSpecifiedBy: (
				TFVariableSpecification
					of: TFTensor typeFloat
					initializedWith: (TFConstantInitializer with: #((2) (3)) asFloatTensor))
			biasSpecifiedBy: (
				TFVariableSpecification
					of: TFTensor typeFloat
					initializedWith: (TFConstantInitializer with: #(4) asFloatTensor))
			activatedBy: TFSigmoidActivation.

	input := #((1 2) (-1 0.4)) asFloatTensor.
	result :=
		tf
			compute: layer
			feedingInputsWith: (
				Dictionary new
					at: 'input' put: input;
					yourself).

	self
		assert: result
		isMatrixCloseTo: (
			OrderedCollection new
				add: ((1 * 2 + (2 * 3)) + 4) sigmoid;
				add: ((-1 * 2 + (0.4 * 3)) + 4) sigmoid;
				yourself)
]

{ #category : 'Test' }
DenseLayerTest >> testCreatingWithBiasAndActivationUsingIntegers [

	| layer logicStatements result |

	layer :=
		DenseLayer
			receiving: (tf integerInputNamed: 'input')
			featuresOfInput: 2
			featuresOfOutput: 1
			weightSpecifiedBy: (
				TFVariableSpecification
					of: TFTensor typeInt32
					initializedWith: (TFConstantInitializer with: #((1) (2)) asInt32Tensor))
			biasSpecifiedBy: (
				TFVariableSpecification
					of: TFTensor typeInt32
					initializedWith: (TFConstantInitializer with: #(1) asInt32Tensor))
			activatedBy: TFReluActivation.

	logicStatements := #((0 0) (0 1) (1 0) (1 1)) asInt32Tensor.
	result :=
		tf
			compute: layer
			feedingInputsWith: (
				Dictionary new
					at: 'input' put: logicStatements;
					yourself).

	self
		assert: result
		isIntegerMatrixCloseTo: (
			OrderedCollection new
				add: (0 * 1 + (0 * 2)) + 1;
				add: (0 * 1 + (1 * 2)) + 1;
				add: (1 * 1 + (0 * 2)) + 1;
				add: (1 * 1 + (1 * 2)) + 1;
				yourself)
]

{ #category : 'Test' }
DenseLayerTest >> testDenseLayerAsInputOfOtherLayer [

	| layer secondLayer logicStatements result |

	layer :=
		DenseLayer
			receiving: (tf floatInputNamed: 'input')
			featuresOfInput: 3
			featuresOfOutput: 2
			weightSpecifiedBy: (
				TFVariableSpecification
					of: TFTensor typeFloat
					initializedWith: (
						TFConstantInitializer with: #((1 1.3) (0.1 -1.1) (0.2 1.7)) asFloatTensor))
			biasSpecifiedBy: (
				TFVariableSpecification
					of: TFTensor typeFloat
					initializedWith: (TFConstantInitializer with: #(0.7 0.3) asFloatTensor))
			activatedBy: TFSigmoidActivation.
	secondLayer :=
		DenseLayer
			receiving: layer
			featuresOfInput: 2
			featuresOfOutput: 1
			weightSpecifiedBy: (
				TFVariableSpecification
					of: TFTensor typeFloat
					initializedWith: (TFConstantInitializer with: #((-2.5) (-5.2)) asFloatTensor))
			biasSpecifiedBy: (
				TFVariableSpecification of: TFTensor typeFloat initializedWith: TFZeroInitializer new).

	logicStatements := #((0 0 1) (0 1 1) (1 0 0) (1 1 1)) asFloatTensor.
	result :=
		tf
			compute: secondLayer
			feedingInputsWith: (
				Dictionary new
					at: 'input' put: logicStatements;
					yourself).

	self assert: result isMatrixCloseTo: #(-6.357518 -5.524584 -6.440332 -6.8832903)
]
