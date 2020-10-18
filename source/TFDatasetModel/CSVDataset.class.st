Class {
	#name : 'CSVDataset',
	#superclass : 'Dataset',
	#instVars : [
		'currentComputation',
		'outputTypes',
		'outputShapes'
	],
	#category : 'TFDatasetModel'
}

{ #category : 'Instance Creation' }
CSVDataset class >> on: aTensorFlowComputation named: aParserName from: aFileName withColumnsDefinedBy: aColumnDefinitions configuredBy: aConfigurationBlock [

	| builder |

	builder := CSVDatasetConfigurationBuilder new.
	aConfigurationBlock value: builder.
	^self
		on: aTensorFlowComputation
		named: aParserName
		from: aFileName
		withColumnsDefinedBy: aColumnDefinitions
		using: builder build
]

{ #category : 'Instance Creation',
  #vaVisibility : 'private' }
CSVDataset class >> on: aTensorFlowComputation named: aDatasetName from: aFileName withColumnsDefinedBy: aColumnDefinitionCollection using: aParsingConfiguration [

	^self new
		initializeOn: aTensorFlowComputation
		named: aDatasetName
		from: aFileName
		withColumnsDefinedBy: aColumnDefinitionCollection
		using: aParsingConfiguration
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
CSVDataset >> initializeOn: aTensorFlowComputation named: aDatasetName from: aFilename withColumnsDefinedBy: aColumnDefinitionCollection using: aParsingConfiguration [

	outputTypes := aColumnDefinitionCollection collect: #columnDataType.
	outputShapes := Array new: aColumnDefinitionCollection size withAll: TensorShape scalar.
	currentComputation := aTensorFlowComputation.
	value :=
		currentComputation
			newOperationOf: 'CSVDataset'
			namePrefixed: aDatasetName
			withAll: (
				OrderedCollection new
					add: (TFTensor fromStrings: (Array with: aFilename) shape: TensorShape scalar);
					addAll: aParsingConfiguration;
					yourself)
			describedBy: [:description |
				description
					addInputs: (
						aColumnDefinitionCollection
							collect: [:column | column outputOn: currentComputation]);
					at: TFAttributeName outputTypes putTypes: outputTypes;
					at: TFAttributeName outputShapes putShapes: outputShapes]
]

{ #category : 'Accessing' }
CSVDataset >> outputShapes [

	^outputShapes
]

{ #category : 'Accessing' }
CSVDataset >> outputTypes [

	^outputTypes
]
