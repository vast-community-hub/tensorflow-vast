Class {
	#name : 'LSTMNeuralNetwork',
	#superclass : 'NeuralNetwork',
	#instVars : [
		'tf',
		'loss',
		'optimizer',
		'modelOutput',
		'optimization'
	],
	#category : 'LibTensorFlowExamplesApp'
}

{ #category : 'Initialization' }
LSTMNeuralNetwork class >> new [

	^ super new initialize
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
LSTMNeuralNetwork >> initialize [

	tf := TensorFlowComputation new.
	self initializeFeedforward.
	
	loss := (LossBuilder for: modelOutput) buildMeanSquaredError.
	optimization :=
		ModelUpdater
			updating: modelOutput
			toMinimize: loss
			using: (GradientDescent scalingBy: 0.9 asTensor)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
LSTMNeuralNetwork >> initializeBackpropagation [

	optimization :=
		ModelUpdater
			updating: modelOutput
			toMinimize: loss
			using: (GradientDescent scalingBy: 0.9 asTensor)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
LSTMNeuralNetwork >> initializeFeedforward [

	| random |

	random := TruncatedNormalInitializer withSeed: 1.
	modelOutput :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 3
				builtWith: [:layer |
					layer
						inputSize: 3;
						weightInitializedWith: random;
						activatedByTanh];
			addDenseLayerSized: 2
				builtWith: [:layer |
					layer
						weightInitializedWith: random;
						activatedByTanh];
			addDenseLayerSized: 1
				builtWith: [:layer |
					layer
						weightInitializedWith: random;
						activatedByTanh];
			build
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
LSTMNeuralNetwork >> initializeLossGraph [

	loss := (LossBuilder for: modelOutput) buildMeanSquaredError
]

{ #category : 'Predicting' }
LSTMNeuralNetwork >> predictFrom: aFeaturesCollection [

	^tf
		compute: modelOutput
		feedingInputsWith: (
			Dictionary new
				at: modelOutput inputVariableName put: aFeaturesCollection asFloatTensor;
				yourself)
]

{ #category : 'Predicting' }
LSTMNeuralNetwork >> predictFrom: aFeatureTensor andCompareTo: anExpectedTensor [

	^tf
		computeAllNamed: (Array with: modelOutput operationName with: loss operationName)
		feedingInputsWith: (
			Dictionary new
				at: modelOutput inputVariableName put: aFeatureTensor asFloatTensor;
				at: loss targetInput name put: anExpectedTensor;
				yourself)


]
