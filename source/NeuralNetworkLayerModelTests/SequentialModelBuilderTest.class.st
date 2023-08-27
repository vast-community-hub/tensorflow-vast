Class {
	#name : 'SequentialModelBuilderTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'NeuralNetworkLayerModelTests'
}

{ #category : 'Tests' }
SequentialModelBuilderTest >> firstDenseLayerWeights [

	^tf operationNamed: 'dense/kernel'
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
SequentialModelBuilderTest >> inputWithFourFeatures [

	^#((1 2 3 4) (4 3 2 1)) asFloatTensor
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
SequentialModelBuilderTest >> inputWithThreeFeatures [

	^#((0 0 1) (0 1 1) (1 0 0) (1 1 1)) asFloatTensor
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
SequentialModelBuilderTest >> inputWithTwoFeatures [

	^#((1 2)) asFloatTensor
]

{ #category : 'Tests' }
SequentialModelBuilderTest >> testBuildWithArgMaxOnLogits [

	| model inputValues |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 2
				builtWith: [:layer |
					layer
						inputSize: 4;
						weightInitializedTo: #((0.2 -0.3) (0.1 0.5) (-0.2 0.1) (0.2 0.3))];
			buildApplyingToLogits: [:logits | logits argMaxOnRows].

	inputValues := self inputWithFourFeatures.
	self
		assert: (
			model logits computeWith: (
				Dictionary new
					at: model inputVariableName put: inputValues;
					yourself))
		isMatrixCloseTo: #((0.6 2.2) (0.9 0.8)).
	self assert: (model predictFrom: inputValues) isVectorTyped: Int64DataType new closeTo: #(1 0)
]

{ #category : 'Tests' }
SequentialModelBuilderTest >> testOneFlattenLayer [

	| model result expectedOutput |

	model :=
		(SequentialModelBuilder on: tf)
			addFlattenLayerSized: #( 2 2 ) asTensorShape;
			build.

	result := model predictFrom: #((
	((1.11 1.12) (1.21 1.22))
	((2.11 2.12) (2.21 2.22))
	((3.11 3.12) (3.21 3.22))
)) asFloatTensor.

	expectedOutput := #((
	(1.11 1.12 1.21 1.22)
	(2.11 2.12 2.21 2.22)
	(3.11 3.12 3.21 3.22)
)).

	self
		assert: result
		isOf: FloatDataType new
		with: #(3 4) asTensorShape
		comparedTo: expectedOutput flattened
		complying: [:actual :expected | self assert: actual closeTo: expected]


]

{ #category : 'Tests' }
SequentialModelBuilderTest >> testOneLayerInitializedRandomly [

	| model result |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 2 builtWith: [:layer | layer inputSize: 3];
			build.

	result := model predictFrom: self inputWithThreeFeatures.

	self assert: result type equals: FloatDataType new.
	self assert: result shape equals: (TensorShape matrixSized: 4 by: 2)
]

{ #category : 'Tests' }
SequentialModelBuilderTest >> testOneLayerInitializedToZero [

	| model |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 2
				builtWith: [:layer |
					layer
						inputSize: 3;
						weightInitializedToZero;
						biasInitializedToZero];
			build.

	self
		assert: (model predictFrom: self inputWithThreeFeatures)
		isMatrixCloseTo: #((0 0) (0 0) (0 0) (0 0))
]

{ #category : 'Tests' }
SequentialModelBuilderTest >> testOneLayerInitializedToZeroWithBias [

	| model |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 2
				builtWith: [:layer |
					layer
						inputSize: 3;
						weightInitializedToZero;
						biasInitializedTo: #(0.7 0.3)];
			build.

	self
		assert: (model predictFrom: self inputWithThreeFeatures)
		isMatrixCloseTo: #((0.7 0.3) (0.7 0.3) (0.7 0.3) (0.7 0.3))
]

{ #category : 'Tests' }
SequentialModelBuilderTest >> testOneLayerModelCharacteristics [

	| model |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 1
				builtWith: [:layer |
					layer
						inputSize: 2;
						weightInitializedTo: #((2) (3));
						withoutBias];
			build.

	self
		assert: model trainableVariables
		hasTheSameOperationsAs: (Array with: self firstDenseLayerWeights).

	self assert: model printString equals: 'Sequential Model with 1 layer
Dense Layer[2 -> 1]'
]

{ #category : 'Tests' }
SequentialModelBuilderTest >> testOneLayerModelPrediction [

	| model |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 1
				builtWith: [:layer |
					layer
						inputSize: 2;
						weightInitializedTo: #((2) (3));
						withoutBias];
			build.

	self
		assert: (model predictFrom: self inputWithTwoFeatures)
		isMatrixCloseTo: (
			(OrderedCollection new)
				add: 1 * 2 + (2 * 3);
				yourself).
	self
		assert: model trainableVariables
		hasTheSameOperationsAs: (Array with: self firstDenseLayerWeights)
]

{ #category : 'Tests' }
SequentialModelBuilderTest >> testOneLayerWithBias [

	| model |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 1
				builtWith: [:layer |
					layer
						inputSize: 2;
						weightInitializedTo: #((2) (3));
						biasInitializedTo: #(4)];
			build.

	self
		assert: (model predictFrom: self inputWithTwoFeatures)
		isMatrixCloseTo: (
			(OrderedCollection new)
				add: 1 * 2 + (2 * 3) + 4;
				yourself)
]

{ #category : 'Tests' }
SequentialModelBuilderTest >> testOneLayerWithBiasAndActivation [

	| model |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 1
				builtWith: [:layer |
					layer
						inputSize: 2;
						weightInitializedTo: #((2) (3));
						biasInitializedTo: #(4);
						activatedBySigmoid];
			build.

	self
		assert: (model predictFrom: self inputWithTwoFeatures)
		isMatrixCloseTo: (
			(OrderedCollection new)
				add: (1 * 2 + (2 * 3) + 4) sigmoid;
				yourself)
]

{ #category : 'Tests' }
SequentialModelBuilderTest >> testTwoLayersModelCharacteristics [

	| model |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 2
				builtWith: [:layer |
					layer
						inputSize: 3;
						weightInitializedTo: #((1 1.3) (0.1 -1.1) (0.2 1.7));
						biasInitializedTo: #(0.7 0.3);
						activatedBySigmoid];
			addDenseLayerSized: 1
				builtWith: [:layer | layer weightInitializedTo: #((-2.5) (-5.2))];
			build.

	self
		assert: model trainableVariables
		hasTheSameOperationsAs: (
			Array
				with: (tf operationNamed: 'dense/kernel')
				with: (tf operationNamed: 'dense/bias')
				with: (tf operationNamed: 'dense_1/kernel')
				with: (tf operationNamed: 'dense_1/bias')).

	self
		assert: model printString
		equals: 'Sequential Model with 2 layers
Dense Layer[3 -> 2]
Dense Layer[2 -> 1]'
]

{ #category : 'Tests' }
SequentialModelBuilderTest >> testTwoLayersModelPrediction [

	| model |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 2
				builtWith: [:layer |
					layer
						inputSize: 3;
						weightInitializedTo: #((1 1.3) (0.1 -1.1) (0.2 1.7));
						biasInitializedTo: #(0.7 0.3);
						activatedBySigmoid];
			addDenseLayerSized: 1
				builtWith: [:layer | layer weightInitializedTo: #((-2.5) (-5.2))];
			build.

	self
		assert: (model predictFrom: self inputWithThreeFeatures)
		isMatrixCloseTo: #((-6.357518) (-5.524584) (-6.440332) (-6.8832903)).
	self
		assert: model trainableVariables
		hasTheSameOperationsAs: (
			Array
				with: (tf operationNamed: 'dense/kernel')
				with: (tf operationNamed: 'dense/bias')
				with: (tf operationNamed: 'dense_1/kernel')
				with: (tf operationNamed: 'dense_1/bias'))
]
