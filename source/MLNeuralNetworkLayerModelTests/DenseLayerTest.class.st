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
