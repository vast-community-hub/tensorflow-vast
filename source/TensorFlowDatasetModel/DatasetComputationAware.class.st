Class {
	#name : 'DatasetComputationAware',
	#superclass : 'Object',
	#instVars : [
		'value',
		'cardinality'
	],
	#category : 'TensorFlowDatasetModel'
}

{ #category : 'Accessing' }
DatasetComputationAware >> cardinality [

	cardinality isNil
		ifTrue: [| op |
			op :=
				self currentComputation
					newOperationOf: 'DatasetCardinality'
					namePrefixed: 'cardinality'
					with: self.
			cardinality := (self currentComputation compute: op) scalarOutput].
	^cardinality
]

{ #category : 'Accessing' }
DatasetComputationAware >> currentComputation [

	self subclassResponsibility
]

{ #category : 'Enumerating' }
DatasetComputationAware >> do: aBlock [

	| iterator |

	iterator := self newIterator.
	1 to: self cardinality do: [:step | aBlock value: iterator next]
]

{ #category : 'Converting' }
DatasetComputationAware >> inBatchesOf: aBatchSize [

	^BatchDataset splitting: self in: aBatchSize
]

{ #category : 'Accessing' }
DatasetComputationAware >> isCardinalityUndefined [

	^self cardinality < 0
]

{ #category : 'Accessing' }
DatasetComputationAware >> newIterator [

	^DatasetIterator on: self currentComputation iterating: self
]

{ #category : 'Accessing' }
DatasetComputationAware >> outputDomains [

	self subclassResponsibility
]

{ #category : 'Accessing' }
DatasetComputationAware >> outputOn: aGraph [

	^self value outputOn: aGraph
]

{ #category : 'Converting' }
DatasetComputationAware >> prefetchingInBufferSized: aBufferSize [

	^PrefetchDataset prefetchingElementsIn: self onBufferSized: 2 withOutputsIn: self outputDomains
]

{ #category : 'Converting' }
DatasetComputationAware >> shuffled [

	^ShuffledDataset shuffling: self buffering: 1024 asInt64Tensor
]

{ #category : 'Converting' }
DatasetComputationAware >> shuffledWithSeed: anIntegerSeed [

	^ShuffledDataset
		shuffling: self
		buffering: 1024 asInt64Tensor
		withSeed: anIntegerSeed asInt64Tensor
]

{ #category : 'Accessing' }
DatasetComputationAware >> value [

	^value
]
