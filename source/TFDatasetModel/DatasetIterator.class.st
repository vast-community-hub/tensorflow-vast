Class {
	#name : 'DatasetIterator',
	#superclass : 'Object',
	#instVars : [
		'tf',
		'iterator',
		'initializer',
		'next',
		'outputDomains',
		'dataset'
	],
	#category : 'TFDatasetModel'
}

{ #category : 'Instance Creation' }
DatasetIterator class >> on: aComputation iterating: aDataset [

	^self new initializeOn: aComputation iterating: aDataset
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
DatasetIterator >> initializeIterator [

	initializer :=
		tf
			newOperationOf: 'MakeIterator'
			namePrefixed: 'MakeIterator'
			withAll: (Array with: dataset with: iterator)
			describedBy: [:description | ].
			
	self reset
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
DatasetIterator >> initializeOn: aComputation iterating: aDataset [

	tf := aComputation.
	dataset := aDataset.
	outputDomains := dataset outputDomains.
	iterator :=
		tf
			newOperationOf: 'IteratorV2'
			namePrefixed: 'Iterator'
			withAll: #()
			describedBy: [:description |
				description
					atSharedNamePut: 'shared-name';
					atContainerPut: 'container';
					atOutputTypesPut: (outputDomains collect: #type);
					atOutputShapesPut: (outputDomains collect: #shape)].
	self initializeIterator
]

{ #category : 'Accessing' }
DatasetIterator >> next [

	next ifNil: [
		next :=
			tf
				newOperationOf: 'IteratorGetNext'
				namePrefixed: 'IteratorGetNext'
				withAll: (Array with: iterator)
				describedBy: [:description |
					description
						atOutputTypesPut: (self outputDomains collect: #type);
						atOutputShapesPut: (self outputDomains collect: #shape)]].

	^self outputDomains size = 1
		ifTrue: [tf compute: next]
		ifFalse: [| outputPtr |
			outputPtr :=
				tf
					createSessionAndCompute:
						((1 to: self outputDomains size) collect: [:i | next output: i - 1])
					feeding: #()
					with: #().
			(1 to: self outputDomains size) collect: [:i | outputPtr at: i]]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
DatasetIterator >> outputDomains [

	^dataset outputDomains
]

{ #category : 'Initialization' }
DatasetIterator >> reset [

	tf createSessionAndRun: initializer
]
