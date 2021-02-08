Class {
	#name : 'TrainingMinimizingLossFunctionTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'MLTrainingModelTests'
}

{ #category : 'Not categorized' }
TrainingMinimizingLossFunctionTest class >> isAbstract [

	^self name = #TrainingMinimizingLossFunctionTest
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingLossFunctionTest >> expectedLabels [

	^#(0 1 0 0) asInt32Tensor
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingLossFunctionTest >> expectedLogitsAfterOneEpoch [

	self subclassResponsibility
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingLossFunctionTest >> expectedLossAfterOneEpoch [

	self subclassResponsibility
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingLossFunctionTest >> expectedLossValueThroughTenEpochs [

	self subclassResponsibility
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingLossFunctionTest >> expectedProbabilityByLabel [

	^#((0 1) (1 0) (0 1) (1 1)) asFloatTensor
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingLossFunctionTest >> expectedWeightAfterOneEpoch [

	self subclassResponsibility
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingLossFunctionTest >> inputTensor [

	^#((0 0 1) (0 1 1) (1 0 0) (1 1 1)) asFloatTensor
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingLossFunctionTest >> modelWithTwoOutputUnits [

	^(SequentialModelBuilder on: tf)
		addDenseLayerSized: 2
			builtWith: [:layer |
				layer
					inputSize: 3;
					weightInitializedToZero;
					biasInitializedTo: #(0.2 0.8)];
		buildApplyingToLogits: [:logits | logits argMaxOnRows]
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingLossFunctionTest >> neuralNetworkTrainer [

	self subclassResponsibility
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TrainingMinimizingLossFunctionTest >> targetTensor [

	self subclassResponsibility
]

{ #category : 'Tests' }
TrainingMinimizingLossFunctionTest >> testLogitsAfterOneEpoch [

	| model |

	model := self modelWithTwoOutputUnits.
	self neuralNetworkTrainer
		stopTrainingWhen: (CompletedNumberOfTraining after: 1);
		train: model toFit: self trainingDataset.

	self
		assert: (
			model logits computeWith: (
				Dictionary new
					at: 'input' put: self inputTensor;
					yourself))
		isMatrixCloseTo: self expectedLogitsAfterOneEpoch
]

{ #category : 'Tests' }
TrainingMinimizingLossFunctionTest >> testLossValueAfterOneEpoch [

	| model summary |

	model := self modelWithTwoOutputUnits.
	summary :=
		self neuralNetworkTrainer
			stopTrainingWhen: (CompletedNumberOfTraining after: 1);
			train: model toFit: self trainingDataset.

	self
		assertOutputOf:
			(summary lossValueWhenPredictingFrom: self inputTensor andExpectedIs: self targetTensor)
		isFloatScalarCloseTo: self expectedLossAfterOneEpoch
]

{ #category : 'Tests' }
TrainingMinimizingLossFunctionTest >> testLossValueThroughTenEpochs [

	| model summary |

	model := self modelWithTwoOutputUnits.
	summary :=
		self neuralNetworkTrainer
			stopTrainingWhen: (CompletedNumberOfTraining after: 10);
			train: model toFit: self trainingDataset.

	self
		assert: summary historicalTrainingLoss
		isArrayCloseTo: self expectedLossValueThroughTenEpochs
]

{ #category : 'Tests' }
TrainingMinimizingLossFunctionTest >> testWeightAfterOneEpoch [

	| model |

	model := self modelWithTwoOutputUnits.
	self neuralNetworkTrainer
		stopTrainingWhen: (CompletedNumberOfTraining after: 1);
		train: model toFit: self trainingDataset.

	self
		assertOutputOf: model trainableVariables first
		isMatrixCloseTo: self expectedWeightAfterOneEpoch
]
