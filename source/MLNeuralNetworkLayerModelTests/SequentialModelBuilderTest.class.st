Class {
	#name : 'SequentialModelBuilderTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'MLNeuralNetworkLayerModelTests'
}

{ #category : 'Test' }
SequentialModelBuilderTest >> testOneLayer [

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
		tf
			compute: model
			feedingInputsWith: (
				Dictionary new
					at: 'input' put: #((1 2)) asFloatTensor;
					yourself).

	self
		assert: result
		isMatrixCloseTo: (
			OrderedCollection new
				add: 1 * 2 + (2 * 3);
				yourself)
]

{ #category : 'Test' }
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
		tf
			compute: model
			feedingInputsWith: (
				Dictionary new
					at: 'input' put: logicStatements;
					yourself).

	self assert: result type equals: TFTensor typeFloat.
	self assert: result shape equals: #(4 2)
]

{ #category : 'Test' }
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
		tf
			compute: model
			feedingInputsWith: (
				Dictionary new
					at: 'input' put: logicStatements;
					yourself).

	self assert: result isMatrixCloseTo: #((0 0) (0 0) (0 0) (0 0))
]

{ #category : 'Test' }
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
		tf
			compute: model
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
		tf
			compute: model
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
SequentialModelBuilderTest >> testTwoLayers [

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
		tf
			compute: model
			feedingInputsWith: (
				Dictionary new
					at: 'input' put: logicStatements;
					yourself).

	self assert: result isMatrixCloseTo: #(-6.357518 -5.524584 -6.440332 -6.8832903)
]
