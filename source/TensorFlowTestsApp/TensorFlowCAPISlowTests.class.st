Class {
	#name : 'TensorFlowCAPISlowTests',
	#superclass : 'TensorFlowTestCase',
	#instVars : [
		'library'
	],
	#category : 'TensorFlowTestsApp'
}

{ #category : 'testing tensor' }
TensorFlowCAPISlowTests >> mulGraphTwoInputsInt64ConstTensorDeleted [
	^ TensorFlowCAPITest new mulGraphTwoInputsInt64ConstTensorDeleted
]

{ #category : 'testing session' }
TensorFlowCAPISlowTests >> testDeviceListFinalizationReleasesExternalMemory [

	| tries total addrs session graph |
	total := 0.
	tries := 20.
	graph := TFGraph create.
	session := TFSession on: graph.
	addrs := Set new.
	20
		timesRepeat: [ total := total + tries.
			addrs
				addAll:
					((1 to: tries)
						collect: [ :i | 
							self garbageCollect.
							(TFDeviceList on: session) address ]).
			addrs size < total
				ifTrue: [ ^ self ] ].
	self assert: addrs size < total
]

{ #category : 'testing graph' }
TensorFlowCAPISlowTests >> testGraphFinalizationReleasesExternalMemory [
	" WeakArray restartFinalizationProcess "

	| tries total handles |
	total := 0.
	tries := 10.
	handles := Set new.
	20
		timesRepeat: [ total := total + tries.
			handles
				addAll:
					((1 to: tries)
						collect: [ :i | 
							self garbageCollect.
							TFGraph create useFinalization address ]).
			handles size < total
				ifTrue: [ ^ self ] ].
	self assert: handles size < total
]

{ #category : 'testing tensor' }
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
		runOperations: (Array with: mul)
		inputs: inputs
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

{ #category : 'testing tensor' }
TensorFlowCAPISlowTests >> testRunGraphMulTwoInputsConstTensorDeletedManyTimes [
	20 timesRepeat: [ self testRunGraphMulTwoInputsConstTensorDeleted ]
]

{ #category : 'testing session' }
TensorFlowCAPISlowTests >> testSessionFinalizationReleasesExternalMemory [
	" WeakArray restartFinalizationProcess "

	| tries total handles graph |
	total := 0.
	tries := 20.
	graph := TFGraph create.
	handles := Set new.
	20
		timesRepeat: [ total := total + tries.
			handles
				addAll:
					((1 to: tries)
						collect: [ :i | 
							self garbageCollect.
							(TFSession on: graph) address ]).
			handles size < total
				ifTrue: [ ^ self ] ].
	self assert: handles size < total
]

{ #category : 'testing options' }
TensorFlowCAPISlowTests >> testSessionOptionFinalizationReleasesExternalMemory [
	" WeakArray restartFinalizationProcess "

	| tries total handles |
	total := 0.
	tries := 10.
	handles := Set new.
	20
		timesRepeat: [ total := total + tries.
			handles
				addAll:
					((1 to: tries)
						collect: [ :i | 
							self garbageCollect.
							TFSessionOptions create address ]).
			handles size < total
				ifTrue: [ ^ self ] ].
	self assert: handles size < total
]

{ #category : 'testing status' }
TensorFlowCAPISlowTests >> testStatusFinalizationReleasesExternalMemory [
	" WeakArray restartFinalizationProcess "

	| handles count |
	count := 11.
	handles := (1 to: count)
		collect: [ :i | 
			self garbageCollect.
			TFStatus create address ].
	self assert: handles asSet size < count
]

{ #category : 'testing tensor' }
TensorFlowCAPISlowTests >> testTensorFinalizationReleasesExternalMemory [
	" WeakArray restartFinalizationProcess "

	| handles template tries total |
	total := 0.
	tries := 20.
	handles := Set new.
	template := (Array new: 3)
		at: 1 put: (String new: 10);
		at: 2 put: (String new: 100);
		at: 3 put: (String new: 1000);
		yourself.
	20
		timesRepeat: [ total := total + tries.
			handles
				addAll:
					((1 to: tries)
						collect: [ :i | 
							self garbageCollect.
							(TFTensor fromStringArray: template) address ]).
			handles size < total
				ifTrue: [ ^ self ] ].
	self assert: handles size < total
]
