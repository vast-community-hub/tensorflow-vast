Class {
	#name : 'Rectified3LayerNeuralNetwork',
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
Rectified3LayerNeuralNetwork class >> new [

	^super new initialize
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Rectified3LayerNeuralNetwork >> initialize [

	tf := TensorFlowComputation new.
	self initializeFeedforward.
	tf inScopeNamed: 'loss' do: [self initializeLossLayer].
	self initializeBackpropagation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Rectified3LayerNeuralNetwork >> initializeBackpropagation [

	optimization :=
		ModelUpdater
			updating: prediction
			toMinimize: loss
			using: (TFGradientDescent scalingBy: 0.0001 asTensor)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Rectified3LayerNeuralNetwork >> initializeFeedforward [

	prediction :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 128
				builtWith: [:layer | | inputSize |
					inputSize := self inputSize.
					layer
						inputSize: inputSize;
						weightInitializedWith: (self randomInitializerFor: inputSize);
						activatedByRelu];
			addDenseLayerSized: 32
				builtWith: [:layer | | inputSize |
					inputSize := 128.
					layer
						inputSize: inputSize;
						weightInitializedWith: (self randomInitializerFor: inputSize);
						activatedByRelu];
			addDenseLayerSized: 10
				builtWith: [:layer | | inputSize |
					inputSize := 32.
					layer
						inputSize: inputSize;
						weightInitializedWith: (self randomInitializerFor: inputSize)];
			buildApplyingToLogits: [:logits |
				TFIndexWithMaximum named: 'prediction' in: logits softmax across: 1]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Rectified3LayerNeuralNetwork >> initializeLossLayer [

	loss := (TFLossBuilder for: prediction logits) buildSparseCategoricalCrossEntropy
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
				at: 'input' put: aFeatureTensor asFloatTensor;
				yourself)
]

{ #category : 'Predicting' }
Rectified3LayerNeuralNetwork >> predictFrom: aFeatureTensor andCompareTo: anExpectedTensor [

	^tf
		computeAllNamed: (Array with: prediction operationName with: loss operationName)
		feedingInputsWith: (
			Dictionary new
				at: 'input' put: aFeatureTensor asFloatTensor;
				at: 'loss/expected' put: anExpectedTensor asInt32Tensor;
				yourself)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Rectified3LayerNeuralNetwork >> randomInitializerFor: anAmountOfFeatures [

	^TFTruncatedNormalInitializer deviatedBy: 1.0 / anAmountOfFeatures sqrt withSeeds: #(0 1)
]

{ #category : 'Training' }
Rectified3LayerNeuralNetwork >> updateWeightsToFitPredictionFrom: aFeatureTensor to: aTrainingLabelTensor [

	tf
		computeAllNamed: (Array with: optimization operationName)
		feedingInputsWith: (
			Dictionary new
				at: 'input' put: aFeatureTensor asFloatTensor;
				at: 'loss/expected' put: aTrainingLabelTensor asInt32Tensor;
				yourself)
]
