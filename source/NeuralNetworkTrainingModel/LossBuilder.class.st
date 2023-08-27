Class {
	#name : 'LossBuilder',
	#superclass : 'Object',
	#instVars : [
		'model',
		'reduction'
	],
	#category : 'NeuralNetworkTrainingModel'
}

{ #category : 'Instance Creation' }
LossBuilder class >> for: aPredictor [

	^self new initializeFor: aPredictor
]

{ #category : 'Building' }
LossBuilder >> buildCategoricalCrossEntropy [

	| labels |

	labels :=
		InputTensor
			on: model currentComputation
			named: self targetInputName
			of: FloatDataType new
			shaped: model outputShape.

	^reduction value: (CategoricalCrossEntropy of: model whenExpectedProbabilityIs: labels)
]

{ #category : 'Building' }
LossBuilder >> buildMeanSquaredError [

	^self
		reducedUsingMean;
		buildSquaredError
]

{ #category : 'Building' }
LossBuilder >> buildSparseCategoricalCrossEntropy [

	| labels |

	labels :=
		InputTensor on: model currentComputation named: self targetInputName of: Int32DataType new.

	^reduction value: (SparseCategoricalCrossEntropy of: model whenExpectedIs: labels)
]

{ #category : 'Building' }
LossBuilder >> buildSquaredError [

	| expected |

	expected :=
		InputTensor
			on: model currentComputation
			named: self targetInputName
			of: FloatDataType new
			shaped: model outputShape.

	^reduction value: (SquaredDifference between: model and: expected)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
LossBuilder >> initializeFor: aPredictor [

	model := aPredictor.
	self reducedUsingMean
]

{ #category : 'Configuring' }
LossBuilder >> reducedUsingMean [

	reduction := [:loss | loss mean]
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
LossBuilder >> targetInputName [

	^'expected'
]

{ #category : 'Configuring' }
LossBuilder >> withoutReducing [

	reduction := [:loss | loss]
]