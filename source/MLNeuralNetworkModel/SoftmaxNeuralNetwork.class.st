Class {
	#name : 'SoftmaxNeuralNetwork',
	#superclass : 'NeuralNetwork',
	#instVars : [
		'tf',
		'loss',
		'prediction',
		'optimization'
	],
	#category : 'MLNeuralNetworkModel'
}

{ #category : 'Accessing' }
SoftmaxNeuralNetwork class >> new [
	
	^super new initialize
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
SoftmaxNeuralNetwork >> initialize [

	tf := TensorFlowComputation new.
	tf inScopeNamed: 'inference' do: [self initializeFeedforward].
	tf inScopeNamed: 'loss' do: [self initializeLossLayer].
	self initializeBackpropagation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
SoftmaxNeuralNetwork >> initializeBackpropagation [

	optimization :=
		ModelUpdater
			updating: prediction
			toMinimize: loss
			using: (GradientDescent scalingBy: 0.9 asTensor)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
SoftmaxNeuralNetwork >> initializeFeedforward [

	prediction :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 10
				builtWith: [:layer |
					layer
						inputSize: self inputSize;
						weightInitializedToZero];
			buildApplyingToLogits: [:logits |
				IndexWithMaximum named: 'prediction' in: logits softmax across: 1]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
SoftmaxNeuralNetwork >> initializeLossLayer [

	loss := (LossBuilder for: prediction logits) buildSparseCategoricalCrossEntropy
]

{ #category : 'Accessing' }
SoftmaxNeuralNetwork >> inputSize [

	^28 * 28
]

{ #category : 'Predicting' }
SoftmaxNeuralNetwork >> predictFrom: inputs [

	^tf
		compute: prediction
		feedingInputsWith: (
			Dictionary new
				at: 'inference/input' put: inputs asFloatTensor;
				yourself)
]

{ #category : 'Predicting' }
SoftmaxNeuralNetwork >> predictFrom: aFeatureTensor andCompareTo: anExpectedTensor [

	^tf
		computeAllNamed: (Array with: prediction operationName with: loss operationName)
		feedingInputsWith: (
			Dictionary new
				at: 'inference/input' put: aFeatureTensor asFloatTensor;
				at: 'loss/expected' put: anExpectedTensor asInt32Tensor;
				yourself)
]

{ #category : 'Training' }
SoftmaxNeuralNetwork >> updateWeightsToFitPredictionFrom: aFeatureTensor to: aTrainingLabelTensor [

	tf
		computeAllNamed: (Array with: optimization operationName)
		feedingInputsWith: (
			Dictionary new
				at: 'inference/input' put: aFeatureTensor asFloatTensor;
				at: 'loss/expected' put: aTrainingLabelTensor asInt32Tensor;
				yourself)
]
