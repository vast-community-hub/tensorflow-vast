Class {
	#name : 'NeuralNetworkTrainer',
	#superclass : 'Object',
	#instVars : [
		'lossBuilder',
		'stopCondition',
		'afterTrainingCallback',
		'optimizer',
		'tf',
		'metricTrackers'
	],
	#category : 'NeuralNetworkTrainingModel'
}

{ #category : 'Instance Creation' }
NeuralNetworkTrainer class >> on: aTensorFlowComputation [

	^self new initializeOn: aTensorFlowComputation
]

{ #category : 'Configuring' }
NeuralNetworkTrainer >> afterEveryTrainingDo: aBlock [

	
	afterTrainingCallback := aBlock
]

{ #category : 'Asserting',
  #vaVisibility : 'private' }
NeuralNetworkTrainer >> assertReadyToStartTraining [

	stopCondition isNil
		ifTrue: [AssertionFailure signal: 'Need to configure a stop condition before training']. 
	optimizer isNil 
		ifTrue: [AssertionFailure signal: 'Need to configure an optimization algorithm before training']. 
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
NeuralNetworkTrainer >> initializeOn: aTensorFlowComputation [

	tf := aTensorFlowComputation.
	metricTrackers := OrderedCollection new.

	self afterEveryTrainingDo: [:context | ]
]

{ #category : 'Configuring' }
NeuralNetworkTrainer >> minimizeCategoricalCrossEntropyUsing: anOptimizer [

	self minimizeLossBuiltWith: [:builder | builder buildCategoricalCrossEntropy] using: anOptimizer
]

{ #category : 'Configuring' }
NeuralNetworkTrainer >> minimizeLossBuiltWith: aBlock using: anOptimizationAlgorithm [

	lossBuilder := aBlock.
	optimizer := anOptimizationAlgorithm
]

{ #category : 'Configuring' }
NeuralNetworkTrainer >> minimizeMeanSquaredErrorUsing: anOptimizer [

	self minimizeLossBuiltWith: [:builder | builder buildMeanSquaredError] using: anOptimizer
]

{ #category : 'Configuring' }
NeuralNetworkTrainer >> minimizeSparseCategoricalCrossEntropyUsing: anOptimizer [

	self
		minimizeLossBuiltWith: [:builder | builder buildSparseCategoricalCrossEntropy]
		using: anOptimizer
]

{ #category : 'Configuring' }
NeuralNetworkTrainer >> stopTrainingWhen: aStopCondition [

	stopCondition := aStopCondition
]

{ #category : 'Configuring' }
NeuralNetworkTrainer >> trackMetricWith: aMetricTracker [

	metricTrackers add: aMetricTracker
]

{ #category : 'Training',
  #vaVisibility : 'private' }
NeuralNetworkTrainer >> train: aModel doing: aTraining [

	| loss context |

	self assertReadyToStartTraining.

	loss := lossBuilder value: (LossBuilder for: aModel logits).
	context :=
		NeuralNetworkTrainingContext
			optimizing: aModel
			minimizing: loss
			using: optimizer
			trackingMetricsWith: metricTrackers.

	afterTrainingCallback value: context.
	[
		aTraining value: context.
		afterTrainingCallback value: context.
		stopCondition isModelWellTrainedAccording: context]
			whileFalse.
	^NeuralNetworkTrainingSummary regarding: context stoppedAfter: stopCondition
]

{ #category : 'Training' }
NeuralNetworkTrainer >> train: aModel toFit: aDataset [

	^self train: aModel doing: [:context | context computeOptimizationToFitTo: aDataset]
]

{ #category : 'Configuring' }
NeuralNetworkTrainer >> trainingIterations: aTrainingTimes [

	self stopTrainingWhen: (CompletedNumberOfEpochs after: aTrainingTimes)
]
