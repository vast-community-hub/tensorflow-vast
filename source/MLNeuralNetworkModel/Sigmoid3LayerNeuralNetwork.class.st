Class {
	#name : 'Sigmoid3LayerNeuralNetwork',
	#superclass : 'NeuralNetwork',
	#instVars : [
		'tf',
		'prediction',
		'loss',
		'optimization'
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
	self initializeFeedforward.
	self initializeLossLayer.
	self initializeBackpropagation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Sigmoid3LayerNeuralNetwork >> initializeBackpropagation [

	optimization :=
		ModelUpdater
			updating: prediction
			toMinimize: loss
			using: (TFGradientDescent scalingBy: 0.1 asTensor)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Sigmoid3LayerNeuralNetwork >> initializeFeedforward [

	prediction :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 128
				builtWith: [:layer | | inputSize |
					inputSize := 28 * 28.
					layer
						inputSize: inputSize;
						weightInitializedWith: (self randomInitializerFor: inputSize);
						biasInitializedToZero;
						activatedBySigmoid];
			addDenseLayerSized: 32
				builtWith: [:layer | | inputSize |
					inputSize := 128.
					layer
						inputSize: inputSize;
						weightInitializedWith: (self randomInitializerFor: inputSize);
						biasInitializedToZero;
						activatedBySigmoid];
			addDenseLayerSized: 10
				builtWith: [:layer | | inputSize |
					inputSize := 32.
					layer
						inputSize: inputSize;
						weightInitializedWith: (self randomInitializerFor: inputSize);
						biasInitializedToZero];
			buildApplyingToLogits: [:logits |
				TFIndexWithMaximum named: 'prediction' in: logits across: 1]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Sigmoid3LayerNeuralNetwork >> initializeLossLayer [

	loss := (TFLossBuilder for: prediction logits) buildSparseCategoricalCrossEntropy
]

{ #category : 'Computing' }
Sigmoid3LayerNeuralNetwork >> predictFrom: aFeatureTensor [

	^tf
		compute: prediction
		feedingInputsWith: (
			Dictionary new
				at: 'input' put: aFeatureTensor asFloatTensor;
				yourself)
]

{ #category : 'Computing' }
Sigmoid3LayerNeuralNetwork >> predictFrom: aFeatureTensor andCompareTo: anExpectedTensor [

	^tf
		computeAllNamed: (Array with: prediction operationName with: loss operationName)
		feedingInputsWith: (
			Dictionary new
				at: 'input' put: aFeatureTensor asFloatTensor;
				at: 'expected' put: anExpectedTensor asInt32Tensor;
				yourself)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
Sigmoid3LayerNeuralNetwork >> randomInitializerFor: anAmountOfFeatures [

	^TFTruncatedNormalInitializer deviatedBy: 1.0 / anAmountOfFeatures sqrt withSeeds: #(0 1)
]

{ #category : 'Computing' }
Sigmoid3LayerNeuralNetwork >> updateWeightsToFitPredictionFrom: aFeatureTensor to: aTrainingLabelTensor [

	tf
		computeAllNamed: (Array with: optimization operationName)
		feedingInputsWith: (
			Dictionary new
				at: 'input' put: aFeatureTensor asFloatTensor;
				at: 'expected' put: aTrainingLabelTensor asInt32Tensor;
				yourself)
]
