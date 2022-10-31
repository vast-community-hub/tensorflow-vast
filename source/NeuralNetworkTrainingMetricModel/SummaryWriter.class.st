Class {
	#name : 'SummaryWriter',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'currentComputation'
	],
	#category : 'NeuralNetworkTrainingMetricModel'
}

{ #category : 'Instance Creation',
  #vaVisibility : 'private' }
SummaryWriter class >> defaultFlushDelay [
	^30000
]

{ #category : 'Instance Creation',
  #vaVisibility : 'private' }
SummaryWriter class >> defaultMaximumQueueSize [
	^10
]

{ #category : 'Instance Creation' }
SummaryWriter class >> on: aTensorFlowComputation writingTo: aLogFolder [

	^self on: aTensorFlowComputation writingTo: aLogFolder appendingToName: ''
]

{ #category : 'Instance Creation' }
SummaryWriter class >> on: aTensorFlowComputation writingTo: aLogFolder appendingToName: aSuffix [

	^self
		on: aTensorFlowComputation
		writingTo: aLogFolder
		appendingToName: aSuffix
		queueingUpTo: self defaultMaximumQueueSize
		flushingEveryMilliseconds: self defaultFlushDelay
]

{ #category : 'Instance Creation' }
SummaryWriter class >> on: aTensorFlowComputation writingTo: aLogFolder appendingToName: aSuffix queueingUpTo: aMaximumQueueSize flushingEveryMilliseconds: aDurationInMilliseconds [

	^self new
		initializeOn: aTensorFlowComputation
		writingTo: aLogFolder
		appendingToName: aSuffix
		queueingUpTo: aMaximumQueueSize
		flushingEveryMilliseconds: aDurationInMilliseconds
]

{ #category : 'flushing' }
SummaryWriter >> flush [

	currentComputation createSessionAndRun:
		(currentComputation newOperationOf: 'FlushSummaryWriter' namePrefixed: 'Flusher' with: self)
]

{ #category : 'initialization',
  #vaVisibility : 'private' }
SummaryWriter >> initializeOn: aTensorFlowComputation writingTo: aLogFolder appendingToName: aSuffix queueingUpTo: aMaximumQueueSize flushingEveryMilliseconds: aDurationInMilliseconds [

	| creator |

	currentComputation := aTensorFlowComputation.
	value :=
		currentComputation
			newOperationOf: 'SummaryWriter'
			namePrefixed: 'SummaryWriter'
			withAll: #()
			describedBy: [:desc | desc atSharedNamePut: ('logdir:<1s>' expandMacrosWith: aLogFolder)].
	creator :=
		currentComputation
			newOperationOf: 'CreateSummaryFileWriter'
			namePrefixed: 'SummaryWriterCreator'
			withAll:
				{ self. (TFTensor fromStrings: aLogFolder). aMaximumQueueSize asInt32Tensor.
				aDurationInMilliseconds asInt32Tensor. (TFTensor fromStrings: aSuffix) }
			describedBy: [:desc | ].
	currentComputation createSessionAndRun: creator
]

{ #category : 'writing' }
SummaryWriter >> writeGraphSummaryAtStep: aNumber [
	
	currentComputation createSessionAndRun: (
		currentComputation
			newOperationOf: 'WriteGraphSummary'
			namePrefixed: 'WriteGraphSummary'
			withAll:
				{ self. aNumber asInt64Tensor. (TFTensor fromStrings: currentComputation graphDefinition ) }
			describedBy: [:desc | ])
]

{ #category : 'writing' }
SummaryWriter >> writeScalar: aNumber atStep: aStep tagged: aString [

	currentComputation createSessionAndRun: (
		currentComputation
			newOperationOf: 'WriteScalarSummary'
			namePrefixed: 'WriteScalarSummary'
			withAll:
				{ self. aStep asInt64Tensor. (TFTensor fromStrings: aString).
				(aNumber asFloatTensor) }
			describedBy: [:desc | ])
]
