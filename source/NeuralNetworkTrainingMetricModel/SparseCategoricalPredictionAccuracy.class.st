Class {
	#name : 'SparseCategoricalPredictionAccuracy',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'prediction',
		'target'
	],
	#category : 'NeuralNetworkTrainingMetricModel'
}

{ #category : 'Instance Creation' }
SparseCategoricalPredictionAccuracy class >> of: aPrediction whenExpectedIs: aTarget [

	^self new initializeOf: aPrediction whenExpectedIs: aTarget
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
SparseCategoricalPredictionAccuracy >> countAllElementsIn: predictionsMatches using: currentComputation [

	^ReduceSum valuesIn:
		(currentComputation newOperationOf: 'OnesLike' namePrefixed: 'ones' with: predictionsMatches)
]

{ #category : 'Accessing' }
SparseCategoricalPredictionAccuracy >> currentComputation [

	^value currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
SparseCategoricalPredictionAccuracy >> initializeOf: aPrediction whenExpectedIs: aTarget [
	" see keras.utils.metrics_utils.sparse_categorical_matches "

	| predictionsMatches count |

	prediction := aPrediction argMaxAcross: -1.
	target := aTarget reshapeTo: aTarget outputShape flattened.
	predictionsMatches :=
		(prediction comparedWith: (target castedTo: prediction outputType))
			castedTo: FloatDataType new.

	count := self countAllElementsIn: predictionsMatches using: aPrediction currentComputation.
	value := predictionsMatches sumElements / count
]
