Class {
	#name : 'CSVToTensorParser',
	#superclass : 'Object',
	#instVars : [
		'tf',
		'input',
		'parsing',
		'columnDefinitions',
		'shouldIgnoreHeaders'
	],
	#category : 'TFDatasetModel'
}

{ #category : 'Instance Creation' }
CSVToTensorParser class >> on: aTensorFlowComputation named: aParserName withColumnsDefinedBy: aColumnDefinitions [

	^self
		on: aTensorFlowComputation
		named: aParserName
		withColumnsDefinedBy: aColumnDefinitions
		configuredBy: CSVToTensorParserConfiguration default
]

{ #category : 'Instance Creation' }
CSVToTensorParser class >> on: aTensorFlowComputation named: aParserName withColumnsDefinedBy: aColumnDefinitions configuredBy: aParserConfiguration [

	^self new
		initializeOn: aTensorFlowComputation
		named: aParserName
		withColumnsDefinedBy: aColumnDefinitions
		configuredBy: aParserConfiguration
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
CSVToTensorParser >> columnIndexCollect: aBlock [

	^(1 to: columnDefinitions size) collect: aBlock
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
CSVToTensorParser >> initializeOn: aTensorflowComputation named: aName withColumnsDefinedBy: aColumnParserDefinitions configuredBy: aParserConfiguration [

	tf := aTensorflowComputation.
	columnDefinitions := aColumnParserDefinitions.
	input := InputNode on: tf named: ('input-<1s>' expandMacrosWith: aName) of: TFTensor typeString.
	shouldIgnoreHeaders := aParserConfiguration linesIncludesHeaders.
	parsing :=
		tf
			newOperationOf: 'DecodeCSV'
			namePrefixed: aName
			withAll: (Array with: input)
			describedBy: [:desc |
				desc addInputs: (columnDefinitions collect: [:column | column outputOn: tf]).
				aParserConfiguration applyTo: desc]
]

{ #category : 'Parsing' }
CSVToTensorParser >> parseColumnsFrom: aLineCollection [

	| output |

	output :=
		tf
			createSessionAndCompute: (self columnIndexCollect: [:i | parsing output: i - 1])
			feeding: (Array with: input value firstOutput)
			with: (Array with: (TFTensor fromStringArray: aLineCollection)).
	^self columnIndexCollect: [:i | output at: i]
]

{ #category : 'Parsing' }
CSVToTensorParser >> parseColumnsInFileNamed: aFileName [

	^self parseColumnsFrom: (
		aFileName asFileReference readStreamDo: [:stream |
			shouldIgnoreHeaders ifTrue: [stream nextLine].
			stream upToEnd lines])
]
