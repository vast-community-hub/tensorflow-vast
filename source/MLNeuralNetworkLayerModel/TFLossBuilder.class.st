Class {
	#name : 'TFLossBuilder',
	#superclass : 'Object',
	#instVars : [
		'model',
		'reduction'
	],
	#category : 'MLNeuralNetworkLayerModel'
}

{ #category : 'Instance Creation' }
TFLossBuilder class >> for: aPredictor [

	^self new initializeFor: aPredictor
]

{ #category : 'Building' }
TFLossBuilder >> buildCategoricalCrossEntropy [

	| labels |

	labels :=
		TFPlaceholder
			on: model currentComputation
			named: self expectedPlaceholderName
			of: TFTensor typeFloat
			shaped: model value outputShape.

	^reduction
		value: (TFCategoricalCrossEntropy of: model whenExpectedProbabilityIs: labels)
]

{ #category : 'Building' }
TFLossBuilder >> buildMeanSquaredError [

	^self
		reducedUsingMean;
		buildSquaredError
]

{ #category : 'Building' }
TFLossBuilder >> buildSparseCategoricalCrossEntropy [

	| labels |

	labels :=
		TFPlaceholder
			on: model currentComputation
			named: self expectedPlaceholderName
			of: TFTensor typeInt32.

	^reduction value: (TFSparseCategoricalCrossEntropy of: model whenExpectedIs: labels)
]

{ #category : 'Building' }
TFLossBuilder >> buildSquaredError [

	| expected |

	expected :=
		TFPlaceholder
			on: model currentComputation
			named: self expectedPlaceholderName
			of: TFTensor typeFloat
			shaped: model value outputShape.

	^reduction value: (TFSquaredDifference between: model and: expected)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFLossBuilder >> expectedPlaceholderName [

	^'expected'
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFLossBuilder >> initializeFor: aPredictor [

	model := aPredictor.
	self reducedUsingMean
]

{ #category : 'Configuring' }
TFLossBuilder >> reducedUsingMean [

	reduction := [:loss | loss mean]
]

{ #category : 'Configuring' }
TFLossBuilder >> withoutReducing [

	reduction := [:loss | loss]
]
