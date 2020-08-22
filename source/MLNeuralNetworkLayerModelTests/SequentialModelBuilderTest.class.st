Class {
	#name : 'SequentialModelBuilderTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'MLNeuralNetworkLayerModelTests'
}

{ #category : 'Test - Loss' }
SequentialModelBuilderTest >> testOneLayerAndCategoricalCrossEntropyLoss [

	| model result logicStatements loss expected |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 1
				builtWith: [:layer |
					layer
						inputSize: 3;
						weightInitializedToZero;
						biasInitializedTo: #(0.2)];
			build.

	loss := (TFLossBuilder for: model) buildCategoricalCrossEntropy.

	logicStatements := #((0 0 1) (0 1 1) (1 0 0) (1 1 1)) asFloatTensor.
	expected := #((0) (1) (0) (0)) asFloatTensor.
	result :=
		loss computeWith: (
			Dictionary new
				at: 'input' put: logicStatements;
				at: 'expected' put: expected;
				yourself).

	self assert: result isFloatScalarCloseTo: 0
]

{ #category : 'Test - Gradients' }
SequentialModelBuilderTest >> testOneLayerAndCategoricalCrossEntropyLossGradient [

	| model result logicStatements loss expected grads |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 1
				builtWith: [:layer |
					layer
						inputSize: 3;
						weightInitializedToZero;
						biasInitializedTo: #(0.2)];
			build.

	loss := (TFLossBuilder for: model) buildCategoricalCrossEntropy.
	grads := loss partialDerivativeWithRespectTo: (tf operationNamed: 'weight').
	logicStatements := #((0 0 1) (0 1 1) (1 0 0) (1 1 1)) asFloatTensor.
	expected := #((0) (1) (0) (0)) asFloatTensor.
	result :=
		grads computeWith: (
			Dictionary new
				at: 'input' put: logicStatements;
				at: 'expected' put: expected;
				yourself).

	self assert: result isMatrixCloseTo: #((0.5) (0.25) (0.5))
]

{ #category : 'Test - Loss' }
SequentialModelBuilderTest >> testOneLayerAndCategoricalCrossEntropyLossWithoutReducing [

	| model result logicStatements loss expected |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 1
				builtWith: [:layer |
					layer
						inputSize: 3;
						weightInitializedToZero;
						biasInitializedTo: #(0.2)];
			build.

	loss :=
		(TFLossBuilder for: model)
			withoutReducing;
			buildCategoricalCrossEntropy.

	logicStatements := #((0 0 1) (0 1 1) (1 0 0) (1 1 1)) asFloatTensor.
	expected := #((0) (1) (0) (0)) asFloatTensor.
	result :=
		loss computeWith: (
			Dictionary new
				at: 'input' put: logicStatements;
				at: 'expected' put: expected;
				yourself).

	self assert: result isFloatVectorCloseTo: #(0 0 0 0)
]

{ #category : 'Test - Gradients' }
SequentialModelBuilderTest >> testOneLayerAndCategoricalCrossEntropyLossWithoutReducingGradient [

	| model result logicStatements loss expected grads |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 1
				builtWith: [:layer |
					layer
						inputSize: 3;
						weightInitializedToZero;
						biasInitializedTo: #(0.2)];
			build.

	loss :=
		(TFLossBuilder for: model)
			withoutReducing;
			buildCategoricalCrossEntropy.
	grads := loss partialDerivativeWithRespectTo: (tf operationNamed: 'weight').
	logicStatements := #((0 0 1) (0 1 1) (1 0 0) (1 1 1)) asFloatTensor.
	expected := #((0) (1) (0) (0)) asFloatTensor.
	result :=
		grads computeWith: (
			Dictionary new
				at: 'input' put: logicStatements;
				at: 'expected' put: expected;
				yourself).

	self assert: result isMatrixCloseTo: #((2) (1) (2))
]

{ #category : 'Test - Gradients' }
SequentialModelBuilderTest >> testOneLayerAndMeanSquaredErrorGradient [

	| model result logicStatements loss expected grads |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 1
				builtWith: [:layer |
					layer
						inputSize: 3;
						weightInitializedToZero;
						biasInitializedTo: #(0.2)];
			build.

	loss := (TFLossBuilder for: model) buildSquaredError.
	grads := loss partialDerivativeWithRespectTo: (tf operationNamed: 'weight').
	logicStatements := #((0 0 1) (0 1 1) (1 0 0) (1 1 1)) asFloatTensor.
	expected := #((0) (1) (0) (0)) asFloatTensor.
	result :=
		grads computeWith: (
			Dictionary new
				at: 'input' put: logicStatements;
				at: 'expected' put: expected;
				yourself).

	self assert: result isMatrixCloseTo: #((0.2) (-0.3) (-0.2))
]

{ #category : 'Test - Loss' }
SequentialModelBuilderTest >> testOneLayerAndMeanSquaredErrorLoss [

	| model result logicStatements loss expected |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 1
				builtWith: [:layer |
					layer
						inputSize: 3;
						weightInitializedToZero;
						biasInitializedTo: #(0.2)];
			build.

	loss := (TFLossBuilder for: model) buildMeanSquaredError.

	logicStatements := #((0 0 1) (0 1 1) (1 0 0) (1 1 1)) asFloatTensor.
	expected := #((0) (1) (0) (0)) asFloatTensor.
	result :=
		loss computeWith: (
			Dictionary new
				at: 'input' put: logicStatements;
				at: 'expected' put: expected;
				yourself).

	self assert: result isFloatScalarCloseTo: 0.19
]

{ #category : 'Test - Loss' }
SequentialModelBuilderTest >> testOneLayerAndMeanSquaredErrorWithoutReducing [

	| model result logicStatements loss expected |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 1
				builtWith: [:layer |
					layer
						inputSize: 3;
						weightInitializedToZero;
						biasInitializedTo: #(0.2)];
			build.

	loss :=
		(TFLossBuilder for: model)
			withoutReducing;
			buildSquaredError.

	logicStatements := #((0 0 1) (0 1 1) (1 0 0) (1 1 1)) asFloatTensor.
	expected := #((0) (1) (0) (0)) asFloatTensor.
	result :=
		loss computeWith: (
			Dictionary new
				at: 'input' put: logicStatements;
				at: 'expected' put: expected;
				yourself).

	self assert: result isMatrixCloseTo: #((0.04) (0.64) (0.04) (0.04))
]

{ #category : 'Test - Gradients' }
SequentialModelBuilderTest >> testOneLayerAndMeanSquaredErrorWithoutReducingGradient [

	| model result logicStatements loss expected grads |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 1
				builtWith: [:layer |
					layer
						inputSize: 3;
						weightInitializedToZero;
						biasInitializedTo: #(0.2)];
			build.

	loss :=
		(TFLossBuilder for: model)
			withoutReducing;
			buildSquaredError.
	grads := loss partialDerivativeWithRespectTo: (tf operationNamed: 'weight').
	logicStatements := #((0 0 1) (0 1 1) (1 0 0) (1 1 1)) asFloatTensor.
	expected := #((0) (1) (0) (0)) asFloatTensor.
	result :=
		grads computeWith: (
			Dictionary new
				at: 'input' put: logicStatements;
				at: 'expected' put: expected;
				yourself).

	self assert: result isMatrixCloseTo: #((0.8) (-1.2) (-0.8))
]

{ #category : 'Test - Loss' }
SequentialModelBuilderTest >> testOneLayerAndSparseCategoricalCrossEntropyLoss [

	| model result logicStatements loss expected |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 2
				builtWith: [:layer |
					layer
						inputSize: 3;
						weightInitializedToZero;
						biasInitializedTo: #(0.2 0.8)];
			build.

	loss := (TFLossBuilder for: model) buildSparseCategoricalCrossEntropy.

	logicStatements := #((0 0 1) (0 1 1) (1 0 0) (1 1 1)) asFloatTensor.
	expected := #(0 1 0 0) asInt32Tensor.
	result :=
		loss computeWith: (
			Dictionary new
				at: 'input' put: logicStatements;
				at: 'expected' put: expected;
				yourself).

	self assert: result isFloatScalarCloseTo: 0.887488
]

{ #category : 'Test - Gradients' }
SequentialModelBuilderTest >> testOneLayerAndSparseCategoricalCrossEntropyLossGradient [

	| model result logicStatements loss expected grads |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 2
				builtWith: [:layer |
					layer
						inputSize: 3;
						weightInitializedToZero;
						biasInitializedTo: #(0.2 0.8)];
			build.

	loss := (TFLossBuilder for: model) buildSparseCategoricalCrossEntropy.
	grads := loss partialDerivativeWithRespectTo: (tf operationNamed: 'weight').
	logicStatements := #((0 0 1) (0 1 1) (1 0 0) (1 1 1)) asFloatTensor.
	expected := #(0 1 0 0) asInt32Tensor.
	result :=
		grads computeWith: (
			Dictionary new
				at: 'input' put: logicStatements;
				at: 'expected' put: expected;
				yourself).

	self
		assert: result
		isMatrixCloseTo: #(
			(-0.32282817 0.32282814) (-0.07282817 0.07282814) (-0.23424226 0.23424222))
]

{ #category : 'Test - Loss' }
SequentialModelBuilderTest >> testOneLayerAndSparseCategoricalCrossEntropyLossWithoutReducing [

	| model result logicStatements loss expected |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 2
				builtWith: [:layer |
					layer
						inputSize: 3;
						weightInitializedToZero;
						biasInitializedTo: #(0.2 0.8)];
			build.

	loss :=
		(TFLossBuilder for: model)
			withoutReducing;
			buildSparseCategoricalCrossEntropy.

	logicStatements := #((0 0 1) (0 1 1) (1 0 0) (1 1 1)) asFloatTensor.
	expected := #(0 1 0 0) asInt32Tensor.
	result :=
		loss computeWith: (
			Dictionary new
				at: 'input' put: logicStatements;
				at: 'expected' put: expected;
				yourself).

	self assert: result isFloatVectorCloseTo: #(1.0374879 0.4374879 1.0374879 1.0374879)
]

{ #category : 'Test - Gradients' }
SequentialModelBuilderTest >> testOneLayerAndSparseCategoricalCrossEntropyLossWithoutReducingGradient [

	| model result logicStatements loss expected grads |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 2
				builtWith: [:layer |
					layer
						inputSize: 3;
						weightInitializedToZero;
						biasInitializedTo: #(0.2 0.8)];
			build.

	loss :=
		(TFLossBuilder for: model)
			withoutReducing;
			buildSparseCategoricalCrossEntropy.
	grads := loss partialDerivativeWithRespectTo: (tf operationNamed: 'weight').
	logicStatements := #((0 0 1) (0 1 1) (1 0 0) (1 1 1)) asFloatTensor.
	expected := #(0 1 0 0) asInt32Tensor.
	result :=
		grads computeWith: (
			Dictionary new
				at: 'input' put: logicStatements;
				at: 'expected' put: expected;
				yourself).

	self
		assert: result
		isMatrixCloseTo: #(
			(-1.2913127 1.2913126) (-0.29131266 0.29131258) (-0.93696904 0.93696886))
]

{ #category : 'Test - Optimizer' }
SequentialModelBuilderTest >> testOneLayerAndSparseCategoricalCrossEntropyLossWithoutReducingOptimizer [

	| model logicStatements loss weight expected grads optimize |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 2
				builtWith: [:layer |
					layer
						inputSize: 3;
						weightInitializedToZero;
						biasInitializedTo: #(0.2 0.8)];
			build.

	loss :=
		(TFLossBuilder for: model)
			withoutReducing;
			buildSparseCategoricalCrossEntropy.
	weight := tf operationNamed: 'weight'.
	grads := loss partialDerivativeWithRespectTo: weight.
	optimize := (TFGradientDescent scalingBy: 0.2) apply: grads to: weight.

	logicStatements := #((0 0 1) (0 1 1) (1 0 0) (1 1 1)) asFloatTensor.
	expected := #(0 1 0 0) asInt32Tensor.
	tf
		compute: optimize
		feedingInputsWith: (
			Dictionary new
				at: 'input' put: logicStatements;
				at: 'expected' put: expected;
				yourself).
	self
		assertOutputOf: weight
		isMatrixCloseTo: #(
			(0.2582634 -0.2582634) (0.058262532 -0.058262532) (0.187393808 -0.187393808))
]

{ #category : 'Test - Forward' }
SequentialModelBuilderTest >> testOneLayerInitializedRandomly [

	| model result logicStatements |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 2
				builtWith: [:layer |
					layer
						inputSize: 3;
						weightInitializedRandomly;
						biasInitializedToZero];
			build.

	logicStatements := #((0 0 1) (0 1 1) (1 0 0) (1 1 1)) asFloatTensor.
	result :=
		model computeWith: (
			Dictionary new
				at: 'input' put: logicStatements;
				yourself).

	self assert: result type equals: TFTensor typeFloat.
	self assert: result shape equals: #(4 2)
]

{ #category : 'Test - Forward' }
SequentialModelBuilderTest >> testOneLayerInitializedToZero [

	| model result logicStatements |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 2
				builtWith: [:layer |
					layer
						inputSize: 3;
						weightInitializedToZero;
						biasInitializedToZero];
			build.

	logicStatements := #((0 0 1) (0 1 1) (1 0 0) (1 1 1)) asFloatTensor.
	result :=
		model computeWith: (
			Dictionary new
				at: 'input' put: logicStatements;
				yourself).

	self assert: result isMatrixCloseTo: #((0 0) (0 0) (0 0) (0 0))
]

{ #category : 'Test - Forward' }
SequentialModelBuilderTest >> testOneLayerInitializedToZeroWithBias [

	| model result logicStatements |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 2
				builtWith: [:layer |
					layer
						inputSize: 3;
						weightInitializedToZero;
						biasInitializedTo: #(0.7 0.3)];
			build.

	logicStatements := #((0 0 1) (0 1 1) (1 0 0) (1 1 1)) asFloatTensor.
	result :=
		model computeWith: (
			Dictionary new
				at: 'input' put: logicStatements;
				yourself).

	self assert: result isMatrixCloseTo: #((0.7 0.3) (0.7 0.3) (0.7 0.3) (0.7 0.3))
]

{ #category : 'Test - Forward' }
SequentialModelBuilderTest >> testOneLayerModelCharacteristics [

	| model |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 1
				builtWith: [:layer |
					layer
						inputSize: 2;
						weightInitializedTo: #((2) (3))];
			build.

	self
		assert: model trainableVariables
		hasTheSameOperationsAs: (Array with: (tf operationNamed: 'weight')).

	self assert: model printString equals: 'Sequential Model (Layers: 1)
Dense Layer[2 -> 1]'
]

{ #category : 'Test - Forward' }
SequentialModelBuilderTest >> testOneLayerModelPrediction [

	| model result |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 1
				builtWith: [:layer |
					layer
						inputSize: 2;
						weightInitializedTo: #((2) (3))];
			build.

	result :=
		model computeWith: (
			Dictionary new
				at: 'input' put: #((1 2)) asFloatTensor;
				yourself).

	self
		assert: result
		isMatrixCloseTo: (
			OrderedCollection new
				add: 1 * 2 + (2 * 3);
				yourself).

	self
		assert: model trainableVariables
		hasTheSameOperationsAs: (Array with: (tf operationNamed: 'weight'))
]

{ #category : 'Test - Forward' }
SequentialModelBuilderTest >> testOneLayerWithBias [

	| model result |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 1
				builtWith: [:layer |
					layer
						inputSize: 2;
						weightInitializedTo: #((2) (3));
						biasInitializedTo: #(4)];
			build.

	result :=
		model computeWith: (
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

{ #category : 'Test - Forward' }
SequentialModelBuilderTest >> testOneLayerWithBiasAndActivation [

	| model result |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 1
				builtWith: [:layer |
					layer
						inputSize: 2;
						weightInitializedTo: #((2) (3));
						biasInitializedTo: #(4);
						activatedBy: TFSigmoidActivation];
			build.

	result :=
		model computeWith: (
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

{ #category : 'Test - Forward' }
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
						activatedBy: TFSigmoidActivation];
			addDenseLayerSized: 1
				builtWith: [:layer |
					layer
						weightInitializedTo: #((-2.5) (-5.2));
						biasInitializedToZero];
			build.

	self
		assert: model trainableVariables
		hasTheSameOperationsAs: (
			Array
				with: (tf operationNamed: 'weight')
				with: (tf operationNamed: 'bias')
				with: (tf operationNamed: 'weight_2')
				with: (tf operationNamed: 'bias_2')).

	self
		assert: model printString
		equals: 'Sequential Model (Layers: 2)
Dense Layer[3 -> 2]
Dense Layer[2 -> 1]'
]

{ #category : 'Test - Forward' }
SequentialModelBuilderTest >> testTwoLayersModelPrediction [

	| model result logicStatements |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 2
				builtWith: [:layer |
					layer
						inputSize: 3;
						weightInitializedTo: #((1 1.3) (0.1 -1.1) (0.2 1.7));
						biasInitializedTo: #(0.7 0.3);
						activatedBy: TFSigmoidActivation];
			addDenseLayerSized: 1
				builtWith: [:layer |
					layer
						weightInitializedTo: #((-2.5) (-5.2));
						biasInitializedToZero];
			build.

	logicStatements := #((0 0 1) (0 1 1) (1 0 0) (1 1 1)) asFloatTensor.
	result :=
		model computeWith: (
			Dictionary new
				at: 'input' put: logicStatements;
				yourself).

	self assert: result isMatrixCloseTo: #((-6.357518) (-5.524584) (-6.440332) (-6.8832903)).

	self
		assert: model trainableVariables
		hasTheSameOperationsAs: (
			Array
				with: (tf operationNamed: 'weight')
				with: (tf operationNamed: 'bias')
				with: (tf operationNamed: 'weight_2')
				with: (tf operationNamed: 'bias_2'))
]
