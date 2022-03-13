Class {
	#name : 'NeuralNetworkTrainingContext',
	#superclass : 'Object',
	#instVars : [
		'modelToTrain',
		'optimization',
		'currentEpoch',
		'metricTrackers',
		'metricsCollected'
	],
	#category : 'MLTrainingModel'
}

{ #category : 'Instance Creation' }
NeuralNetworkTrainingContext class >> optimizing: aPredictionModel minimizing: aLossFunction using: anOptimizer trackingMetricsWith: aMetricTrackerCollection [

	^self new
		initializeOptimizing: aPredictionModel
		minimizing: aLossFunction
		using: anOptimizer
		trackingMetricsWith: aMetricTrackerCollection
]

{ #category : 'Accessing' }
NeuralNetworkTrainingContext >> addMetricValued: aValue during: aFittingStage to: aMetricName [

	(metricsCollected
		at: (aFittingStage metricKeyNamed: aMetricName)
		ifAbsentPut: [OrderedCollection new])
			add: aValue
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
NeuralNetworkTrainingContext >> buildInputWithFeatures: features andTarget: target [

	^Dictionary new
		at: modelToTrain inputVariableName put: features;
		at: optimization lossToMinimize targetInputName put: target;
		yourself
]

{ #category : 'Computing',
  #vaVisibility : 'private' }
NeuralNetworkTrainingContext >> computeEpochFor: aStage using: aSampleDataset [

	| losses loss |

	(aStage shouldBeExecutedFor: aSampleDataset) ifFalse: [^self].
	losses := OrderedCollection new.
	self
		measureEpochMetricsFor: aStage
		during: [
			aStage
				withSuitableSetIn: aSampleDataset
				do: [:features :target |
					aStage
						computeBatchStepUsing:
							(self buildInputWithFeatures: features andTarget: target)
						aggregatingLossTo: losses
						within: self].
			loss := losses mean.
			self addMetricValued: loss during: aStage to: self lossMetricKey].
	^loss
]

{ #category : 'Computing - Training' }
NeuralNetworkTrainingContext >> computeOptimizationToFitTo: aSampleDataset [

	| trainingLoss |

	trainingLoss := self computeTrainingEpochUsing: aSampleDataset.
	self computeValidationEpochUsing: aSampleDataset.
	^trainingLoss
]

{ #category : 'Computing - Training' }
NeuralNetworkTrainingContext >> computeTrainingBatchStepUsing: anInput aggregatingLossTo: aLossCollection [

	self
		measureBatchStepMetricsFor: TrainingStage new
		using: anInput
		during: [
			aLossCollection add: (optimization computeWith: anInput) scalarOutput.
			currentEpoch incrementTrainingStep]
]

{ #category : 'Computing - Training',
  #vaVisibility : 'private' }
NeuralNetworkTrainingContext >> computeTrainingEpochUsing: aSampleDataset [

	| loss |

	loss := self computeEpochFor: TrainingStage new using: aSampleDataset.
	currentEpoch increment.
	^loss
]

{ #category : 'Computing - Validation' }
NeuralNetworkTrainingContext >> computeValidationBatchStepUsing: anInput aggregatingLossTo: aLossCollection [

	self
		measureBatchStepMetricsFor: ValidationStage new
		using: anInput
		during: [
			aLossCollection add: (optimization lossToMinimize computeWith: anInput) scalarOutput]
]

{ #category : 'Computing - Validation',
  #vaVisibility : 'private' }
NeuralNetworkTrainingContext >> computeValidationEpochUsing: aSampleDataset [

	| loss |

	loss := self computeEpochFor: ValidationStage new using: aSampleDataset.
	^loss
]

{ #category : 'Accessing' }
NeuralNetworkTrainingContext >> epochsTrained [

	^currentEpoch value
]

{ #category : 'Accessing' }
NeuralNetworkTrainingContext >> historicalTrainingLoss [

	^self trainingMetricKnownAs: self lossMetricKey
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
NeuralNetworkTrainingContext >> initializeMetricsTrackedBy: aMetricTrackerCollection [

	metricTrackers := aMetricTrackerCollection.
	metricsCollected := Dictionary new.
	metricTrackers do: [:each | each prepareMetricsWithin: self]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
NeuralNetworkTrainingContext >> initializeOptimizationUsing: anOptimizer minimizing: aLossFunction [

	anOptimizer considerCurrentEpochIn: currentEpoch.
	optimization := ModelUpdater updating: modelToTrain toMinimize: aLossFunction using: anOptimizer
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
NeuralNetworkTrainingContext >> initializeOptimizing: aPredictionModel minimizing: aLossFunction using: anOptimizer trackingMetricsWith: aMetricTrackerCollection [

	modelToTrain := aPredictionModel.
	currentEpoch := CurrentEpochHolder on: modelToTrain currentComputation.
	self initializeOptimizationUsing: anOptimizer minimizing: aLossFunction.
	self initializeMetricsTrackedBy: aMetricTrackerCollection
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
NeuralNetworkTrainingContext >> lossMetricKey [

	^'loss'
]

{ #category : 'Accessing' }
NeuralNetworkTrainingContext >> lossValueWhenPredictingFrom: anInput andExpectedIs: anExpectedValues [

	^(optimization lossToMinimize
		computeWith: (self buildInputWithFeatures: anInput andTarget: anExpectedValues))
			scalarOutput
]

{ #category : 'Computing',
  #vaVisibility : 'private' }
NeuralNetworkTrainingContext >> measureBatchStepMetricsFor: aStage using: input during: aBlock [

	metricTrackers
		do: [:tracker | tracker measureMetricDuring: aStage onStepStartUsing: input within: self].
	aBlock value.
	metricTrackers
		do: [:tracker | tracker measureMetricDuring: aStage onStepEndUsing: input within: self]
]

{ #category : 'Computing',
  #vaVisibility : 'private' }
NeuralNetworkTrainingContext >> measureEpochMetricsFor: aStage during: aBlock [

	metricTrackers
		do: [:tracker | tracker measureMetricDuring: aStage onEpochStartWithin: self].
	aBlock value.
	metricTrackers do: [:tracker | tracker measureMetricDuring: aStage onEpochEndWithin: self]
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
NeuralNetworkTrainingContext >> metricKnownAs: aMetricKey during: aFittingStage [

	^(metricsCollected at: (aFittingStage metricKeyNamed: aMetricKey)) asArray
]

{ #category : 'Printing' }
NeuralNetworkTrainingContext >> printOn: aStream [

	aStream
		nextPutAll: 'Training context about:';
		cr.
	self printTrainingDescriptionOn: aStream
]

{ #category : 'Printing',
  #vaVisibility : 'private' }
NeuralNetworkTrainingContext >> printTrainingDescriptionOn: aStream [

	aStream
		nextPutAll: '== Model To Train ==';
		cr;
		print: modelToTrain;
		cr;
		nextPutAll: '=====';
		cr.
	aStream
		print: optimization;
		cr
]

{ #category : 'Accessing' }
NeuralNetworkTrainingContext >> trainingMetricKnownAs: aMetricKey [

	^self metricKnownAs: aMetricKey during: TrainingStage new
]

{ #category : 'Accessing' }
NeuralNetworkTrainingContext >> validationMetricKnownAs: aMetricKey [

	^self metricKnownAs: aMetricKey during: ValidationStage new
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
NeuralNetworkTrainingContext >> withMetricKnownAs: aMetricKey during: aFittingStage do: aBlock [

	^(metricsCollected at: (aFittingStage metricKeyNamed: aMetricKey) ifPresent: aBlock ifAbsent: [])
]
