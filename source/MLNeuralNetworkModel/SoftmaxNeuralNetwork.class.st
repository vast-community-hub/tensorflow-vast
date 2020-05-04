Class {
	#name : 'SoftmaxNeuralNetwork',
	#superclass : 'NeuralNetwork',
	#instVars : [
		'session',
		'weights',
		'biases',
		'prediction',
		'input',
		'loss',
		'expectedLabel',
		'learnWeights',
		'learnBiases',
		'tf',
		'lossToMinimize',
		'modelOutput'
	],
	#category : 'MLNeuralNetworkModel'
}

{ #category : 'instance creation' }
SoftmaxNeuralNetwork class >> new [

	^super new initialize
]

{ #category : 'initialization',
  #vaVisibility : 'private' }
SoftmaxNeuralNetwork >> initialize [

	tf := TensorFlowComputation new.

	self
		initializeParameters;
		initializeInferenceGraph;
		initializeLossGraph;
		initializeLearningGraph 
]

{ #category : 'initialization',
  #vaVisibility : 'private' }
SoftmaxNeuralNetwork >> initializeInferenceGraph [

	tf
		inScopeNamed: 'inference'
		do: [
			input := tf floatInputNamed: 'input'.
			modelOutput := (input dot: weights) biasedBy: biases.
			prediction :=
				TFIndexWithMaximum
					named: 'prediction'
					in: (TFSoftmaxActivation activating: modelOutput)
					across: 1]
]

{ #category : 'initialization',
  #vaVisibility : 'private' }
SoftmaxNeuralNetwork >> initializeLearningGraph [

	tf
		inScopeNamed: 'learning'
		do: [| batchSize optimizer gradient biasGradient |
			optimizer := TFGradientDescent scalingBy: 0.9 asTensor.
			gradient := lossToMinimize backpropagatedGradient.
			biasGradient := TFReduceMean ofValuesIn: gradient alongside: #(0).

			batchSize := (input value sizeOn: 0) castTo: TFTensor typeFloat.

			learnWeights := optimizer apply: (input transposedDot: gradient) / batchSize to: weights.
			learnBiases := optimizer apply: biasGradient to: biases]
]

{ #category : 'initialization',
  #vaVisibility : 'private' }
SoftmaxNeuralNetwork >> initializeLossGraph [

	tf
		inScopeNamed: 'loss'
		do: [
			expectedLabel := tf integerInputNamed: 'expectedLabel'.
			lossToMinimize := TFCrossEntropyError of: modelOutput whenExpectedIs: expectedLabel.
			loss := TFReduceMean named: 'loss' ofValuesIn: lossToMinimize loss alongside: #(0)]
]

{ #category : 'initialization',
  #vaVisibility : 'private' }
SoftmaxNeuralNetwork >> initializeParameters [

	weights :=
		tf
			floatVariableNamed: 'weights'
			shaped: (Array with: self inputSize with: self outputSize)
			initializedWith: TFZeroInitializer new. 

	biases :=
		tf
			floatVariableNamed: 'biases'
			shaped: (Array with: self outputSize)
			initializedWith: TFZeroInitializer new
]

{ #category : 'accessing',
  #vaVisibility : 'private' }
SoftmaxNeuralNetwork >> inputSize [

	^28 * 28
]

{ #category : 'accessing',
  #vaVisibility : 'private' }
SoftmaxNeuralNetwork >> outputSize [

	^10
]

{ #category : 'running' }
SoftmaxNeuralNetwork >> predictFrom: inputs [

	^tf
		compute: prediction
		feedingInputsWith: (
			Dictionary new
				at: input operationName put: inputs asFloatTensor;
				yourself)
]

{ #category : 'running' }
SoftmaxNeuralNetwork >> predictFrom: aFeatureTensor andCompareTo: anExpectedTensor [

	^tf
		computeAllNamed: (Array with: prediction operationName with: loss operationName)
		feedingInputsWith: (
			Dictionary new
				at: input operationName put: aFeatureTensor asFloatTensor;
				at: expectedLabel operationName put: anExpectedTensor asInt32Tensor;
				yourself) 
]

{ #category : 'Training' }
SoftmaxNeuralNetwork >> updateWeightsToFitPredictionFrom: aFeatureTensor to: aTrainingLabelTensor [

	tf
		computeAllNamed: (
			Array
				with: loss operationName
				with: learnWeights operationName
				with: learnBiases operationName)
		feedingInputsWith: (
			Dictionary new
				at: input operationName put: aFeatureTensor asFloatTensor;
				at: expectedLabel operationName put: aTrainingLabelTensor asInt32Tensor;
				yourself) 
]
