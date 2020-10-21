Class {
	#name : 'CSVDatasetTest',
	#superclass : 'DatasetTest',
	#category : 'TFDatasetModelTests'
}

{ #category : 'Tests',
  #vaVisibility : 'private' }
CSVDatasetTest >> datasetFromCSVNamed: fileName [

	^CSVDataset
		on: tf
		named: 'CSVDatasetV2'
		from: fileName
		withColumnsDefinedBy: (
			OrderedCollection new
				add: (CSVColumnDefinition nullableTyped: TFTensor typeInt32 defaultTo: -1);
				add: (CSVColumnDefinition mandatoryTyped: TFTensor typeFloat);
				add: (CSVColumnDefinition nullableTyped: TFTensor typeFloat defaultTo: -1);
				add: (CSVColumnDefinition nullableTyped: TFTensor typeInt32 defaultTo: -1);
				yourself)
		configuredBy: [:configuration |
			configuration
				bufferSized: 1024;
				fieldsDelimiter: ',';
				forNanUse: '-']
]

{ #category : 'Tests' }
CSVDatasetTest >> testCardinality [

	| fileName dataset |

	fileName := 'testCSVDataset.csv'.
	dataset := self datasetFromCSVNamed: fileName.

	[
		fileName asFileReference writeStreamDo: [:stream |
			stream
				nextPutAll: '1,2,3,4';
				cr;
				nextPutAll: ',0.5,6.3,1'].

		self assert: (tf compute: dataset cardinality) isLargeIntegerScalarEqualsTo: -2]
			ensure: [fileName asFileReference delete]
]

{ #category : 'Tests' }
CSVDatasetTest >> testCSVDataset [

	| fileName dataset |

	fileName := 'testCSVDataset.csv'.
	dataset := self datasetFromCSVNamed: fileName.

	[| next iterator |
		fileName asFileReference writeStreamDo: [:stream |
			stream
				nextPutAll: '1,2,3,4';
				cr;
				nextPutAll: ',0.5,6.3,1'].
		iterator := DatasetIterator on: tf iterating: dataset.
		
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
		self assertReachedEnd: iterator]
			ensure: [fileName asFileReference delete]
]
