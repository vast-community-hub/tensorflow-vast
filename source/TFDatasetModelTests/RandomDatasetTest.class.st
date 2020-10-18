Class {
	#name : 'RandomDatasetTest',
	#superclass : 'DatasetTest',
	#category : 'TFDatasetModelTests'
}

{ #category : 'Tests',
  #vaVisibility : 'private' }
RandomDatasetTest >> datasetWithRandomFloatScalars [

	^RandomDataset
		on: tf
		withSeed: 0
		and: 1
		outputsTyped: (Array with: TFTensor typeFloat)
		shaped: (Array with: TensorShape scalar)
]

{ #category : 'Tests',
  #vaVisibility : 'private' }
RandomDatasetTest >> datasetWithRandomFloatVectors [

	^RandomDataset
		on: tf
		withSeed: 0
		and: 1
		outputsTyped: (Array with: TFTensor typeFloat)
		shaped: (Array with: (TensorShape vectorSized: 3))
]

{ #category : 'Tests',
  #vaVisibility : 'private' }
RandomDatasetTest >> datasetWithRandomIntegerScalars [

	^RandomDataset
		on: tf
		withSeed: 0
		and: 1
		outputsTyped: (Array with: TFTensor typeInt32)
		shaped: (Array with: TensorShape scalar)
]

{ #category : 'Tests' }
RandomDatasetTest >> testIterateThroughDatasetWithFloatScalars [

	| dataset iterator |

	dataset := self datasetWithRandomFloatScalars.

	self assertDatasetHasExpectedOutput: dataset.

	iterator :=
		DatasetIterator
			on: tf
			iterating: dataset
			knowingOutputIsTyped: TFTensor typeInt64
			withShape: TensorShape scalar.

	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 2219120097.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 4035800746.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 253345875.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 2214098416.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 3397187230.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 3653729773.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 2120669524.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 1835372352
]

{ #category : 'Tests' }
RandomDatasetTest >> testIterateThroughDatasetWithFloatVectors [

	| dataset iterator |

	dataset := self datasetWithRandomFloatVectors.

	self assertDatasetHasExpectedOutput: dataset.

	iterator :=
		DatasetIterator
			on: tf
			iterating: dataset
			knowingOutputIsTyped: TFTensor typeInt64
			withShape: TensorShape scalar.

	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 2219120097.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 4035800746.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 253345875.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 2214098416.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 3397187230.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 3653729773.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 2120669524.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 1835372352
]

{ #category : 'Tests' }
RandomDatasetTest >> testIterateThroughDatasetWithIntegerScalars [

	| dataset iterator |

	dataset := self datasetWithRandomIntegerScalars.

	self assertDatasetHasExpectedOutput: dataset.

	iterator :=
		DatasetIterator
			on: tf
			iterating: dataset
			knowingOutputIsTyped: TFTensor typeInt64
			withShape: TensorShape scalar.

	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 2219120097.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 4035800746.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 253345875.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 2214098416.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 3397187230.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 3653729773.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 2120669524.
	self assert: (tf compute: iterator next) isLargeIntegerScalarEqualsTo: 1835372352
]
