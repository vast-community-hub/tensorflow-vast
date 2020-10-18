Class {
	#name : 'DatasetIterator',
	#superclass : 'Object',
	#instVars : [
		'tf',
		'iterator',
		'initializer',
		'next',
		'outputTypes',
		'outputShapes'
	],
	#category : 'TFDatasetModel'
}

{ #category : 'Instance Creation' }
DatasetIterator class >> on: aComputation iterating: aDataset knowingOutputIsTyped: aType withShape: aShape [

	^self
		on: aComputation
		iterating: aDataset
		knowingOutputsAreTyped: (Array with: aType)
		withShape: (Array with: aShape)
]

{ #category : 'Instance Creation' }
DatasetIterator class >> on: aComputation iterating: aDataset knowingOutputsAreTyped: aType withShape: aShape [

	^self new
		initializeOn: aComputation
		iterating: aDataset
		knowingOutputsAreTyped: aType
		withShape: aShape
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
DatasetIterator >> initializeOn: aComputation iterating: aDataset knowingOutputsAreTyped: aTypeCollection withShape: aShapeCollection [

	tf := aComputation.
	outputTypes := aDataset outputTypes.
	outputShapes := aDataset outputShapes.
	iterator :=
		tf
			newOperationOf: 'IteratorV2'
			namePrefixed: 'Iterator'
			withAll: #()
			describedBy: [:description |
				description
					at: TFAttributeName sharedName putString: 'shared-name';
					at: TFAttributeName container putString: 'container';
					at: TFAttributeName outputTypes putTypes: outputTypes;
					at: TFAttributeName outputShapes putShapes: outputShapes].

	initializer :=
		tf
			newOperationOf: 'MakeIterator'
			namePrefixed: 'MakeIterator'
			withAll: (Array with: aDataset with: iterator)
			describedBy: [:description | ].
	tf createSessionAndRun: initializer
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
						at: TFAttributeName outputTypes putTypes: outputTypes;
						at: TFAttributeName outputShapes putShapes: outputShapes]].

	^outputTypes size = 1
		ifTrue: [tf compute: next]
		ifFalse: [
			tf
				createSessionAndCompute:
					((1 to: outputTypes size) collect: [:i | next output: i - 1])
				feeding: Dictionary new
				with: Dictionary new]
]
