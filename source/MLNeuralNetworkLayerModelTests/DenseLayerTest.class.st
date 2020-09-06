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

	| layer result |

	layer :=
		DenseLayer
			receiving: (tf integerInputNamed: 'input')
			featuresOfInput: 2
			featuresOfOutput: 1
			weightSpecifiedBy: (
				VariableNodeSpecification
					of: TFTensor typeInt32
					initializedWith: (ConstantInitializer with: #((2) (3)) asInt32Tensor)).

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
				yourself).

	self
		assert: layer trainableVariables
		hasTheSameOperationsAs: (Array with: (tf operationNamed: 'weight'))
]

{ #category : 'Test' }
DenseLayerTest >> testCreatingWithBias [

	| layer result |

	layer :=
		DenseLayer
			receiving: (tf floatInputNamed: 'input')
			featuresOfInput: 2
			featuresOfOutput: 1
			weightSpecifiedBy: (
				VariableNodeSpecification
					of: TFTensor typeFloat
					initializedWith: (ConstantInitializer with: #((2) (3)) asFloatTensor))
			biasSpecifiedBy: (
				VariableNodeSpecification
					of: TFTensor typeFloat
					initializedWith: (ConstantInitializer with: #(4) asFloatTensor)).

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
				yourself).

	self
		assert: layer trainableVariables
		hasTheSameOperationsAs:
			(Array with: (tf operationNamed: 'weight') with: (tf operationNamed: 'bias'))
]

{ #category : 'Test' }
DenseLayerTest >> testCreatingWithBiasAndActivation [

	| layer result |

	layer :=
		DenseLayer
			receiving: (tf floatInputNamed: 'input')
			featuresOfInput: 2
			featuresOfOutput: 1
			weightSpecifiedBy: (
				VariableNodeSpecification
					of: TFTensor typeFloat
					initializedWith: (ConstantInitializer with: #((2) (3)) asFloatTensor))
			biasSpecifiedBy: (
				VariableNodeSpecification
					of: TFTensor typeFloat
					initializedWith: (ConstantInitializer with: #(4) asFloatTensor))
			activatedBy: Sigmoid.

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
				yourself).

	self
		assert: layer trainableVariables
		hasTheSameOperationsAs:
			(Array with: (tf operationNamed: 'weight') with: (tf operationNamed: 'bias'))
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
				VariableNodeSpecification
					of: TFTensor typeFloat
					initializedWith: (ConstantInitializer with: #((2) (3)) asFloatTensor))
			biasSpecifiedBy: (
				VariableNodeSpecification
					of: TFTensor typeFloat
					initializedWith: (ConstantInitializer with: #(4) asFloatTensor))
			activatedBy: Sigmoid.

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
				yourself).

	self
		assert: layer trainableVariables
		hasTheSameOperationsAs:
			(Array with: (tf operationNamed: 'weight') with: (tf operationNamed: 'bias'))
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
				VariableNodeSpecification
					of: TFTensor typeInt32
					initializedWith: (ConstantInitializer with: #((1) (2)) asInt32Tensor))
			biasSpecifiedBy: (
				VariableNodeSpecification
					of: TFTensor typeInt32
					initializedWith: (ConstantInitializer with: #(1) asInt32Tensor))
			activatedBy: RectifiedLinear.

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
				yourself).

	self
		assert: layer trainableVariables
		hasTheSameOperationsAs:
			(Array with: (tf operationNamed: 'weight') with: (tf operationNamed: 'bias'))
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
				VariableNodeSpecification
					of: TFTensor typeFloat
					initializedWith:
						(ConstantInitializer with: #((1 1.3) (0.1 -1.1) (0.2 1.7)) asFloatTensor))
			biasSpecifiedBy: (
				VariableNodeSpecification
					of: TFTensor typeFloat
					initializedWith: (ConstantInitializer with: #(0.7 0.3) asFloatTensor))
			activatedBy: Sigmoid.
	secondLayer :=
		DenseLayer
			receiving: layer
			featuresOfInput: 2
			featuresOfOutput: 1
			weightSpecifiedBy: (
				VariableNodeSpecification
					of: TFTensor typeFloat
					initializedWith: (ConstantInitializer with: #((-2.5) (-5.2)) asFloatTensor))
			biasSpecifiedBy: (
				VariableNodeSpecification of: TFTensor typeFloat initializedWith: ZeroInitializer new).

	logicStatements := #((0 0 1) (0 1 1) (1 0 0) (1 1 1)) asFloatTensor.
	result :=
		tf
			compute: secondLayer
			feedingInputsWith: (
				Dictionary new
					at: 'input' put: logicStatements;
					yourself).

	self assert: result isMatrixCloseTo: #(-6.357518 -5.524584 -6.440332 -6.8832903).

	self
		assert: layer trainableVariables
		hasTheSameOperationsAs:
			(Array with: (tf operationNamed: 'weight') with: (tf operationNamed: 'bias')).
	self
		assert: secondLayer trainableVariables
		hasTheSameOperationsAs:
			(Array with: (tf operationNamed: 'weight_2') with: (tf operationNamed: 'bias_2'))
]
