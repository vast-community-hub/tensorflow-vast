Class {
	#name : 'CSVDatasetConfigurationBuilder',
	#superclass : 'Object',
	#instVars : [
		'compressionType',
		'header',
		'select_cols',
		'fieldDelimiter',
		'useQuoteDelimiter',
		'nanValue',
		'bufferSize'
	],
	#category : 'TFDatasetModel'
}

{ #category : 'Instance Creation' }
CSVDatasetConfigurationBuilder class >> new [

	^super new initialize
]

{ #category : 'Configuring' }
CSVDatasetConfigurationBuilder >> bufferSized: aBufferSize [

	bufferSize := aBufferSize asInt64Tensor
]

{ #category : 'Building' }
CSVDatasetConfigurationBuilder >> build [

	^OrderedCollection new
		add: compressionType;
		add: bufferSize;
		add: header;
		add: fieldDelimiter;
		add: useQuoteDelimiter;
		add: nanValue;
		add: select_cols;
		asArray
]

{ #category : 'Configuring' }
CSVDatasetConfigurationBuilder >> dontUseQuoteDelimiter [

	useQuoteDelimiter := false
]

{ #category : 'Configuring' }
CSVDatasetConfigurationBuilder >> fieldsDelimiter: aStringDelimiter [

	fieldDelimiter := self stringTensorContaining: aStringDelimiter
]

{ #category : 'Configuring' }
CSVDatasetConfigurationBuilder >> fileCompressedUsing: aCompressionType [

	compressionType := self stringTensorContaining: aCompressionType
]

{ #category : 'Configuring' }
CSVDatasetConfigurationBuilder >> fileHasHeader [

	header := true
]

{ #category : 'Configuring' }
CSVDatasetConfigurationBuilder >> forNanUse: aString [

	nanValue := self stringTensorContaining: aString
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
CSVDatasetConfigurationBuilder >> initialize [

	header := false asTensor.
	useQuoteDelimiter := true asTensor.
	select_cols := #() asInt64Tensor.

	self bufferSized: 0.
	self fileCompressedUsing: ''.
	self fieldsDelimiter: ','.
	self forNanUse: '-'
]

{ #category : 'Configuring',
  #vaVisibility : 'private' }
CSVDatasetConfigurationBuilder >> stringTensorContaining: aCompressionType [

	^TFTensor fromStrings: (Array with: aCompressionType) shape: TensorShape scalar
]
