Class {
	#name : 'Dataset',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'cardinality'
	],
	#category : 'TFDatasetModel'
}

{ #category : 'Accessing' }
Dataset >> cardinality [

	cardinality isNil
		ifTrue: [
			cardinality :=
				self currentComputation
					newOperationOf: 'DatasetCardinality'
					namePrefixed: 'cardinality'
					with: self].
	^cardinality
]

{ #category : 'Accessing' }
Dataset >> inBatchesOf: aBatchSize [

	^BatchDataset splitting: self in: aBatchSize
]

{ #category : 'Accessing' }
Dataset >> newIterator [

	^DatasetIterator on: self currentComputation iterating: self
]

{ #category : 'Accessing' }
Dataset >> outputDomains [

	self subclassResponsibility
]

{ #category : 'Accessing' }
Dataset >> prefetchingInBufferSized: aBufferSize [

	^PrefetchDataset prefetchingElementsIn: self onBufferSized: 2 withOutputsIn: self outputDomains
]
