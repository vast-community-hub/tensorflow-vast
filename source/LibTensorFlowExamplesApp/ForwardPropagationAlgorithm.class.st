Class {
	#name : 'ForwardPropagationAlgorithm',
	#superclass : 'Object',
	#instVars : [
		'prediction',
		'tf'
	],
	#category : 'LibTensorFlowExamplesApp'
}

{ #category : 'Instance Creation' }
ForwardPropagationAlgorithm class >> new [

	^ super new initialize
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
ForwardPropagationAlgorithm >> initialize [

	| inputVariable weights |

	tf := TensorFlowComputation new.

	inputVariable := tf floatInputNamed: 'input'.
	weights := tf floatInputNamed: 'weights'.

	prediction := Sigmoid activating: (weights dot: inputVariable)
]

{ #category : 'Processing' }
ForwardPropagationAlgorithm >> predictUsing: aPlaceholderValueMapping [

	^tf compute: prediction feedingInputsWith: aPlaceholderValueMapping
]
