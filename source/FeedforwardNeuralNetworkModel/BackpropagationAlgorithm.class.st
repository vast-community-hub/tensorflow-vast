Class {
	#name : 'BackpropagationAlgorithm',
	#superclass : 'Object',
	#instVars : [
		'output',
		'tf'
	],
	#category : 'FeedforwardNeuralNetworkModel'
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

	| inputVariable weights predicted gradient learningRate target backProp |

	tf := TensorFlowComputation new.

	target := tf floatInputNamed: 'target'.
	predicted := tf floatInputNamed: 'predicted'.
	backProp := (TFSubstraction of: target minus: predicted) negated.

	gradient := TFSigmoidGradient considering: backProp andGradientsOfInputs: predicted.

	inputVariable := tf floatInputNamed: 'input'.
	weights := tf floatInputNamed: 'weights'.
	learningRate :=
		tf
			floatVariableNamed: 'learningRate'
			shaped: #()
			initializedWith: (TFConstantInitializer with: 0.9 asTensor).
	output :=
		TFSubstraction
			of: weights
			minus: (
				TFElementWiseMultiplication
					of: learningRate
					and: (TFElementWiseMultiplication of: gradient and: inputVariable))
]
