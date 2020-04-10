Class {
	#name : 'LSTMNeuralNetwork',
	#superclass : 'NeuralNetwork',
	#instVars : [
		'tf',
		'input',
		'expectedPredictions',
		'weightsByLayer',
		'biasesByLayer',
		'outputsByLayer',
		'loss',
		'learntVariables',
		'learnLoss',
		'optimizer'
	],
	#category : 'FeedforwardNeuralNetworkModel'
}

{ #category : 'Initialization' }
LSTMNeuralNetwork class >> new [

	^ super new initialize
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
LSTMNeuralNetwork >> initialize [

	tf := TensorFlowComputation new.
	input := tf floatInputNamed: 'input'.
	weightsByLayer := Dictionary new.
	biasesByLayer := Dictionary new.
	outputsByLayer := Dictionary new.

	self initializeLayer1.
	self initializeLayer2.
	self initializeLayer3.
	self initializeLossGraph.

	learntVariables := OrderedCollection new.
	optimizer := TFGradientDescent scalingBy: 0.9 asTensor
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
LSTMNeuralNetwork >> initializeLayer1 [

	| layerInput inputSize outputSize weights biases score |

	layerInput := input.
	inputSize := 3.
	outputSize := 3.
	weights :=
		tf
			floatVariableNamed: 'weights1'
			shaped: (Array with: inputSize with: outputSize)
			initializedWith: (TFTruncatedNormalInitializer withSeeds: #(0 1)).
	biases :=
		tf
			floatVariableNamed: 'biases1'
			shaped: (Array with: 1 with: outputSize)
			initializedWith: TFZeroInitializer new.

	tf
		inScopeNamed: 'layer1'
		do: [
			score := TFSum of: (TFMatrixMultiplication of: layerInput and: weights) plus: biases.
			outputsByLayer at: 1 put: (TFTanhActivation activating: score)].

	weightsByLayer at: 1 put: weights.
	biasesByLayer at: 1 put: biases
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
LSTMNeuralNetwork >> initializeLayer2 [

	| layerInput inputSize outputSize weights biases score |

	layerInput := outputsByLayer at: 1.
	inputSize := 3.
	outputSize := 2.
	weights :=
		tf
			floatVariableNamed: 'weights2'
			shaped: (Array with: inputSize with: outputSize)
			initializedWith: (TFTruncatedNormalInitializer withSeeds: #(0 1)).
	biases :=
		tf
			floatVariableNamed: 'biases2'
			shaped: (Array with: 1 with: outputSize)
			initializedWith: TFZeroInitializer new.

	tf
		inScopeNamed: 'layer2'
		do: [
			score := TFSum of: (TFMatrixMultiplication of: layerInput and: weights) plus: biases.
			outputsByLayer at: 2 put: (TFTanhActivation activating: score)].

	weightsByLayer at: 2 put: weights.
	biasesByLayer at: 2 put: biases
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
LSTMNeuralNetwork >> initializeLayer3 [

	| layerInput inputSize outputSize weights biases score |

	layerInput := outputsByLayer at: 2.
	inputSize := 2.
	outputSize := 1.
	weights :=
		tf
			floatVariableNamed: 'weights3'
			shaped: (Array with: inputSize with: outputSize)
			initializedWith: (TFTruncatedNormalInitializer withSeeds: #(0 1)).
	biases :=
		tf
			floatVariableNamed: 'biases3'
			shaped: (Array with: 1 with: outputSize)
			initializedWith: TFZeroInitializer new.

	tf
		inScopeNamed: 'layer3'
		do: [
			score := TFSum of: (TFMatrixMultiplication of: layerInput and: weights) plus: biases.
			outputsByLayer at: 3 put: (TFTanhActivation activating: score)].

	weightsByLayer at: 3 put: weights.
	biasesByLayer at: 3 put: biases
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
LSTMNeuralNetwork >> initializeLearningLayer1 [

	| grads weights bias |

	weights := weightsByLayer at: 1.
	bias := biasesByLayer at: 1.
	grads := TFGradient of: (Array with: loss) withRespectTo: (Array with: weights with: bias).

	learntVariables add: (optimizer apply: (grads gradientRespectTo: weights) to: weights).
	learntVariables add: (optimizer apply: (grads gradientRespectTo: bias) to: bias)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
LSTMNeuralNetwork >> initializeLearningLayer2 [

	| grads weights bias |

	weights := weightsByLayer at: 2.
	bias := biasesByLayer at: 2.
	grads := TFGradient of: (Array with: loss) withRespectTo: (Array with: weights with: bias).

	learntVariables add: (optimizer apply: (grads gradientRespectTo: weights) to: weights).
	learntVariables add: (optimizer apply: (grads gradientRespectTo: bias) to: bias)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
LSTMNeuralNetwork >> initializeLearningLayer3 [

	| grads weights bias |

	weights := weightsByLayer at: 3.
	bias := biasesByLayer at: 3.
	grads := TFGradient of: (Array with: loss) withRespectTo: (Array with: weights with: bias).

	learntVariables add: (optimizer apply: (grads gradientRespectTo: weights) to: weights).
	learntVariables add: (optimizer apply: (grads gradientRespectTo: bias) to: bias)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
LSTMNeuralNetwork >> initializeLossGraph [

	| regularizer regularization prediction |
	
	tf
		inScopeNamed: 'regularization'
		do: [
			regularizer := L2Regularization by: 0.01.
			regularization :=
				TFSum ofAll:
					(weightsByLayer values collect: [:weight | regularizer regularize: weight])].

	prediction := outputsByLayer at: 3.
	expectedPredictions := tf floatInputNamed: 'expectedPrediction'.
	loss :=
		TFSum
			named: 'loss'
			of: (TFMeanSquaredError of: prediction whenExpectedIs: expectedPredictions)
			plus: regularization
]

{ #category : 'Predicting' }
LSTMNeuralNetwork >> predictFrom: aFeaturesCollection [

	^tf
		compute: (outputsByLayer at: 3)
		feedingInputsWith: (
			Dictionary new
				at: input operationName put: aFeaturesCollection asFloatTensor;
				yourself)
]

{ #category : 'Predicting' }
LSTMNeuralNetwork >> predictFrom: aFeatureTensor andCompareTo: anExpectedTensor [

	^tf
		computeAllNamed: (Array with: (outputsByLayer at: 3) operationName with: loss operationName)
		feedingInputsWith: (
			Dictionary new
				at: input operationName put: aFeatureTensor asFloatTensor;
				at: expectedPredictions operationName put: anExpectedTensor;
				yourself)


]
