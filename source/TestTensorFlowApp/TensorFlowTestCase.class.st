Class {
	#name : 'TensorFlowTestCase',
	#superclass : 'TestCase',
	#pools : [
		'TensorFlowConstants'
	],
	#category : 'TestTensorFlowApp'
}

{
	#category : 'SUnit'
}
TensorFlowTestCase class >> isAbstract [

	^self sunitName = #TensorFlowTestCase
]

{
	#category : 'SUnit'
}
TensorFlowTestCase class >> testSelectors [
	"The API method is allTestSelectors which now includes #shouldInheritSelectors and so handles
all cases.  Unlike that method, this does not guarantee to return a sorted ordered collection."
	^self sunitSelectors select: [:each | ('test*' sunitMatch: each) and: [each argumentCount = 0]]
]

{
	#category : 'Asserting'
}
TensorFlowTestCase >> assert: aNumber closeTo: anotherNumber [
	^ self
		assert: (self number: aNumber isCloseTo: anotherNumber)
		description: anotherNumber printString, ' was expected to be close to ', aNumber printString.

]

{
	#category : 'Asserting'
}
TensorFlowTestCase >> assertAll: aCollection closeTo: anotherCollection [
	^ aCollection with: anotherCollection do: [:a :b | self assert: a closeTo: b]
]

{
	#category : 'Accessing',
	#vaVisibility : 'private'
}
TensorFlowTestCase >> dispatcher [

	^TFLibraryDispatcher default
]

{
	#category : 'Accessing'
}
TensorFlowTestCase >> garbageCollect [
	System globalGarbageCollect.
	[Processor finalizeCycle] whileTrue: [].
]

{
	#category : 'Asserting'
}
TensorFlowTestCase >> number: aNumber isCloseTo: anotherNumber [
 	"are these two numbers close?"
	self = 0.0 ifTrue: [^anotherNumber abs < 0.0001].
	anotherNumber = 0 ifTrue: [^aNumber abs < 0.0001].
	^aNumber = anotherNumber asFloat
		or: [(aNumber - anotherNumber) abs / (aNumber abs max: anotherNumber abs) < 0.0001]
]

{
	#category : 'Asserting'
}
TensorFlowTestCase >> should: aBlock raiseError: aString [
	| message |
	message := 'No Error was signaled'.
	aBlock on: Error do: [ :error | message := error arguments first ].
	self assert: (message includesSubstring: aString)
]

{
	#category : 'Asserting'
}
TensorFlowTestCase >> shouldnt: aBlock raise: anExceptionalEvent [
	aBlock value.
	self assert: true.
]

{
	#category : 'Asserting'
}
TensorFlowTestCase >> shouldnt: aBlock raise: anExceptionalEvent description: aString [
	[aBlock value] on: Error do: [self assert: false description: aString]
]
