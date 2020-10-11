Class {
	#name : 'NeuralNetworkTrainingContext',
	#superclass : 'Object',
	#instVars : [
		'model',
		'optimization',
		'accuracy',
		'metricsDuringTrainings'
	],
	#category : 'MLTrainingModel'
}

{ #category : 'Instance Creation' }
NeuralNetworkTrainingContext class >> optimizing: aModel using: anOptimization [

	^self new initializeOptimizing: aModel using: anOptimization
]

{ #category : 'Computing',
  #vaVisibility : 'private' }
NeuralNetworkTrainingContext >> accuracyValueWhenPredictingFrom: anInput andExpectedIs: anExpectedValues [

	^(accuracy computeWith: (
		Dictionary new
			at: model inputVariableName put: anInput;
			at: optimization lossToMinimize targetInputName put: anExpectedValues;
			yourself))
				scalarOutput
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
NeuralNetworkTrainingContext >> addMetricValued: aValue to: aMetricName [

	(metricsDuringTrainings at: aMetricName ifAbsentPut: [OrderedCollection new]) add: aValue
]

{ #category : 'Computing' }
NeuralNetworkTrainingContext >> computeOptimizationToFitPredictionFrom: anInstanceCollection to: aTarget [

	| loss |

	loss :=
		model currentComputation
			compute: optimization
			feedingInputsWith: (
				Dictionary new
					at: model inputVariableName put: anInstanceCollection;
					at: optimization lossToMinimize targetInputName put: aTarget;
					yourself).
	self
		addMetricValued: loss scalarOutput to: 'training-loss';
		addMetricValued:
				(self accuracyValueWhenPredictingFrom: anInstanceCollection andExpectedIs: aTarget)
			to: 'training-accuracy'.
	^loss
]

{ #category : 'Accessing' }
NeuralNetworkTrainingContext >> historicalTrainingLoss [

	^self metricKnownAs: 'training-loss'
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
NeuralNetworkTrainingContext >> initializeOptimizing: aPredictionModel using: anOptimization [

	model := aPredictionModel.
	optimization := anOptimization.
	accuracy :=
		CategoricalPredictionAccuracy
			of: model
			whenExpectedIs: optimization lossToMinimize targetInputAsLabels.
	metricsDuringTrainings :=
		Dictionary new
			at: 'training-loss' put: OrderedCollection new;
			at: 'training-accuracy' put: OrderedCollection new;
			yourself
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
