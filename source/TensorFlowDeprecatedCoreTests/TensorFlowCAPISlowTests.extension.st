Extension {
	#name : 'TensorFlowCAPISlowTests'
}

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing tensor'] }
TensorFlowCAPISlowTests >> mulGraphTwoInputsInt64ConstTensorDeleted [
	^ TensorFlowCAPITest new mulGraphTwoInputsInt64ConstTensorDeleted
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing tensor'] }
TensorFlowCAPISlowTests >> testRunGraphMulTwoInputsConstTensorDeleted [
	| graph inputs inputValues mul output session results |
	graph := self mulGraphTwoInputsInt64ConstTensorDeleted.
	inputs := Array
		with: ((graph operationNamed: 'in1') input: 0)
		with: ((graph operationNamed: 'in2') input: 0).
	inputValues := Array
		with: (TFTensor fromInt64: 16r23)
		with: (TFTensor fromInt64: 16r24).
	self garbageCollect.
	(TFTensor fromInt64: 16r1234123412341234) useFinalization.
	self garbageCollect.
	mul := graph operationNamed: 'mul2'.
	output := mul output: 0.
	session := TFSession on: graph.
	results := session
		runInputs: inputs
		values: inputValues
		outputs: (Array with: output).
	self deny: results isNull.
	self deny: results first isNull.
	self deny: results first data isNull.
	self
		assert: results first asNumbers
		equals: (16r2121212121212121 * 16r23 * 16r24 bitAnd: 16rFFFFFFFFFFFFFFFF).
	graph delete.
	results first delete
]

{ #category : '*TensorFlowDeprecatedCoreTests',
 #vaCategories : ['testing tensor'] }
TensorFlowCAPISlowTests >> testRunGraphMulTwoInputsConstTensorDeletedManyTimes [
	20 timesRepeat: [ self testRunGraphMulTwoInputsConstTensorDeleted ]
]
