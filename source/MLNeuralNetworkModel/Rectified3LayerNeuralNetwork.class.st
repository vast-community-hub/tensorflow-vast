Class {
	#name : 'Rectified3LayerNeuralNetwork',
	#superclass : 'NeuralNetwork',
	#instVars : [
		'input',
		'hidden1',
		'hidden2',
		'prediction',
		'expectedLabel',
		'loss',
		'weightsByLayer',
		'biasesByLayer',
		'backpropByLayer',
		'batchSize',
		'learn',
		'tf',
		'lossToMinimize',
		'learntParameters',
		'modelOutput',
		'optimizer'
	],
	#category : 'MLNeuralNetworkModel'
}

{ #category : 'Instance Creation' }
Rectified3LayerNeuralNetwork class >> new [

	^super new initialize
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Rectified3LayerNeuralNetwork >> initialize [

	tf := TensorFlowComputation new.
	learntParameters := OrderedCollection new.
	input := tf floatInputNamed: 'input'.
	weightsByLayer := Dictionary new.
	biasesByLayer := Dictionary new.

	self initializeLayer1.
	self initializeLayer2.
	self initializeLayer3.
	self initializeLossLayer.

	backpropByLayer := Dictionary new.
	optimizer := TFGradientDescent scalingBy: 0.0001 asTensor.
	batchSize := (input value sizeOn: 0) castTo: TFTensor typeFloat.
	self initializeLearningLayer3.
	self initializeLearningLayer2.
	self initializeLearningLayer1.

	learn := TFIdentity of: loss evaluatedOnlyAfter: learntParameters
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Rectified3LayerNeuralNetwork >> initializeLayer1 [

	| layerInput inputSize outputSize weights biases score |

	layerInput := input.
	inputSize := 28 * 28.
	outputSize := 128.
	weights :=
		tf
			floatVariableNamed: 'weights1'
			shaped: (Array with: inputSize with: outputSize)
			initializedWith: (self randomInitializerFor: inputSize).
	biases :=
		tf
			floatVariableNamed: 'biases1'
			shaped: (Array with: outputSize)
			initializedWith: TFZeroInitializer new.

	score := (layerInput dot: weights) biasedBy: biases.
	hidden1 := TFReluActivation activating: score.

	weightsByLayer at: 1 put: weights.
	biasesByLayer at: 1 put: biases
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Rectified3LayerNeuralNetwork >> initializeLayer2 [

	| layerInput inputSize outputSize weights biases score |

	layerInput := hidden1.
	inputSize := 128.
	outputSize := 32.
	weights :=
		tf
			floatVariableNamed: 'weights2'
			shaped: (Array with: inputSize with: outputSize)
			initializedWith: (self randomInitializerFor: inputSize).
	biases :=
		tf
			floatVariableNamed: 'biases2'
			shaped: (Array with: outputSize)
			initializedWith: TFZeroInitializer new.

	score := (layerInput dot: weights) biasedBy: biases.
	hidden2 := TFReluActivation activating: score.

	weightsByLayer at: 2 put: weights.
	biasesByLayer at: 2 put: biases
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Rectified3LayerNeuralNetwork >> initializeLayer3 [

	| layerInput inputSize outputSize weights biases |

	layerInput := hidden2.
	inputSize := 32.
	outputSize := 10.
	weights :=
		tf
			floatVariableNamed: 'weights3'
			shaped: (Array with: inputSize with: outputSize)
			initializedWith: (self randomInitializerFor: inputSize).
	biases :=
		tf
			floatVariableNamed: 'biases3'
			shaped: (Array with: outputSize)
			initializedWith: TFZeroInitializer new.

	modelOutput := (layerInput dot: weights) biasedBy: biases.
	prediction :=
		TFIndexWithMaximum
			named: 'prediction'
			in: (TFSoftmaxActivation activating: modelOutput)
			across: 1.

	weightsByLayer at: 3 put: weights.
	biasesByLayer at: 3 put: biases
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Rectified3LayerNeuralNetwork >> initializeLearningLayer1 [

	| layerInput layerOutput weights bias gradient biasGradient |

	layerInput := input.
	layerOutput := hidden1.
	weights := weightsByLayer at: 1.
	bias := biasesByLayer at: 1.

	gradient := TFReluGradient considering: (backpropByLayer at: 2) andGradientsOfInputs: layerOutput.
	biasGradient := TFReduceMean ofValuesIn: gradient alongside: #(0).

	learntParameters
		add: (optimizer apply: (layerInput transposedDot: gradient) / batchSize to: weights);
		add: (optimizer apply: biasGradient to: bias)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Rectified3LayerNeuralNetwork >> initializeLearningLayer2 [

	| layerInput layerOutput weights bias gradient biasGradient |

	layerInput := hidden1.
	layerOutput := hidden2.
	weights := weightsByLayer at: 2.
	bias := biasesByLayer at: 2.

	gradient := TFReluGradient considering: (backpropByLayer at: 3) andGradientsOfInputs: layerOutput.
	biasGradient := TFReduceMean ofValuesIn: gradient alongside: #(0).

	learntParameters
		add: (optimizer apply: (layerInput transposedDot: gradient) / batchSize to: weights);
		add: (optimizer apply: biasGradient to: bias).

	backpropByLayer at: 2 put: (gradient dotTransposing: weights)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Rectified3LayerNeuralNetwork >> initializeLearningLayer3 [

	| layerInput weights bias gradient biasGradient |

	layerInput := hidden2.
	weights := weightsByLayer at: 3.
	bias := biasesByLayer at: 3.

	gradient := lossToMinimize backpropagatedGradient.
	biasGradient := TFReduceMean ofValuesIn: gradient alongside: #(0).

	learntParameters
		add: (optimizer apply: (layerInput transposedDot: gradient) / batchSize to: weights);
		add: (optimizer apply: biasGradient to: bias).

	backpropByLayer at: 3 put: (TFMatrixMultiplication of: gradient andTransposed: weights)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Rectified3LayerNeuralNetwork >> initializeLossLayer [

	tf
		inScopeNamed: 'loss'
		do: [
			expectedLabel := tf integerInputNamed: 'expectedLabel'.
			lossToMinimize := TFCrossEntropyError of: modelOutput whenExpectedIs: expectedLabel.
			loss := TFReduceMean named: 'loss' ofValuesIn: lossToMinimize loss alongside: #(0)]
]

{ #category : 'Accessing' }
Rectified3LayerNeuralNetwork >> inputSize [

	^28 * 28
]

{ #category : 'Predicting' }
Rectified3LayerNeuralNetwork >> predictFrom: aFeatureTensor [

	^tf
		compute: prediction
		feedingInputsWith: (
			Dictionary new
				at: input operationName put: aFeatureTensor asFloatTensor;
				yourself)
]

{ #category : 'Predicting' }
Rectified3LayerNeuralNetwork >> predictFrom: aFeatureTensor andCompareTo: anExpectedTensor [

	^tf
		computeAllNamed: (Array with: prediction operationName with: loss operationName)
		feedingInputsWith: (
			Dictionary new
				at: input operationName put: aFeatureTensor asFloatTensor;
				at: expectedLabel operationName put: anExpectedTensor asInt32Tensor;
				yourself)
]

{ #category : 'Initialization' }
Rectified3LayerNeuralNetwork >> randomInitializerFor: anAmountOfFeatures [

	^TFTruncatedNormalInitializer deviatedBy: 1.0 / anAmountOfFeatures sqrt withSeeds: #(0 1)
]

{ #category : 'Training' }
Rectified3LayerNeuralNetwork >> updateWeightsToFitPredictionFrom: aFeatureTensor to: aTrainingLabelTensor [

	tf
		computeAllNamed: (Array with: loss operationName with: learn operationName)
		feedingInputsWith: (
			Dictionary new
				at: input operationName put: aFeatureTensor asFloatTensor;
				at: expectedLabel operationName put: aTrainingLabelTensor asInt32Tensor;
				yourself)
]
