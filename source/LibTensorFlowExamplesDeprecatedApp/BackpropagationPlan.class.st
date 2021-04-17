Class {
	#name : 'BackpropagationPlan',
	#superclass : 'ExamplePlan',
	#instVars : [
		'weights',
		'activation',
		'target',
		'learn',
		'delta',
		'lastDelta'
	],
	#category : 'LibTensorFlowExamplesDeprecatedApp'
}

{ #category : 'accessing' }
BackpropagationPlan >> delta [
	^ lastDelta
]

{ #category : 'accessing' }
BackpropagationPlan >> graph [
	^ graph
]

{ #category : 'initialization',
  #vaVisibility : 'private' }
BackpropagationPlan >> initializeBackwardGraph [

	| actual learningRate learningRateValue one input |

	actual := activation.
	one := graph const: 'one' value: #((1 1) (1 1)) asFloatTensor.

	learningRateValue := 0.9 asTensor.
	learningRate := graph const: 'learningRate' value: learningRateValue.

	input := inputs first operationOn: graph.

	target := graph placeholder: 'target' type: TFTensor typeFloat.

	delta := (target - actual) negated @* actual @* (one - actual) @* input.

	"learn := weights assign: weights - learningRate @* delta."
	"learn := weights -= learningRate @* delta."
	learn := weights descent: delta rate: learningRate
]

{ #category : 'initialization',
  #vaVisibility : 'private' }
BackpropagationPlan >> initializeForwardGraph [

	| input |

	input := graph placeholder: 'Input' type: TFTensor typeFloat.

	activation := (weights * input) sigmoid.

	outputs := Array with: activation firstOutput.
	inputs := Array with: input firstInput
]

{ #category : 'initialization',
  #vaVisibility : 'private' }
BackpropagationPlan >> initializeGraph [
	super initializeGraph.
	self
		initializeVariables;
		initializeForwardGraph;
		initializeBackwardGraph.
]

{ #category : 'initialization',
  #vaVisibility : 'private' }
BackpropagationPlan >> initializeVariables [

	| initialWeights random |
	"Was used in Cuis: 
	Random withDefaultDo: [:random |
		initialWeights := (1 to: 4) collect: [:unused | random next]]."

	random := EsRandom new.
	initialWeights := (1 to: 4) collect: [:unused | random next].
	initialWeights := TFTensor fromFloats: initialWeights shape: (TensorShape matrixSized: 2 by: 2).

	weights := graph variable: 'weights' initialValue: initialWeights
]

{ #category : 'training' }
BackpropagationPlan >> learn: sample with: expected [

	| results |

	results :=
		session
			runInputs: (Array with: inputs first with: target firstInput)
			values: (Array with: sample with: expected)
			outputs: (Array with: learn firstOutput with: delta firstOutput).

	lastDelta := results at: 2.
	^results first
]

{ #category : 'accessing' }
BackpropagationPlan >> weights [

	^session runOutput: weights firstOutput
]
