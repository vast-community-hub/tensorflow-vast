Class {
	#name : 'DatasetTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFDatasetModelTests'
}

{ #category : 'Accessing' }
DatasetTest class >> isAbstract [

	^self name = #DatasetTest
]

{ #category : 'Tests',
  #vaVisibility : 'private' }
DatasetTest >> assertDatasetHasExpectedOutput: aDataset [

	| output |

	output := tf compute: aDataset.
	self assert: output type equals: VariantDataType new.
	self assert: output shape equals: TensorShape scalar.
	self assert: output numBytes equals: 64
]

{ #category : 'Tests',
  #vaVisibility : 'private' }
DatasetTest >> assertReachedEnd: iterator [

	self
		should: [tf compute: iterator next]
		raise: Error
		withDescription: 'OUT_OF_RANGE: End of sequence
	 [[{{node IteratorGetNext}}]]'
]

{ #category : 'Tests',
  #vaVisibility : 'private' }
DatasetTest >> datasetWithOneFloatMatrix [

	| input |

	input := tf floatConstantWith: #((0 1 2 3) (9 8 7 6)).

	^TensorDataset on: tf containing: input
]

{ #category : 'Tests',
  #vaVisibility : 'private' }
DatasetTest >> datasetWithOneFloatVector [

	| input |

	input := tf floatConstantWith: #(0 1 2 3).

	^TensorDataset on: tf containing: input
]

{ #category : 'Tests',
  #vaVisibility : 'private' }
DatasetTest >> iterateThrough: aDataset collecting: aCollectBlock thenDo: aDoBlock [

	| foundElements |

	foundElements := OrderedCollection new.
	aDataset do: [:each | foundElements add: (aCollectBlock value: each)].
	aDoBlock value: foundElements
]
