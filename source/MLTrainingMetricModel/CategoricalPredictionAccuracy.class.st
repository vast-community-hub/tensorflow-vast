Class {
	#name : 'CategoricalPredictionAccuracy',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'currentComputation'
	],
	#category : 'MLTrainingMetricModel'
}

{ #category : 'Instance Creation' }
CategoricalPredictionAccuracy class >> of: aPrediction whenExpectedIs: aTarget [

	^self new initializeOf: aPrediction whenExpectedIs: aTarget
]

{ #category : 'Accessing' }
CategoricalPredictionAccuracy >> currentComputation [

	^value currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
CategoricalPredictionAccuracy >> initializeOf: aPrediction whenExpectedIs: aTarget [

	| predictionsMatches |

	predictionsMatches :=
		(aPrediction comparedWith: (aTarget castedTo: aPrediction outputType))
			castedTo: TFTensor typeFloat.

	" I assume this is always gonna be a vector with the matches "
	value := predictionsMatches meanAlongside: #(0)
]
