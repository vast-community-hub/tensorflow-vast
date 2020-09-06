Class {
	#name : 'NearestNeighborNetwork',
	#superclass : 'Object',
	#instVars : [
		'prediction',
		'tf'
	],
	#category : 'MLNeuralNetworkModel'
}

{ #category : 'Not categorized' }
NearestNeighborNetwork class >> new [

	^super new initialize
]

{ #category : 'initialization',
  #vaVisibility : 'private' }
NearestNeighborNetwork >> initialize [

	| axis distance testing training |

	tf := TensorFlowComputation new.

	training := tf floatInputNamed: 'training'.
	testing := tf floatInputNamed: 'testing'.

	axis := 0.
	distance := ReduceSum valuesIn: (testing - training) abs alongside: (Array with: axis).
	prediction := IndexWithMinimum in: distance across: axis
]

{ #category : 'evaluating' }
NearestNeighborNetwork >> predict: covariatesTesting from: covariatesTraining [

	| result |

	result :=
		tf
			compute: prediction
			feedingInputsWith: (
				Dictionary new
					at: 'training' put: covariatesTraining;
					at: 'testing' put: covariatesTesting;
					yourself).

	^result allInt64s collect: [:each | each + 1]
]
