Class {
	#name : 'BackpropagationForwardPlan',
	#superclass : 'ExamplePlan',
	#category : 'LibTensorFlowExamplesApp'
}

{ #category : 'initialization',
  #vaVisibility : 'private' }
BackpropagationForwardPlan >> initializeGraph [

	| activation inputVariable netInput weights |

	super initializeGraph.
	inputVariable := graph placeholder: 'Input' type: TFTensor typeFloat.
	weights := graph placeholder: 'weights' type: TFTensor typeFloat.
	netInput := weights * inputVariable.
	activation := netInput sigmoid.
	outputs := Array with: activation firstOutput.
	inputs := Array with: inputVariable firstInput with: weights firstInput
]
