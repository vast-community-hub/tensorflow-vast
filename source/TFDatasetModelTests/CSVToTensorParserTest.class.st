Class {
	#name : 'CSVToTensorParserTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFDatasetModelTests'
}

{ #category : 'Tests' }
CSVToTensorParserTest >> testCustomNanValue [

	| lines tensor columnTypes columns |

	lines :=
		OrderedCollection new
			add: '1;2;3;4';
			add: '-;0.5;6.3;1';
			yourself.

	columnTypes :=
		OrderedCollection new
			add: (CSVColumnDefinition nullableTyped: Int32DataType new defaultTo: -1);
			add: (CSVColumnDefinition mandatoryTyped: FloatDataType new);
			add: (CSVColumnDefinition mandatoryTyped: FloatDataType new);
			add: (CSVColumnDefinition mandatoryTyped: Int32DataType new);
			yourself.

	tensor :=
		CSVToTensorParser
			on: tf
			named: 'test-parser'
			withColumnsDefinedBy: columnTypes
			configuredBy: (CSVToTensorParserConfiguration delimitedBy: ';' consideringNan: '-').

	columns := tensor parseColumnsFrom: lines.

	self assert: (columns at: 1) isVectorTyped: Int32DataType new closeTo: #(1 -1).
	self assert: (columns at: 2) isVectorTyped: FloatDataType new closeTo: #(2 0.5).
	self assert: (columns at: 3) isVectorTyped: FloatDataType new closeTo: #(3 6.3).
	self assert: (columns at: 4) isVectorTyped: Int32DataType new closeTo: #(4 1)
]

{ #category : 'Tests' }
CSVToTensorParserTest >> testMissingMandatoryField [

	| lines tensor columnTypes |

	lines :=
		OrderedCollection new
			add: '1,2,3,4';
			add: ',0.5,6.3,1';
			yourself.

	columnTypes :=
		OrderedCollection new
			add: (CSVColumnDefinition mandatoryTyped: Int32DataType new);
			add: (CSVColumnDefinition nullableTyped: FloatDataType new defaultTo: -1);
			add: (CSVColumnDefinition nullableTyped: FloatDataType new defaultTo: -1);
			add: (CSVColumnDefinition nullableTyped: Int32DataType new defaultTo: -1);
			yourself.

	tensor := CSVToTensorParser on: tf named: 'test-parser' withColumnsDefinedBy: columnTypes.

	self
		assert: [tensor parseColumnsFrom: lines]
		raisesExceptionWith:
			'INVALID_ARGUMENT: Field 0 is required but missing in record 1!
	 [[{{node test-parser}}]]'
]

{ #category : 'Tests' }
CSVToTensorParserTest >> testParseFile [

	| fileName tensor columnTypes columns |

	fileName := 'testParseFile.csv'.
	[
		fileName asFileReference writeStreamDo: [:stream |
			stream
				nextPutAll: '1,2,3,4';
				cr;
				nextPutAll: ',0.5,6.3,1'].

		columnTypes :=
			OrderedCollection new
				add: (CSVColumnDefinition nullableTyped: Int32DataType new defaultTo: -1);
				add: (CSVColumnDefinition mandatoryTyped: FloatDataType new);
				add: (CSVColumnDefinition nullableTyped: FloatDataType new defaultTo: -1);
				add: (CSVColumnDefinition nullableTyped: Int32DataType new defaultTo: -1);
				yourself.

		tensor := CSVToTensorParser on: tf named: 'test-parser' withColumnsDefinedBy: columnTypes.

		columns := tensor parseColumnsInFileNamed: fileName.

		self assert: (columns at: 1) isVectorTyped: Int32DataType new closeTo: #(1 -1).
		self assert: (columns at: 2) isVectorTyped: FloatDataType new closeTo: #(2 0.5).
		self assert: (columns at: 3) isVectorTyped: FloatDataType new closeTo: #(3 6.3).
		self assert: (columns at: 4) isVectorTyped: Int32DataType new closeTo: #(4 1)]
			ensure: [fileName asFileReference delete]
]

{ #category : 'Tests' }
CSVToTensorParserTest >> testParseFileIgnoringHeader [

	| fileName tensor columnTypes columns |

	fileName := 'testParseFile.csv'.
	[
		fileName asFileReference writeStreamDo: [:stream |
			stream
				nextPutAll: 'a1,a2,a3,a4';
				cr;
				nextPutAll: '1,2,3,4';
				cr;
				nextPutAll: ',0.5,6.3,1'].

		columnTypes :=
			OrderedCollection new
				add: (CSVColumnDefinition nullableTyped: Int32DataType new defaultTo: -1);
				add: (CSVColumnDefinition mandatoryTyped: FloatDataType new);
				add: (CSVColumnDefinition nullableTyped: FloatDataType new defaultTo: -1);
				add: (CSVColumnDefinition nullableTyped: Int32DataType new defaultTo: -1);
				yourself.

		tensor :=
			CSVToTensorParser
				on: tf
				named: 'test-parser'
				withColumnsDefinedBy: columnTypes
				configuredBy: (CSVToTensorParserConfiguration linesIncludesHeaders: true).

		columns := tensor parseColumnsInFileNamed: fileName.

		self assert: (columns at: 1) isVectorTyped: Int32DataType new closeTo: #(1 -1).
		self assert: (columns at: 2) isVectorTyped: FloatDataType new closeTo: #(2 0.5).
		self assert: (columns at: 3) isVectorTyped: FloatDataType new closeTo: #(3 6.3).
		self assert: (columns at: 4) isVectorTyped: Int32DataType new closeTo: #(4 1)]
			ensure: [fileName asFileReference delete]
]

{ #category : 'Tests' }
CSVToTensorParserTest >> testParseSemicolonSeparatedValues [

	| lines tensor columnTypes columns |

	lines :=
		OrderedCollection new
			add: '1;2;3;4';
			add: ';0.5;6.3;1';
			yourself.

	columnTypes :=
		OrderedCollection new
			add: (CSVColumnDefinition nullableTyped: Int32DataType new defaultTo: -1);
			add: (CSVColumnDefinition mandatoryTyped: FloatDataType new);
			add: (CSVColumnDefinition nullableTyped: FloatDataType new defaultTo: -1);
			add: (CSVColumnDefinition nullableTyped: Int32DataType new defaultTo: -1);
			yourself.

	tensor :=
		CSVToTensorParser
			on: tf
			named: 'test-parser'
			withColumnsDefinedBy: columnTypes
			configuredBy: (CSVToTensorParserConfiguration delimitedBy: ';').

	columns := tensor parseColumnsFrom: lines.

	self assert: (columns at: 1) isVectorTyped: Int32DataType new closeTo: #(1 -1).
	self assert: (columns at: 2) isVectorTyped: FloatDataType new closeTo: #(2 0.5).
	self assert: (columns at: 3) isVectorTyped: FloatDataType new closeTo: #(3 6.3).
	self assert: (columns at: 4) isVectorTyped: Int32DataType new closeTo: #(4 1)
]

{ #category : 'Tests' }
CSVToTensorParserTest >> testWithNullableFields [

	| lines tensor columnTypes columns |

	lines :=
		OrderedCollection new
			add: '1,2,3,4';
			add: ',0.5,6.3,1';
			yourself.

	columnTypes :=
		OrderedCollection new
			add: (CSVColumnDefinition nullableTyped: Int32DataType new defaultTo: -1);
			add: (CSVColumnDefinition mandatoryTyped: FloatDataType new);
			add: (CSVColumnDefinition nullableTyped: FloatDataType new defaultTo: -1);
			add: (CSVColumnDefinition nullableTyped: Int32DataType new defaultTo: -1);
			yourself.

	tensor := CSVToTensorParser on: tf named: 'test-parser' withColumnsDefinedBy: columnTypes.

	columns := tensor parseColumnsFrom: lines.

	self assert: (columns at: 1) isVectorTyped: Int32DataType new closeTo: #(1 -1).
	self assert: (columns at: 2) isVectorTyped: FloatDataType new closeTo: #(2 0.5).
	self assert: (columns at: 3) isVectorTyped: FloatDataType new closeTo: #(3 6.3).
	self assert: (columns at: 4) isVectorTyped: Int32DataType new closeTo: #(4 1)
]
