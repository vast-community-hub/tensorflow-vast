Class {
	#name : 'TFOutputTest',
	#superclass : 'TensorFlowTestCase',
	#category : 'TensorFlowTestsApp'
}

{
	#category : 'testing'
}
TFOutputTest >> testOperation [
	| op output |
	op := TFGraph create const: 1.2 asTensor.
	output := op firstOutput.
	self assert: output operation equals: op.
]
