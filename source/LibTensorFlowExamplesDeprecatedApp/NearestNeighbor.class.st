Class {
	#name : 'NearestNeighbor',
	#superclass : 'Object',
	#instVars : [
		'plan'
	],
	#category : 'LibTensorFlowExamplesDeprecatedApp'
}

{ #category : 'Not categorized' }
NearestNeighbor class >> irisFile [
	^ '../Machine-Learning/datasets/iris.csv' asFileEntry readStream.
]

{ #category : 'instance creation' }
NearestNeighbor class >> new [
	^ super new initialize
]

{ #category : 'private-csv' }
NearestNeighbor >> decodeCSV: csvLines graphRun: description [

	| graph output records session results values answer |

	graph := self decodeCSVGraphDefaults: description.
	records := (graph operationNamed: 'records') input: 0.
	output := graph operationNamed: 'output'.
	values := TFTensor fromStringArray: csvLines.

	session := TFSession on: graph.
	results :=
		session
			runInputs: (Array with: records)
			values: (Array with: values)
			outputs: (
				OrderedCollection new
					add: (output output: 0);
					add: (output output: 1);
					add: (output output: 2);
					add: (output output: 3);
					add: (output output: 4);
					yourself).

	graph delete.

	answer := (1 to: 4) asOrderedCollection collect: [:i | (results at: i) allFloats].
	^answer
		add: (results at: 5) allInt64s;
		yourself
]

{ #category : 'private-csv' }
NearestNeighbor >> decodeCSVGraphDefaults: anArrayOfTFTensors [

	| graph records defaults |

	graph := TFGraph create.
	records := (graph placeholder: 'records' type: TFTensor typeString) firstOutput.
	defaults := Array new: anArrayOfTFTensors size.

	anArrayOfTFTensors withIndexDo: [:each :index | | one |
		one := (graph const: 'default' , index printString value: each) firstOutput.
		defaults at: index put: one].
	graph
		newOperation: 'DecodeCSV'
		named: 'output'
		described: [:description |
			description addInput: records.
			description addInputs: defaults].

	^graph
]

{ #category : 'initialization' }
NearestNeighbor >> initialize [
	plan := ExampleNearestNeighborPlan new.
]

{ #category : 'private-csv' }
NearestNeighbor >> irisDescription [

	^OrderedCollection new
		add: (TFTensor fromFloats: #(-1.0));
		add: (TFTensor fromFloats: #(-1.0));
		add: (TFTensor fromFloats: #(-1.0));
		add: (TFTensor fromFloats: #(-1.0));
		add: (TFTensor fromInt64s: #(-1));
		asArray
]

{ #category : 'private-csv' }
NearestNeighbor >> irisFile [
	^ self class irisFile
]

{ #category : 'initialization' }
NearestNeighbor >> loadDataSet [
	| dataSet description stream |
	stream := self irisFile.
	stream nextLine.
	dataSet := self testingAndTrainingFrom: stream.
	description := self irisDescription.
	^ dataSet collect: [ :csv |
		self
			decodeCSV: csv
			graphRun: description ].
]

{ #category : 'running' }
NearestNeighbor >> run [

	| trainingDataset covariatesTe predictions size dataset testingDatasetAndLabels trainingDatasetAndLabels |

	dataset := self loadDataSet.
	trainingDatasetAndLabels := dataset first.
	testingDatasetAndLabels := dataset second.
	trainingDataset := trainingDatasetAndLabels allButLast asFloatTensor.
	size := testingDatasetAndLabels first size.
	predictions :=
		(1 to: size) collect: [:i | | covariates index predicted results trueValue |
			covariates := testingDatasetAndLabels collect: [:col | Array with: (col at: i)].
			covariatesTe := covariates allButLast asFloatTensor.
			results := plan predict: covariatesTe from: trainingDataset.
			index := results first.
			trueValue := covariates fifth first.
			predicted := trainingDatasetAndLabels fifth at: index.
			trueValue = predicted ifTrue: [1] ifFalse: [0]].
	^predictions
]

{ #category : 'sampling' }
NearestNeighbor >> testingAndTrainingFrom: stream [

	| p random testing training lines |

	lines := stream upToEnd lines.
	p := 0.7.
	training := OrderedCollection new.
	testing := OrderedCollection new.
	random := EsRandom new.
	lines collect: [:line | | collection |
		line isEmpty
			ifFalse: [
				collection := random next < p ifTrue: [training] ifFalse: [testing].
				collection add: line]].
	^Array with: training with: testing
]
