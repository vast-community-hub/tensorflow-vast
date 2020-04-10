Class {
	#name : 'ExampleNearestNeighborPlan',
	#superclass : 'ExamplePlan',
	#category : 'LibTensorFlowExamplesApp'
}

{ #category : 'initialization',
  #vaVisibility : 'private' }
ExampleNearestNeighborPlan >> initializeGraph [

	| neg add abs axis axisValue distance testing training prediction |

	super initializeGraph.

	training := graph placeholder: 'training' type: TFTensor typeFloat.
	testing := graph placeholder: 'testing' type: TFTensor typeFloat.
	axisValue := TFTensor fromInt32: 0.
	axis := graph const: 'axis' value: axisValue.
	neg :=
		graph
			newOperation: 'Neg'
			named: 'neg'
			described: [:description | description addInput: (testing firstOutput)].
	add :=
		graph
			add: 'add'
			described: [:description |
				description addInput: (neg firstOutput).
				description addInput: (training firstOutput)].
	abs :=
		graph
			newOperation: 'Abs'
			named: 'abs'
			described: [:description | description addInput: (add firstOutput)].
	distance :=
		graph
			newOperation: 'Sum'
			named: 'distance'
			described: [:description |
				description addInput: (abs firstOutput).
				description addInput: (axis firstOutput)].

	prediction :=
		graph
			newOperation: 'ArgMin'
			named: 'argmin'
			described: [:description |
				description addInput: (distance firstOutput).
				description addInput: (axis firstOutput)].

	outputs := (Array with: (prediction firstOutput)).
	inputs := (Array with: (training input: 0) with: (testing input: 0))
]

{ #category : 'initialization' }
ExampleNearestNeighborPlan >> initializeGraphWithOperations [

	| axis distance testing training prediction |

	graph := TFGraph create.

	training := graph placeholder: 'training' type: TFTensor typeFloat.
	testing := graph placeholder: 'testing' type: TFTensor typeFloat.
	axis := 0 asInt32Tensor.

	distance := (testing - training) abs sumOn: axis.
	prediction := distance findMinOn: axis.

	outputs := (Array with: prediction firstOutput).
	inputs := (Array with: training firstInput with: testing firstInput)
]

{ #category : 'evaluating' }
ExampleNearestNeighborPlan >> predict: covariatesTesting from: covariatesTraining [

	| result |

	result := self runOn: (Array with: covariatesTraining with: covariatesTesting).
	^result allInt64s collect: [:each | each + 1]
]
