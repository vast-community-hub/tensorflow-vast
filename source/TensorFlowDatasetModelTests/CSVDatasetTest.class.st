Class {
	#name : 'CSVDatasetTest',
	#superclass : 'DatasetTest',
	#instVars : [
		'fileName',
		'dataset'
	],
	#category : 'TensorFlowDatasetModelTests'
}

{ #category : 'Tests',
  #vaVisibility : 'private' }
CSVDatasetTest >> datasetFromCSVNamed: aFileName [

	^CSVDataset
		on: tf
		named: 'My CSV Dataset'
		from: aFileName
		withColumnsDefinedBy: (
			OrderedCollection new
				add: (CSVColumnDefinition nullableTyped: Int32DataType new defaultTo: -1);
				add: (CSVColumnDefinition mandatoryTyped: FloatDataType new);
				add: (CSVColumnDefinition nullableTyped: FloatDataType new defaultTo: -1);
				add: (CSVColumnDefinition nullableTyped: Int32DataType new defaultTo: -1);
				yourself)
		configuredBy: [:configuration |
			configuration
				bufferSized: 1024;
				fieldsDelimiter: ',';
				forNanUse: '-']
]

{ #category : 'Tests',
  #vaVisibility : 'private' }
CSVDatasetTest >> setUp [

	super setUp.

	fileName := 'test-dataset.csv'
]

{ #category : 'Tests',
  #vaVisibility : 'private' }
CSVDatasetTest >> setUpCSVDatasetOnFile: aFileName [

	dataset :=
		CSVDataset
			on: tf
			named: 'My-CSV-Dataset'
			from: aFileName
			withColumnsDefinedBy: (
				OrderedCollection new
					add: (CSVColumnDefinition nullableTyped: Int32DataType new defaultTo: -1);
					add: (CSVColumnDefinition mandatoryTyped: FloatDataType new);
					add: (CSVColumnDefinition nullableTyped: FloatDataType new defaultTo: -1);
					add: (CSVColumnDefinition nullableTyped: Int32DataType new defaultTo: -1);
					yourself)
			configuredBy: [:configuration |
				configuration
					bufferSized: 1024;
					fieldsDelimiter: ',';
					forNanUse: '-'].

	fileName asFileReference writeStreamDo: [:stream |
		stream
			nextPutAll: '1,2,3,4';
			cr;
			nextPutAll: ',0.5,6.3,1']
]

{ #category : 'Tests',
  #vaVisibility : 'private' }
CSVDatasetTest >> setUpTSVDatasetOnFile: aFileName [

	dataset :=
		CSVDataset
			on: tf
			named: 'My-TSV-Dataset'
			from: aFileName
			withColumnsDefinedBy: (
				OrderedCollection new
					add: (CSVColumnDefinition nullableTyped: Int32DataType new defaultTo: -1);
					add: (CSVColumnDefinition mandatoryTyped: FloatDataType new);
					add: (CSVColumnDefinition nullableTyped: FloatDataType new defaultTo: -1);
					add: (CSVColumnDefinition nullableTyped: Int32DataType new defaultTo: -1);
					yourself)
			configuredBy: [:configuration |
				configuration
					bufferSized: 1024;
					fieldsDelimiter: '	';
					forNanUse: '-'].

	fileName asFileReference writeStreamDo: [:stream |
		stream
			nextPutAll: '1	2	3	4';
			cr;
			nextPutAll: '	0.5	6.3	1']
]

{ #category : 'Tests',
  #vaVisibility : 'private' }
CSVDatasetTest >> tearDown [
	
	super tearDown. 
	
	fileName asFileReference deleteIfAbsent: []
]

{ #category : 'Tests' }
CSVDatasetTest >> testCardinality [

	self setUpCSVDatasetOnFile: fileName.

	self assert: dataset isCardinalityUndefined
]

{ #category : 'Tests' }
CSVDatasetTest >> testCSVDataset [

	| next iterator |

	self setUpCSVDatasetOnFile: fileName.
	iterator := dataset newIterator.

	next := iterator next.
	self assert: (next at: 1) isIntegerScalarEqualTo: 1.
	self assert: (next at: 2) isFloatScalarCloseTo: 2.
	self assert: (next at: 3) isFloatScalarCloseTo: 3.
	self assert: (next at: 4) isIntegerScalarEqualTo: 4.

	next := iterator next.
	self assert: (next at: 1) isIntegerScalarEqualTo: -1.
	self assert: (next at: 2) isFloatScalarCloseTo: 0.5.
	self assert: (next at: 3) isFloatScalarCloseTo: 6.3.
	self assert: (next at: 4) isIntegerScalarEqualTo: 1.
	self assertReachedEnd: iterator
]

{ #category : 'Tests' }
CSVDatasetTest >> testCSVDatasetInBatchesOf1 [

	| next iterator |

	self setUpCSVDatasetOnFile: fileName.
	dataset := dataset inBatchesOf: 1.

	iterator := dataset newIterator.

	next := iterator next.
	self assert: (next at: 1) isIntegerVectorEqualsTo: #(1).
	self assert: (next at: 2) isFloatVectorCloseTo: #(2).
	self assert: (next at: 3) isFloatVectorCloseTo: #(3).
	self assert: (next at: 4) isIntegerVectorEqualsTo: #(4).

	next := iterator next.
	self assert: (next at: 1) isIntegerVectorEqualsTo: #(-1).
	self assert: (next at: 2) isFloatVectorCloseTo: #(0.5).
	self assert: (next at: 3) isFloatVectorCloseTo: #(6.3).
	self assert: (next at: 4) isIntegerVectorEqualsTo: #(1).
	self assertReachedEnd: iterator
]

{ #category : 'Tests' }
CSVDatasetTest >> testCSVDatasetInBatchesOf2 [

	| next iterator |

	self setUpCSVDatasetOnFile: fileName.
	dataset := dataset inBatchesOf: 2.

	iterator := dataset newIterator.

	next := iterator next.
	self assert: (next at: 1) isIntegerVectorEqualsTo: #(1 -1).
	self assert: (next at: 2) isFloatVectorCloseTo: #(2 0.5).
	self assert: (next at: 3) isFloatVectorCloseTo: #(3 6.3).
	self assert: (next at: 4) isIntegerVectorEqualsTo: #(4 1).

	self assertReachedEnd: iterator
]

{ #category : 'Tests' }
CSVDatasetTest >> testIterateUsingDo [

	self setUpCSVDatasetOnFile: fileName.

	self assert: dataset isCardinalityUndefined.
	self
		iterateThrough: dataset
		collecting: [:item | item]
		thenDo: [:foundElements | self assert: foundElements isEmpty]
]

{ #category : 'Tests' }
CSVDatasetTest >> testTSVDataset [

	| next iterator |

	self setUpTSVDatasetOnFile: fileName.
	iterator := dataset newIterator.

	next := iterator next.
	self assert: (next at: 1) isIntegerScalarEqualTo: 1.
	self assert: (next at: 2) isFloatScalarCloseTo: 2.
	self assert: (next at: 3) isFloatScalarCloseTo: 3.
	self assert: (next at: 4) isIntegerScalarEqualTo: 4.

	next := iterator next.
	self assert: (next at: 1) isIntegerScalarEqualTo: -1.
	self assert: (next at: 2) isFloatScalarCloseTo: 0.5.
	self assert: (next at: 3) isFloatScalarCloseTo: 6.3.
	self assert: (next at: 4) isIntegerScalarEqualTo: 1.
	self assertReachedEnd: iterator
]
