Class {
	#name : 'TextDatasetTest',
	#superclass : 'DatasetTest',
	#instVars : [
		'fileName',
		'dataset'
	],
	#category : 'TFDatasetModelTests'
}

{ #category : 'Tests',
  #vaVisibility : 'private' }
TextDatasetTest >> setUp [

	super setUp. 
	
	fileName := 'test-dataset.csv'.

]

{ #category : 'Tests',
  #vaVisibility : 'private' }
TextDatasetTest >> setUpTextDatasetOnFile: aFileName [

	fileName asFileReference writeStreamDo: [:stream |
		stream
			nextPutAll: '1,2,3,4';
			cr;
			nextPutAll: 'you''ve got the wrong dude'].

	dataset := TextDataset on: tf readingFrom: fileName withBufferSized: 8 * 1024 * 1024.
]

{ #category : 'Tests',
  #vaVisibility : 'private' }
TextDatasetTest >> tearDown [

	super tearDown.

	fileName asFileReference delete
]

{ #category : 'Tests' }
TextDatasetTest >> testCardinality [

	self setUpTextDatasetOnFile: fileName.

	self assert: (tf compute: dataset cardinality) isLargeIntegerScalarEqualsTo: -2
]

{ #category : 'Tests' }
TextDatasetTest >> testIterateThroughDatasetWithOneFloatVector [

	| iterator |

	self setUpTextDatasetOnFile: fileName.
	self assertDatasetHasExpectedOutput: dataset.

	iterator := dataset newIterator.
	self assertOutputOf: iterator next isAStringEqualTo: '1,2,3,4'.
	self assertOutputOf: iterator next isAStringEqualTo: 'you''ve got the wrong dude'.
	self assertReachedEnd: iterator
]
