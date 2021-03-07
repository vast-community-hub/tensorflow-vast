Class {
	#name : 'NeuralNetworkTrainingContext',
	#superclass : 'Object',
	#instVars : [
		'model',
		'optimization',
		'metricsDuringTrainings',
		'metricTrackers',
		'currentEpoch'
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
NeuralNetworkTrainingContext >> addMetricValued: aValue to: aMetricName [

	(metricsDuringTrainings at: aMetricName ifAbsentPut: [OrderedCollection new]) add: aValue
]

{ #category : 'Computing' }
NeuralNetworkTrainingContext >> computeOptimizationToFitTo: aSampleDataset [

	| losses loss trainingInputs |

	losses := OrderedCollection new.
	metricTrackers do: [:tracker | tracker measureMetricBeforeEpochWithin: self].
	aSampleDataset withTrainingDatasetDo: [:features :target |
		trainingInputs :=
			Dictionary new
				at: model inputVariableName put: features;
				at: optimization lossToMinimize targetInputName put: target;
				yourself.
		metricTrackers
			do: [:tracker | tracker measureMetricBeforeStepWith: trainingInputs within: self].
		losses add: (optimization computeWith: trainingInputs) scalarOutput.
		currentEpoch incrementTrainingStep.
		metricTrackers
			do: [:tracker | tracker measureMetricAfterStepWith: trainingInputs within: self]].

	loss := losses mean.
	currentEpoch increment.
	metricTrackers do: [:tracker | tracker measureMetricAfterEpochWithin: self].
	self addMetricValued: loss to: self trainingLossMetricKey.

	^loss
]

{ #category : 'Accessing' }
NeuralNetworkTrainingContext >> epochsTrained [

	^currentEpoch value
]

{ #category : 'Accessing' }
NeuralNetworkTrainingContext >> historicalTrainingLoss [

	^self metricKnownAs: self trainingLossMetricKey
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
NeuralNetworkTrainingContext >> initializeMetricsTrackedBy: aMetricTrackerCollection [

	metricTrackers := aMetricTrackerCollection.
	metricsDuringTrainings :=
		(Dictionary new)
			at: self trainingLossMetricKey put: OrderedCollection new;
			yourself.
	metricTrackers do: [:each | each prepareMetricsWithin: self]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
NeuralNetworkTrainingContext >> initializeOptimizationUsing: anOptimizer minimizing: aLossFunction [

	anOptimizer considerCurrentEpochIn: currentEpoch.
	optimization := ModelUpdater updating: model toMinimize: aLossFunction using: anOptimizer
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
NeuralNetworkTrainingContext >> initializeOptimizing: aPredictionModel minimizing: aLossFunction using: anOptimizer trackingMetricsWith: aMetricTrackerCollection [

	model := aPredictionModel.
	currentEpoch := CurrentEpochHolder on: model currentComputation.
	self initializeOptimizationUsing: anOptimizer minimizing: aLossFunction.
	self initializeMetricsTrackedBy: aMetricTrackerCollection
]

{ #category : 'Computing' }
NeuralNetworkTrainingContext >> lossValueWhenPredictingFrom: anInput andExpectedIs: anExpectedValues [

	^(optimization lossToMinimize computeWith: (
		Dictionary new
			at: model inputVariableName put: anInput;
			at: optimization lossToMinimize targetInputName put: anExpectedValues;
			yourself))
				scalarOutput
]

{ #category : 'Accessing' }
NeuralNetworkTrainingContext >> metricKnownAs: aMetricKey [

	^(metricsDuringTrainings at: aMetricKey) asArray
]

{ #category : 'Printing' }
NeuralNetworkTrainingContext >> printOn: aStream [

	aStream
		nextPutAll: 'Training context about:';
		cr.
	self printTrainingDescriptionOn: aStream
]

{ #category : 'Printing' }
NeuralNetworkTrainingContext >> printTrainingDescriptionOn: aStream [

	aStream
		nextPutAll: '== Model To Train ==';
		cr;
		print: model;
		cr;
		nextPutAll: '=====';
		cr.
	aStream
		print: optimization;
		cr
]

{ #category : 'Accessing' }
NeuralNetworkTrainingContext >> trainingLossMetricKey [

	^'training-loss'
]
