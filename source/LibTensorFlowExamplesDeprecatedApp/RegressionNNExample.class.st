"
I compute a regression on arbitrary functions.
Implementation of http://cs.stanford.edu/people/karpathy/convnetjs/demo/regression.html

RegressionNNExample exampleTrainedAndPlot
"
Class {
	#name : 'RegressionNNExample',
	#superclass : 'Object',
	#instVars : [
		'graph',
		'input',
		'weights1',
		'biases1',
		'weights2',
		'biases2',
		'weights3',
		'biases3',
		'prediction',
		'netInput',
		'weights4',
		'biases4',
		'hidden1',
		'hidden2',
		'expectedLabel',
		'loss',
		'session',
		'hidden3',
		'learn'
	],
	#category : 'LibTensorFlowExamplesDeprecatedApp'
}

{ #category : 'examples' }
RegressionNNExample class >> exampleFunction [
	^ [ :x | | y |
			y := x * 10 - 5.
			y * y sin ].
]

{ #category : 'examples' }
RegressionNNExample class >> exampleTrained [

	| function net |

	function := self exampleFunction.
	net := self exampleTrainedOn: function.
	^net
]

{ #category : 'examples' }
RegressionNNExample class >> exampleTrainedAndPlot [
"The following source failed to compile (all double quotes have been doubled):
	| net predictor xValues b ds |
	net := self exampleTrained.
	predictor := [ :x | 
	| result |
	result := net predict: {{x}}.
	result asNumbers first first ].
	xValues := 0 to: 1.0 by: 0.01.
	b := RTGrapher new.
	b extent: 300 @ 200.
	ds := RTData new.
	ds noDot.
	ds points: xValues.
	ds y: predictor.
	ds x: #yourself.
	ds connectColor: Color green.
	b add: ds.
	ds := RTData new.
	ds noDot.
	ds points: xValues.
	ds y: self exampleFunction.
	ds x: #yourself.
	ds connectColor: Color red.
	b add: ds.
	b open.
	^ net
"

	^ self halt: 'The source for this method failed to compile'
]

{ #category : 'examples' }
RegressionNNExample class >> exampleTrainedOn: function [

	| net rnd interval xs ys |

	net := self new.
	rnd := EsRandom new.
	xs := (1 to: 100) collect: [:i | Array with: rnd next].
	ys := xs collect: [:x | Array with: (function value: x first)].
	interval := 1 to: xs size.

	10000 timesRepeat: [| x indices y |
		indices := (1 to: 60) collect: [:i | interval atRandom].
		x := indices collect: [:index | xs at: index].
		y := indices collect: [:index | ys at: index].
		net predict: x andLearnFrom: y].
	^net
]

{ #category : 'instance creation' }
RegressionNNExample class >> new [

	^super new initialize
]

{ #category : 'accessing' }
RegressionNNExample >> graph [
	^ graph
]

{ #category : 'accessing' }
RegressionNNExample >> hidden1Size [
	^ 20
]

{ #category : 'accessing' }
RegressionNNExample >> hidden2Size [
	^ 20
]

{ #category : 'accessing' }
RegressionNNExample >> hidden3Size [
	^ 20
]

{ #category : 'initialization' }
RegressionNNExample >> initialize [
	self
		initializeGraph;
		initializeParameters;
		initializeInferenceGraph;
		initializeLossGraph;
		initializeLearningGraph;
		initializeSession.
]

{ #category : 'initialization' }
RegressionNNExample >> initializeGraph [

	graph := TFGraph create
]

{ #category : 'initialization' }
RegressionNNExample >> initializeInferenceGraph [
	hidden1 := graph
		fromBlock: [:image |
			input := image.
			(image * weights1 + biases1) rectified]
		named: 'layer1'.
	hidden2 := graph fromBlock: [(hidden1 * weights2 + biases2) sigmoid] named: 'layer2'.
	hidden3 := graph fromBlock: [(hidden2 * weights3 + biases3) sigmoid] named: 'layer3'.
	prediction := graph fromBlock: [hidden3 * weights4 + biases4] named: 'layer4'.

]

{ #category : 'initialization' }
RegressionNNExample >> initializeLearningGraph [

	| axis0 learningRate batchSize biasGradient one backprop learnBiases1 learnBiases2 learnBiases3
	  learnBiases4 learnWeights1 learnWeights2 learnWeights3 learnWeights4 |

	learningRate := 0.1 asTensor.
	batchSize := graph fromBlock: [(input sizeOn: 0) castTo: TFTensor typeFloat] named: 'batchSize'.
	axis0 := graph const: #(0) asInt32Tensor.
	one := 1.0 asTensor asOperationOn: graph.
	graph
		fromBlock: [| gradient |
			gradient := (prediction - expectedLabel).
			biasGradient := gradient meanOn: axis0.
			learnWeights4 := weights4 descent: hidden3 \* gradient @/ batchSize rate: learningRate.
			learnBiases4 := biases4 descent: biasGradient rate: learningRate.
			backprop := (gradient *\ weights4)]
		named: 'learning4'.

	graph
		fromBlock: [| gradient |
			gradient := backprop @* hidden3 @* (one - hidden3).
			biasGradient := gradient meanOn: axis0.
			learnWeights3 := weights3 descent: hidden2 \* gradient @/ batchSize rate: learningRate.
			learnBiases3 := biases3 descent: biasGradient rate: learningRate.
			backprop := (gradient *\ weights3)]
		named: 'learning3'.

	graph
		fromBlock: [| gradient |
			gradient := backprop @* hidden2 @* (one - hidden2).
			learnWeights2 := weights2 descent: hidden1 \* gradient @/ batchSize rate: learningRate.
			learnBiases2 := biases2 descent: (gradient meanOn: axis0) rate: learningRate.
			backprop := (gradient *\ weights2)]
		named: 'learning2'.

	graph
		fromBlock: [| gradient |
			gradient := backprop timesRectifiedGradOf: hidden1.
			learnWeights1 := weights1 descent: input \* gradient rate: learningRate.
			learnBiases1 := biases1 descent: (gradient meanOn: axis0) rate: learningRate]
		named: 'learning1'.

	learn :=
		graph
			newOperation: 'Identity'
			named: 'learn'
			described: [:description |
				description
					addInput: loss firstOutput;
					addControlInput: (learnWeights1 firstOutput operationOn: graph);
					addControlInput: (learnBiases1 firstOutput operationOn: graph);
					addControlInput: (learnWeights2 firstOutput operationOn: graph);
					addControlInput: (learnBiases2 firstOutput operationOn: graph);
					addControlInput: (learnWeights3 firstOutput operationOn: graph);
					addControlInput: (learnBiases3 firstOutput operationOn: graph);
					addControlInput: (learnWeights4 firstOutput operationOn: graph);
					addControlInput: (learnBiases4 firstOutput operationOn: graph)]
]

{ #category : 'initialization' }
RegressionNNExample >> initializeLossGraph [

	loss :=
		graph
			fromBlock: [:expected |
				expectedLabel := expected.
				(prediction - expectedLabel) squared meanOn: #(0) asInt32Tensor]
			inputTypes: (Array with: TFTensor typeFloat)
			named: 'loss'
]

{ #category : 'initialization' }
RegressionNNExample >> initializeParameters [

	| aux |

	graph
		fromBlock: [
			aux :=
				graph
					truncatedNormalRandomShaped: (Array with: self inputSize with: self hidden1Size)
					stddev: 1.0 / self inputSize sqrt.
			weights1 := graph variable: 'weights1' initialValueFrom: aux.
			aux := graph zerosShaped: (Array with: self hidden1Size).
			biases1 := graph variable: 'biases1' initialValueFrom: aux.

			aux :=
				graph
					truncatedNormalRandomShaped:
						(Array with: self hidden1Size with: self hidden2Size)
					stddev: 1.0 / self hidden1Size sqrt.
			weights2 := graph variable: 'weights2' initialValueFrom: aux.
			aux := graph zerosShaped: (Array with: self hidden2Size).
			biases2 := graph variable: 'biases2' initialValueFrom: aux.

			aux :=
				graph
					truncatedNormalRandomShaped:
						(Array with: self hidden2Size with: self hidden3Size)
					stddev: 1.0 / self hidden2Size sqrt.
			weights3 := graph variable: 'weights3' initialValueFrom: aux.
			aux := graph zerosShaped: (Array with: self hidden3Size).
			biases3 := graph variable: 'biases3' initialValueFrom: aux.

			aux :=
				graph
					truncatedNormalRandomShaped: (Array with: self hidden3Size with: self outputSize)
					stddev: 1.0 / self hidden3Size sqrt.
			weights4 := graph variable: 'weights4' initialValueFrom: aux.
			aux := graph zerosShaped: (Array with: self outputSize).
			biases4 := graph variable: 'biases4' initialValueFrom: aux]
		named: 'parameters'
]

{ #category : 'initialization' }
RegressionNNExample >> initializeSession [
	session := TFSession on: graph.
	graph initializeOn: session
]

{ #category : 'accessing' }
RegressionNNExample >> inputSize [
	^ 1
]

{ #category : 'accessing' }
RegressionNNExample >> intput [
	^ input
]

{ #category : 'accessing' }
RegressionNNExample >> outputSize [
	^ 1
]

{ #category : 'running' }
RegressionNNExample >> predict: inputs [

	| results |

	results :=
		session
			runInputs: (Array with: input firstInput)
			values: (Array with: inputs asFloatTensor)
			outputs: (Array with: prediction firstOutput).
	^results first
]

{ #category : 'running' }
RegressionNNExample >> predict: inputs andCompareTo: label [

	| results |

	results :=
		session
			runInputs: (Array with: input firstInput with: expectedLabel firstInput)
			values: (Array with: inputs asFloatTensor with: label asFloatTensor)
			outputs: (Array with: prediction firstOutput with: loss firstOutput).
	^results
]

{ #category : 'running' }
RegressionNNExample >> predict: inputs andLearnFrom: label [

	| results |

	results :=
		session
			runInputs: (Array with: input firstInput with: expectedLabel firstInput)
			values: (Array with: inputs asFloatTensor with: label asFloatTensor)
			outputs: (Array with: loss firstOutput with: learn firstOutput).
	^results
]
