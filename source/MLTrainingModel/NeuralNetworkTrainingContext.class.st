Class {
	#name : 'NeuralNetworkTrainingContext',
	#superclass : 'Object',
	#instVars : [
		'model',
		'optimization',
		'accuracy',
		'metricsDuringTrainings',
		'metricTrackers'
	],
	#category : 'MLTrainingModel'
}

{ #category : 'Instance Creation' }
NeuralNetworkTrainingContext class >> optimizing: aModel using: anOptimization trackingMetricsWith: aMetricTrackerCollection [

	^self new
		initializeOptimizing: aModel
		using: anOptimization
		trackingMetricsWith: aMetricTrackerCollection
]

{ #category : 'Accessing' }
NeuralNetworkTrainingContext >> addMetricValued: aValue to: aMetricName [

	(metricsDuringTrainings at: aMetricName ifAbsentPut: [OrderedCollection new]) add: aValue
]

{ #category : 'Computing' }
NeuralNetworkTrainingContext >> computeOptimizationToFitTo: aSampleDataset [

	| loss trainingInputs |

	aSampleDataset withTrainingDatasetDo: [:features :target |
		trainingInputs :=
			Dictionary new
				at: model inputVariableName put: features;
				at: optimization lossToMinimize targetInputName put: target;
				yourself].
	loss := optimization computeWith: trainingInputs.

	self addMetricValued: loss scalarOutput to: self trainingLossMetricKey.
	metricTrackers do: [:tracker | tracker measureMetricConsidering: trainingInputs within: self].

	^loss
]

{ #category : 'Accessing' }
NeuralNetworkTrainingContext >> historicalTrainingLoss [

	^self metricKnownAs: self trainingLossMetricKey
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
NeuralNetworkTrainingContext >> initializeOptimizing: aPredictionModel using: anOptimization trackingMetricsWith: aMetricTrackerCollection [

	model := aPredictionModel.
	optimization := anOptimization.
	metricTrackers := aMetricTrackerCollection.
	metricsDuringTrainings :=
		Dictionary new
			at: self trainingLossMetricKey put: OrderedCollection new;
			yourself.
	metricTrackers do: [:each | each prepareMetricsWithin: self]
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
NeuralNetworkTrainingContext >> totalNumberOfEpochs [

	^self historicalTrainingLoss size
]

{ #category : 'Initialization' }
NeuralNetworkTrainingContext >> trainingLossMetricKey [

	^'training-loss'
]
