Class {
	#name : 'FeedforwardNeuralNetwork',
	#superclass : 'NeuralNetwork',
	#instVars : [
		'featuresWeights',
		'forwardPropagation',
		'backpropagation'
	],
	#category : 'LibTensorFlowExamplesApp'
}

{ #category : 'Instance Creation' }
FeedforwardNeuralNetwork class >> weightingFeaturesWith: aFeatureWeights [

	
	^ self new initializeWeightingFeaturesWith: aFeatureWeights
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
FeedforwardNeuralNetwork >> initializeWeightingFeaturesWith: aFeatureWeights [

	featuresWeights := aFeatureWeights.
	forwardPropagation := ForwardPropagationAlgorithm new.
	backpropagation := BackpropagationAlgorithm new
]

{ #category : 'Predicting' }
FeedforwardNeuralNetwork >> predictFrom: aFeaturesCollection [

	^forwardPropagation predictUsing: (
		Dictionary new
			at: 'input' put: aFeaturesCollection;
			at: 'weights' put: featuresWeights;
			yourself)
]

{ #category : 'Training' }
FeedforwardNeuralNetwork >> updateWeightsToFitPredictionFrom: aFeaturesCollection to: aTarget [

	| result |

	result := self predictFrom: aFeaturesCollection.

	featuresWeights :=
		backpropagation improvedWeightsUsing: (
			Dictionary new
				at: 'weights' put: featuresWeights;
				at: 'input' put: aFeaturesCollection;
				at: 'predicted' put: result;
				at: 'target' put: aTarget;
				yourself)
]
