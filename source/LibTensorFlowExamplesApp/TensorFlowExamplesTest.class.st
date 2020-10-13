Class {
	#name : 'TensorFlowExamplesTest',
	#superclass : 'TestCase',
	#category : 'LibTensorFlowExamplesApp'
}

{ #category : 'instance creation' }
TensorFlowExamplesTest class >> new [

	^super new initialize
]

{ #category : 'testing-NearesNeighbor' }
TensorFlowExamplesTest >> tensorFrom: points [

	| rank transposed |

	rank := points first size.
	transposed := OrderedCollection new.
	(1 to: rank) do: [:i | transposed add: OrderedCollection new].
	points do: [:point |
		point withIndexDo: [:value :coordinate | (transposed at: coordinate) add: value]].
	^TFTensor fromFloats: transposed
]

{ #category : 'testing-Backpropagation' }
TensorFlowExamplesTest >> testBackpropagationPlanBackguard [

	| plan inputs rawResult result const graph weights first second sigmoid |

	plan := BackpropagationPlan new.

	inputs := (Array with: #(0) with: (Array with: 2 ln)) asFloatTensor.

	graph := plan graph.
	const := graph operationNamed: 'weights_initialValue'.
	weights := (const tensorAt: 'value') allFloats.

	sigmoid := [:x | (x negated exp + 1) reciprocal].
	first := sigmoid value: 2 ln * weights second.
	second := sigmoid value: 2 ln * weights fourth.

	rawResult := plan runOn: (Array with: inputs).
	result := rawResult allFloats.


	self
		assert: (result first closeTo: first);
		assert: (result second closeTo: second)
]

{ #category : 'testing-Backpropagation' }
TensorFlowExamplesTest >> testBackpropagationPlanBackguardChangesWeights [

	| plan const graph w0 weights inputs result target |

	plan := BackpropagationPlan new.
	graph := plan graph.

	inputs := (Array with: #(0) with: (Array with: 2 ln)) asFloatTensor.
	target := #((0.5) (0.5)) asFloatTensor.

	const := graph operationNamed: 'weights_initialValue'.
	w0 := const tensorAt: 'value'.
	weights := plan weights.

	self assert: w0 shape equals: #(2 2).
	self assert: weights shape equals: #(2 2).
	self assert: w0 allFloats equals: weights allFloats.

	result := plan learn: inputs with: target.

	self assert: weights allFloats equals: result allFloats.
	self assert: weights shape equals: result shape.
	self deny: weights allFloats = w0 allFloats
]

{ #category : 'testing-Backpropagation' }
TensorFlowExamplesTest >> testBackpropagationPlanBackguardConverges [

	| plan const graph w0 weights inputs target result |

	plan := BackpropagationPlan new.
	graph := plan graph.

	inputs := (Array with: #(1) with: (Array with: 2 ln)) asFloatTensor.
	target := #((0.5) (0.5)) asFloatTensor.

	const := graph operationNamed: 'weights_initialValue'.
	w0 := const tensorAt: 'value'.
	weights := plan weights.

	self assert: w0 shape equals: #(2 2).
	self assert: weights shape equals: #(2 2).
	self assert: w0 allFloats equals: weights allFloats.

	200 timesRepeat: [plan learn: inputs with: target].

	self assert: (plan delta allFloats squared sum closeTo: 0).

	result := (plan runOn: (Array with: inputs)) allFloats.

	self assert: (result first closeTo: 0.5).
	self assert: (result second closeTo: 0.5)
]

{ #category : 'testing-Backpropagation' }
TensorFlowExamplesTest >> testBackpropagationPlanForward [

	| plan inputs rawResult result const graph weights first second sigmoid |

	plan := BackpropagationPlan basicNew.
	plan initializeGraph.
	plan initializeSession.

	inputs := (Array with: #(0) with: (Array with: 2 ln)) asFloatTensor.

	graph := plan graph.
	const := graph operationNamed: 'weights_initialValue'.
	weights := (const tensorAt: 'value') allFloats.

	sigmoid := [:x | (x negated exp + 1) reciprocal].
	first := sigmoid value: 2 ln * weights second.
	second := sigmoid value: 2 ln * weights fourth.

	rawResult := plan runOn: (Array with: inputs).
	result := rawResult allFloats.


	self
		assert: (result first closeTo: first);
		assert: (result second closeTo: second)
]

{ #category : 'testing-Backpropagation' }
TensorFlowExamplesTest >> testBackpropagationPlantInitializeBackguard [

	| bpp |

	bpp := BackpropagationPlan basicNew.
	bpp instVarNamed: 'graph' put: TFGraph create.
	bpp initializeVariables.
	bpp initializeForwardGraph.
	bpp initializeBackwardGraph.

	self assert: true description: 'No exception should be raised by this test'
]

{ #category : 'testing-Backpropagation' }
TensorFlowExamplesTest >> testBackpropagationPlantInitializeForward [

	| bpp |

	bpp := BackpropagationPlan new.
	bpp instVarNamed: 'graph' put: TFGraph create.
	bpp initializeVariables.
	bpp initializeForwardGraph.

	self assert: true description: 'No exception should be raised by this test'
]

{ #category : 'testing-Backpropagation' }
TensorFlowExamplesTest >> testBackpropagationPlantInitializeVariables [

	| bpp graph const weights |

	bpp := BackpropagationPlan basicNew.
	bpp instVarNamed: 'graph' put: TFGraph create.
	bpp initializeVariables.
	graph := bpp graph.
	self assert: graph allInitializers size equals: 1.
	self assert: graph allVariables size equals: 1.
	self assert: graph allVariables first name equals: 'weights'.
	const := graph operationNamed: 'weights_initialValue'.
	weights := const tensorAt: 'value'.
	self assert: weights shape equals: #(2 2).
	weights allFloats do: [:each | self assert: (each between: 0 and: 1)]
]

{ #category : 'testing-Backpropagation' }
TensorFlowExamplesTest >> testForward [

	| inputs plan rawResult result weights |

	plan := BackpropagationForwardPlan new.
	inputs := (Array with: #(0) with: (Array with: 2 ln)) asFloatTensor.
	weights := TFTensor fromFloats: #((1 1) (1 0)).
	rawResult := plan runOn: (Array with: inputs with: weights).
	result := rawResult allFloats.

	self
		assert: (result first closeTo: (1 + 0.5) reciprocal);
		assert: (result second closeTo: 0.5)
]

{ #category : 'testing MNIST' }
TensorFlowExamplesTest >> testMNIST3LayersNNForwardGraph [

	" Not sure how to test this better. weights are random, so output is random.
	I believe that choosing the right input value the output should comply with some statistics,
	however there are only 10 output valus, and I believe that's not enough to have statistical meaning"

	| mnist result first second |

	mnist := MNIST3LayersNNExamplePlan new.
	result :=
		mnist predict: (
			Array
				with: (ByteArray new: mnist inputSize withAll:  2)
				with: (ByteArray new: mnist inputSize withAll:  1)).
	self assert: #(2) asTensorShape equals: result shape.
	first := result asNumbers first.
	second := result asNumbers second.
	self assert: (0 <= first and: [first < 10]).
	self assert: (0 <= second and: [second < 10])
]

{ #category : 'testing MNIST' }
TensorFlowExamplesTest >> testMNIST3LayersNNInitialization [

	MNIST3LayersNNExamplePlan new
]

{ #category : 'testing MNIST' }
TensorFlowExamplesTest >> testMNIST3LayersNNLossGraph [

	" Not sure how to test this better. weights are random, so output is random.
	I believe that choosing the right input value the output should comply with some statistics,
	however there are only 10 output valus, and I believe that's not enough to have statistical meaning"

	| mnist results first second |

	mnist := MNIST3LayersNNExamplePlan new.
	results :=
		mnist
			predict: (
				Array
					with: (ByteArray new: mnist inputSize)
					with: (ByteArray new: mnist inputSize withAll: 1))
			andCompareTo: #(1 2).
	self assert: #(2) asTensorShape equals: results first shape.
	first := results first asNumbers first.
	second := results first asNumbers second.
	self assert: (0 <= first and: [first < 10]).
	self assert: (0 <= second and: [second < 10]).
	self assert: TensorShape scalar equals: results second shape.
	self assert: results second asNumbers > 0
]

{ #category : 'testing MNIST' }
TensorFlowExamplesTest >> testMNISTSoftMaxForwardGraph [

	" Not sure how to test this better. weights are random, so output is random.
	I believe that choosing the right input value the output should comply with some statistics,
	however there are only 10 output valus, and I believe that's not enough to have statistical meaning"

	| mnist result |

	mnist := MNISTSoftMaxExamplePlan new.
	result :=
		mnist predict: (
			Array
				with: (ByteArray new: mnist inputSize)
				with: (ByteArray new: mnist inputSize withAll: 1)).
	self assert: #(2) asTensorShape equals: result shape.
	self assert: (result allInt32s first closeTo: 0).
	self assert: (result allInt32s second closeTo: 0)
]

{ #category : 'testing MNIST' }
TensorFlowExamplesTest >> testMNISTSoftMaxLossGraph [

	" Not sure how to test this better. weights are random, so output is random.
	I believe that choosing the right input value the output should comply with some statistics,
	however there are only 10 output valus, and I believe that's not enough to have statistical meaning"

	| mnist results |

	mnist := MNISTSoftMaxExamplePlan new.
	results :=
		mnist
			predict: (
				Array
					with: (ByteArray new: mnist inputSize)
					with: (ByteArray new: mnist inputSize withAll: 1))
			andCompareTo: #(1 2).
	self assert: #(2) asTensorShape equals: results first shape.
	self assert: results first asNumbers first equals: 0.
	self assert: results first asNumbers second equals: 0.
	self assert: TensorShape scalar equals: results second shape.
	self assert: results second allFloats sum abs > 0
]

{ #category : 'testing MNIST' }
TensorFlowExamplesTest >> testMNISTSoftMaxnitialization [

	MNISTSoftMaxExamplePlan new
]

{ #category : 'testing-NearesNeighbor' }
TensorFlowExamplesTest >> testNearestNeighbor [

	| plan |

	plan := ExampleNearestNeighborPlan new.
	self testNearestNeighbor: plan
]

{ #category : 'testing-NearesNeighbor' }
TensorFlowExamplesTest >> testNearestNeighbor: plan [

	| first second third closest references tensorReference tensors predictor |

	first := #(0 0 0 0 0).
	second := #(1 1 3 4 2).
	third := #(8 1 3 4 2).
	references := (Array with: first with: second with: third).
	tensorReference := self tensorFrom: references.
	tensors := references collect: [:point | self tensorFrom: (Array with: point)].

	predictor := [:unknown | | result |
		result := plan predict: unknown from: tensorReference.
		result first].

	closest := predictor value: tensors first.
	self assert: closest equals: 1.

	closest := predictor value: tensors second.
	self assert: closest equals: 2.

	closest := predictor value: tensors third.
	self assert: closest equals: 3
]

{ #category : 'testing-NearesNeighbor' }
TensorFlowExamplesTest >> testNearestNeighborWithOperations [

	| plan |

	plan := ExampleNearestNeighborPlan new initializeGraphWithOperations initializeSession.
	self testNearestNeighbor: plan
]

{ #category : 'testing-ols' }
TensorFlowExamplesTest >> testOLS [

	self testOLS: OLSExample new
]

{ #category : 'testing-ols' }
TensorFlowExamplesTest >> testOLS: ols [

	| x y betas |

	x := TFTensor fromFloats: #((1 2 3) (6 7 8) (4 5 6) (9 2 3) (1 10 2)).

	y := TFTensor fromFloats: #((14) (44) (32) (22) (27)).

	betas := ols regress: x on: y.
	self
		assert: (betas first closeTo: 1);
		assert: (betas second closeTo: 2);
		assert: (betas third closeTo: 3)



]

{ #category : 'testing-ols' }
TensorFlowExamplesTest >> testOLSWithOperations [

	self testOLS: OLSExample new initializeWithOperations
]

{ #category : 'testing-NeuralNetwork' }
TensorFlowExamplesTest >> testSimpleNeuralNetwork [

	| inputs weights nn prediction target targetValues |

	inputs := (Array with: #(1) with: (Array with: 2 ln)) asFloatTensor.
	targetValues := #(0.5 0.5).
	target := TFTensor fromFloats: targetValues.
	weights := #((1 1) (1 0)).
	nn := SimpleNeuralNetworkExample new.
	nn
		initialWeights: weights;
		learnAll: (Array with: inputs) to: (Array with: target) steps: 100.
	prediction := nn predict: inputs.
	targetValues with: prediction do: [:real :predicted | self assert: (real - predicted) abs < 0.1]
]
