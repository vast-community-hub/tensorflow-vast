Class {
	#name : 'ExampleOLSPlan',
	#superclass : 'ExamplePlan',
	#category : 'LibTensorFlowExamplesApp'
}

{ #category : 'initialization',
  #vaVisibility : 'private' }
ExampleOLSPlan >> initializeGraph [

	| x xtx y xty inverse result |

	super initializeGraph.

	x := graph placeholder: 'x' type: TFTensor typeFloat.
	y := graph placeholder: 'y' type: TFTensor typeFloat.

	xtx :=
		graph
			newOperation: 'MatMul'
			named: 'xTx'
			described: [:description |
				description addInput: x firstOutput.
				description addInput: x firstOutput.
				description at: 'transpose_a' putBoolean: true].

	inverse :=
		graph
			newOperation: 'MatrixInverse'
			named: 'inv'
			described: [:description | description addInput: xtx firstOutput].

	xty :=
		graph
			newOperation: 'MatMul'
			named: 'xTy'
			described: [:description |
				description addInput: x firstOutput.
				description addInput: y firstOutput.
				description at: 'transpose_a' putBoolean: true].

	result :=
		graph
			newOperation: 'MatMul'
			named: 'result'
			described: [:description |
				description addInput: inverse firstOutput.
				description addInput: xty firstOutput].

	outputs := Array with: result firstOutput.
	inputs := Array with: x firstInput with: y firstInput
]

{ #category : 'initialization' }
ExampleOLSPlan >> initializeGraphWithOperations [

	| x y prediction |

	super initializeGraph.

	x := graph placeholder: 'x' type: TFTensor typeFloat.
	y := graph placeholder: 'y' type: TFTensor typeFloat.

	prediction := (x \* x) inverse * (x \* y).

	outputs := Array with: prediction firstOutput.
	inputs := Array with: x firstInput with: y firstInput
]
