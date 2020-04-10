Class {
	#name : 'SimpleNeuralNetworkExample',
	#superclass : 'Object',
	#instVars : [
		'forward',
		'backward',
		'weights'
	],
	#category : 'LibTensorFlowExamplesApp'
}

{ #category : 'instance creation' }
SimpleNeuralNetworkExample class >> new [

	^super new initialize
]

{ #category : 'initialization' }
SimpleNeuralNetworkExample >> initialize [
	forward := BackpropagationForwardPlan new.
	backward := BackpropagationBackwardPlan new.
]

{ #category : 'accessing' }
SimpleNeuralNetworkExample >> initialWeights: aCollection [
	weights := aCollection asFloatTensor
]

{ #category : 'learning' }
SimpleNeuralNetworkExample >> learn: sample with: expected [

	| result |

	result := forward runOn: (Array with: sample with: weights).
	weights := backward runOn: (Array with: sample with: weights with: expected with: result)
]

{ #category : 'learning' }
SimpleNeuralNetworkExample >> learnAll: samples to: targets steps: n [
	n timesRepeat: [
		samples with: targets do:[:sample :target| self learn: sample with: target]
		]
]

{ #category : 'service' }
SimpleNeuralNetworkExample >> predict: sample [

	| result |

	result := forward runOn: (Array with: sample with: weights).
	^result allFloats



]
