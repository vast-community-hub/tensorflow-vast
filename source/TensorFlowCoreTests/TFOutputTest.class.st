Class {
	#name : 'TFOutputTest',
	#superclass : 'TensorFlowTestCase',
	#category : 'TensorFlowCoreTests'
}

{ #category : 'testing' }
TFOutputTest >> testOperation [

	| op output |

	op :=
		TFGraph create
			newOperation: 'Placeholder'
			named: 'x'
			described: [:description | description at: 'dtype' putType: TFTensor typeFloat].
	output := op firstOutput.
	self assert: output operation equals: op
]
