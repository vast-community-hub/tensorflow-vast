Class {
	#name : 'CSVToTensorParserConfiguration',
	#superclass : 'Object',
	#instVars : [
		'delimiter',
		'notANumberValue',
		'linesIncludesHeaders'
	],
	#category : 'TensorFlowDatasetModel'
}

{ #category : 'Instance Creation' }
CSVToTensorParserConfiguration class >> default [

	^self delimitedBy: ','
]

{ #category : 'Instance Creation' }
CSVToTensorParserConfiguration class >> delimitedBy: aDelimiter [

	^self delimitedBy: aDelimiter consideringNan: ''
]

{ #category : 'Instance Creation' }
CSVToTensorParserConfiguration class >> delimitedBy: aDelimiter consideringNan: aNanValue [

	^self delimitedBy: aDelimiter consideringNan: aNanValue linesIncludesHeaders: false
]

{ #category : 'Instance Creation' }
CSVToTensorParserConfiguration class >> delimitedBy: aDelimiter consideringNan: aNanValue linesIncludesHeaders: aBoolean [

	^self new
		initializeDelimitedBy: aDelimiter
		consideringNan: aNanValue
		linesIncludesHeaders: aBoolean
]

{ #category : 'Instance Creation' }
CSVToTensorParserConfiguration class >> linesIncludesHeaders: aBoolean [

	^self delimitedBy: ',' consideringNan: '' linesIncludesHeaders: aBoolean
]

{ #category : 'Applying' }
CSVToTensorParserConfiguration >> applyTo: anOperationDescription [

	anOperationDescription
		atFieldDelimiterPut: delimiter;
		atNotAvailableValuePut: notANumberValue
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
CSVToTensorParserConfiguration >> initializeDelimitedBy: aDelimiter consideringNan: aNotANumberValue linesIncludesHeaders: aBoolean [

	delimiter := aDelimiter.
	notANumberValue := aNotANumberValue.
	linesIncludesHeaders := aBoolean
]

{ #category : 'Accessing' }
CSVToTensorParserConfiguration >> linesIncludesHeaders [

	^linesIncludesHeaders
]
