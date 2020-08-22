Class {
	#name : 'Sigmoid3LayerNeuralNetwork',
	#superclass : 'NeuralNetwork',
	#instVars : [
		'input',
		'hidden1',
		'hidden2',
		'prediction',
		'expectedLabel',
		'loss',
		'logits',
		'learntParameters',
		'weightsByLayer',
		'biasesByLayer',
		'backpropByLayer',
		'batchSize',
		'learn',
		'tf',
		'lossToMinimize',
		'modelOutput',
		'optimizer'
	],
	#category : 'MLNeuralNetworkModel'
}

{ #category : 'Instance Creation' }
Sigmoid3LayerNeuralNetwork class >> new [

	^super new initialize
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Sigmoid3LayerNeuralNetwork >> initialize [

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
	optimizer := TFGradientDescent scalingBy: 0.1 asTensor.
	batchSize := (input value sizeOn: 0) castTo: TFTensor typeFloat.
	self initializeLearningLayer3.
	self initializeLearningLayer2.
	self initializeLearningLayer1.

	learn := TFIdentity of: loss evaluatedOnlyAfter: learntParameters
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Sigmoid3LayerNeuralNetwork >> initializeLayer1 [

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
	hidden1 := TFSigmoidActivation activating: score.

	weightsByLayer at: 1 put: weights.
	biasesByLayer at: 1 put: biases
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Sigmoid3LayerNeuralNetwork >> initializeLayer2 [

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
	hidden2 := TFSigmoidActivation activating: score.

	weightsByLayer at: 2 put: weights.
	biasesByLayer at: 2 put: biases
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Sigmoid3LayerNeuralNetwork >> initializeLayer3 [

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
	prediction := TFIndexWithMaximum named: 'prediction' in: modelOutput across: 1.

	weightsByLayer at: 3 put: weights.
	biasesByLayer at: 3 put: biases
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Sigmoid3LayerNeuralNetwork >> initializeLearningLayer1 [

	| layerInput layerOutput gradient weights bias biasGradient |

	layerInput := input.
	layerOutput := hidden1.
	weights := weightsByLayer at: 1.
	bias := biasesByLayer at: 1.

	gradient :=
		TFSigmoidGradient considering: layerOutput andGradientsOfInputs: (backpropByLayer at: 2).
	biasGradient := TFReduceMean ofValuesIn: gradient alongside: #(0).

	learntParameters
		add: (optimizer apply: (layerInput transposedDot: gradient) / batchSize to: weights).
	learntParameters add: (optimizer apply: biasGradient to: bias)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Sigmoid3LayerNeuralNetwork >> initializeLearningLayer2 [

	| layerInput layerOutput gradient biasGradient weights bias |

	layerInput := hidden1.
	layerOutput := hidden2.
	weights := weightsByLayer at: 2.
	bias := biasesByLayer at: 2.

	gradient :=
		TFSigmoidGradient considering: layerOutput andGradientsOfInputs: (backpropByLayer at: 3).
	biasGradient := TFReduceMean ofValuesIn: gradient alongside: #(0).

	learntParameters
		add: (optimizer apply: (layerInput transposedDot: gradient) / batchSize to: weights).
	learntParameters add: (optimizer apply: biasGradient to: bias).

	backpropByLayer at: 2 put: (gradient dotTransposing: weights)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Sigmoid3LayerNeuralNetwork >> initializeLearningLayer3 [

	| layerInput gradient biasGradient weights bias |

	layerInput := hidden2.
	weights := weightsByLayer at: 3.
	bias := biasesByLayer at: 3.

	gradient := lossToMinimize backpropagatedGradient.
	biasGradient := TFReduceMean ofValuesIn: gradient alongside: #(0).

	learntParameters
		add: (optimizer apply: (layerInput transposedDot: gradient) / batchSize to: weights).
	learntParameters add: (optimizer apply: biasGradient to: bias).

	backpropByLayer at: 3 put: (TFMatrixMultiplication of: gradient andTransposed: weights)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Sigmoid3LayerNeuralNetwork >> initializeLossLayer [

	tf
		inScopeNamed: 'loss'
		do: [
			expectedLabel := tf integerInputNamed: 'expectedLabel'.
			lossToMinimize := TFSparseCategoricalCrossEntropy of: modelOutput whenExpectedIs: expectedLabel.
			loss := TFReduceMean named: 'loss' ofValuesIn: lossToMinimize loss alongside: #(0)]
]

{ #category : 'Predicting' }
Sigmoid3LayerNeuralNetwork >> predictFrom: aFeatureTensor [

	^tf
		compute: prediction
		feedingInputsWith: (
			Dictionary new
				at: input operationName put: aFeatureTensor asFloatTensor;
				yourself) 
]

{ #category : 'Predicting' }
Sigmoid3LayerNeuralNetwork >> predictFrom: aFeatureTensor andCompareTo: anExpectedTensor [

	^tf
		computeAllNamed: (Array with: prediction operationName with: loss operationName)
		feedingInputsWith: (
			Dictionary new
				at: input operationName put: aFeatureTensor asFloatTensor;
				at: expectedLabel operationName put: anExpectedTensor asInt32Tensor;
				yourself)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Sigmoid3LayerNeuralNetwork >> randomInitializerFor: anAmountOfFeatures [

	^TFTruncatedNormalInitializer deviatedBy: 1.0 / anAmountOfFeatures sqrt withSeeds: #(0 1)
]

{ #category : 'Training' }
Sigmoid3LayerNeuralNetwork >> updateWeightsToFitPredictionFrom: aFeatureTensor to: aTrainingLabelTensor [

	tf
		computeAllNamed: (Array with: loss operationName with: learn operationName)
		feedingInputsWith: (
			Dictionary new
				at: input operationName put: aFeatureTensor asFloatTensor;
				at: expectedLabel operationName put: aTrainingLabelTensor asInt32Tensor;
				yourself)
]
