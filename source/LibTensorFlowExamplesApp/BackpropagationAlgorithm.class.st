Class {
	#name : 'BackpropagationAlgorithm',
	#superclass : 'Object',
	#instVars : [
		'output',
		'tf'
	],
	#category : 'LibTensorFlowExamplesApp'
}

{ #category : 'Instance Creation' }
BackpropagationAlgorithm class >> new [

	^super new initialize
]

{ #category : 'Processing' }
BackpropagationAlgorithm >> improvedWeightsUsing: aPlaceholderValueMapping [

	^(tf
		computeAllNamed: (Array with: output operationName)
		feedingInputsWith: aPlaceholderValueMapping)
			at: output operationName
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
BackpropagationAlgorithm >> initialize [

	| input weights predicted gradient learningRate target backProp |

	tf := TensorFlowComputation new.

	target := tf floatInputNamed: 'target'.
	predicted := tf floatInputNamed: 'predicted'.
	backProp := (target - predicted) negated.

	gradient := SigmoidGradient considering: predicted andGradientsOfInputs: backProp.

	input := tf floatInputNamed: 'input'.
	weights := tf floatInputNamed: 'weights'.
	learningRate := VariableTensor on: tf named: 'learningRate' with: 0.9 asTensor.
	output := weights - (learningRate * gradient * input)
]
