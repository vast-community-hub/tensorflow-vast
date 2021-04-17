Class {
	#name : 'MNISTSoftMaxExamplePlan',
	#superclass : 'Object',
	#instVars : [
		'session',
		'graph',
		'weights',
		'biases',
		'prediction',
		'netInput',
		'input',
		'loss',
		'expectedLabel',
		'learnWeights',
		'learnBiases',
		'activation'
	],
	#category : 'LibTensorFlowExamplesDeprecatedApp'
}

{ #category : 'instance creation' }
MNISTSoftMaxExamplePlan class >> new [

	^super new initialize
]

{ #category : 'initialization' }
MNISTSoftMaxExamplePlan >> initialize [
	self
		initializeGraph;
		initializeParameters;
		initializeInferenceGraph;
		initializeLossGraph;
		initializeLearningGraph;
		initializeSession
]

{ #category : 'initialization' }
MNISTSoftMaxExamplePlan >> initializeGraph [

	graph := TFGraph create
]

{ #category : 'initialization' }
MNISTSoftMaxExamplePlan >> initializeInferenceGraph [
	prediction := graph
		fromBlock: [ :image | 
			input := image.
			netInput := image * weights + biases.
			netInput softmax findMaxOn: 1 asInt32Tensor ]
		named: 'inference'
]

{ #category : 'initialization' }
MNISTSoftMaxExamplePlan >> initializeLearningGraph [

	| learningRate activationGradient biasGradient |

	graph
		fromBlock: [| batchSize |
			learningRate := 0.9 asTensor.
			activationGradient := activation useOutput: 1.
			biasGradient := activationGradient meanOn: #(0) asInt32Tensor.
			batchSize := (input sizeOn: 0) castTo: TFTensor typeFloat.
			learnWeights :=
				weights descent: input \* activationGradient @/ batchSize rate: learningRate.
			learnBiases := biases descent: biasGradient rate: learningRate]
		named: 'learning'
]

{ #category : 'initialization' }
MNISTSoftMaxExamplePlan >> initializeLossGraph [

	loss :=
		graph
			fromBlock: [:expected |
				expectedLabel := expected.
				activation := netInput sparseSoftmaxCrossEntropyWithLogits: expected.
				activation meanOn: #(0) asInt32Tensor]
			inputTypes: (Array with: TFTensor typeInt32)
			named: 'loss'
]

{ #category : 'initialization' }
MNISTSoftMaxExamplePlan >> initializeParameters [

	| aux |

	aux := graph zerosShaped: (Array with: self inputSize with: self outputSize).
	weights := graph variable: 'weights' initialValueFrom: aux.
	aux := graph zerosShaped: (Array with: self outputSize).
	biases := graph variable: 'biases' initialValueFrom: aux
]

{ #category : 'initialization' }
MNISTSoftMaxExamplePlan >> initializeSession [
	session := TFSession on: graph.
	graph initializeOn: session.
]

{ #category : 'accessing' }
MNISTSoftMaxExamplePlan >> inputSize [
	^ 28*28
]

{ #category : 'accessing' }
MNISTSoftMaxExamplePlan >> outputSize [
	^ 10
]

{ #category : 'running' }
MNISTSoftMaxExamplePlan >> predict: inputs [

	| results |

	results :=
		session
			runInputs: (Array with: input firstInput)
			values: (Array with: inputs asFloatTensor)
			outputs: (Array with: prediction firstOutput).
	^results first
]

{ #category : 'running' }
MNISTSoftMaxExamplePlan >> predict: inputs andCompareTo: label [

	| results |

	results :=
		session
			runInputs: (Array with: (input input: 0) with: (expectedLabel input: 0))
			values: (Array with: inputs asFloatTensor with: label asInt32Tensor)
			outputs: (Array with: prediction firstOutput with: loss firstOutput).
	^results
]

{ #category : 'running' }
MNISTSoftMaxExamplePlan >> predict: inputs andLearnFrom: label [

	| results |

	results :=
		session
			runInputs: (Array with: (input input: 0) with: (expectedLabel input: 0))
			values: (Array with: inputs asFloatTensor with: label asInt32Tensor)
			outputs: (Array with: loss firstOutput with: learnWeights firstOutput with: learnBiases firstOutput).
	^results
]
