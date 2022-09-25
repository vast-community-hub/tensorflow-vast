Class {
	#name : 'CSVDataset',
	#superclass : 'DatasetComputationAware',
	#instVars : [
		'currentComputation',
		'outputDomains'
	],
	#category : 'TensorFlowDatasetModel'
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

{ #category : 'Accessing' }
CSVDataset >> currentComputation [

	^currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
CSVDataset >> initializeOn: aTensorFlowComputation named: aDatasetName from: aFilename withColumnsDefinedBy: aColumnDefinitionCollection using: aParsingConfiguration [

	outputDomains := aColumnDefinitionCollection collect: #columnDomain.
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
					atOutputTypesPut: (outputDomains collect: #type);
					atOutputShapesPut: (outputDomains collect: #shape)]
]

{ #category : 'Accessing' }
CSVDataset >> outputDomains [

	^outputDomains
]
