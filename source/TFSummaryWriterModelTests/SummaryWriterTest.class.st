Class {
	#name : 'SummaryWriterTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFSummaryWriterModelTests'
}

{ #category : 'Test' }
SummaryWriterTest >> testWriteOneScalar [

	| writer folder |

	writer := SummaryWriter on: tf writingTo: 'summary-tests'.

	folder := FileSystemAPI current directoryNamed: './summary-tests'.
	[| files |
		writer writeScalar: 10.50 atStep: 1 tagged: 'my-values'.

		writer flush.

		files := folder fileEntries.
		self assert: files size equals: 1.
		self assert: files any stSize equals: 87]
			ensure: [folder deleteAll]
]

{ #category : 'Test' }
SummaryWriterTest >> testWriteSeveralScalar [

	| writer folder |

	writer := SummaryWriter on: tf writingTo: 'summary-tests'.

	folder := FileSystemAPI current directoryNamed: './summary-tests'.
	[| files |
		{ 1. 2. 3. 5. 8. 13. 21 }
			doWithIndex: [:n :i | writer writeScalar: n atStep: i tagged: 'fibo'].

		writer flush.

		files := folder fileEntries.
		self assert: files size equals: 1.
		self assert: files any stSize equals: 334]
			ensure: [folder deleteAll]
]

{ #category : 'Test' }
SummaryWriterTest >> testWritingImmediatly [

	| writer folder |

	writer :=
		SummaryWriter
			on: tf
			writingTo: 'summary-tests'
			appendingToName: '.v2'
			queueingUpTo: 10
			flushingEveryMilliseconds: 1.

	folder := FileSystemAPI current directoryNamed: './summary-tests'.
	[| files |
		{ 1. 2. 3. 5. 8. 13. 21 }
			doWithIndex: [:n :i | writer writeScalar: n atStep: i tagged: 'fibo'].

		files := folder fileEntries.
		self assert: files size equals: 1.
		self assert: files any stSize equals: 334]
			ensure: [folder deleteAll]
]
