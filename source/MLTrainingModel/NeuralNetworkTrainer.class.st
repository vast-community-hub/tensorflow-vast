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
	#category : 'MLTrainingModel'
}

{ #category : 'Instance Creation' }
NeuralNetworkTrainer class >> on: aTensorFlowComputation [

	^self new initializeOn: aTensorFlowComputation
]

{ #category : 'Configuring' }
NeuralNetworkTrainer >> afterEveryTrainingDo: aBlock [

	
	afterTrainingCallback := aBlock
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
NeuralNetworkTrainer >> initializeOn: aTensorFlowComputation [

	tf := aTensorFlowComputation.
	metricTrackers := OrderedCollection new.

	self afterEveryTrainingDo: [:iter :summary | ]
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

	| loss optimization trainingNumber context |

	loss := lossBuilder value: (LossBuilder for: aModel logits).
	optimization := ModelUpdater updating: aModel toMinimize: loss using: optimizer.
	context :=
		NeuralNetworkTrainingContext
			optimizing: aModel
			using: optimization
			trackingMetricsWith: metricTrackers.
	trainingNumber := 0.

	afterTrainingCallback value: trainingNumber value: context.
	[
		aTraining value: context.
		trainingNumber := trainingNumber + 1.
		afterTrainingCallback value: trainingNumber value: context.
		stopCondition isModelWellTrainedAccording: context]
			whileFalse.
	^NeuralNetworkTrainingSummary regarding: context stoppedAfter: stopCondition
]

{ #category : 'Training' }
NeuralNetworkTrainer >> train: aModel toFitPredictionFrom: anInstanceCollection to: aTarget [

	^self
		train: aModel
		doing: [:context | context computeOptimizationToFitPredictionFrom: anInstanceCollection to: aTarget]
]

{ #category : 'Configuring' }
NeuralNetworkTrainer >> trainingIterations: aTrainingTimes [

	self stopTrainingWhen: (CompletedNumberOfTraining after: aTrainingTimes)
]
