Class {
	#name : 'NearestNeighbor',
	#superclass : 'Object',
	#instVars : [
		'plan'
	],
	#category : 'LibTensorFlowExamplesApp'
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
"The following source failed to compile (all double quotes have been doubled):
	|  graph output records session results values answer |
		
	graph := self decodeCSVGraphDefaults: description.
	records := (graph operationNamed: 'records') input: 0.
	output := graph operationNamed: 'output'.
	values := TF_Tensor fromStringArray: csvLines.
	
	session := TF_Session on: graph.
	results := session
		runOperations: {output}
		inputs: {records}
		values: {values}
		outputs: {
			(output output: 0).
			(output output: 1).
			(output output: 2).
			(output output: 3).
			(output output: 4)}.
		
	graph delete.
	
	answer := (1 to: 4) asOrderedCollection collect: [:i |
		(results at: i) allFloats].
	^ answer add: (results at: 5) allInt64s; yourself.
"

	^ self halt: 'The source for this method failed to compile'
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

	| covariatesTr covariatesTe predictions size dataset testing training |

	dataset := self loadDataSet.
	training := dataset first.
	testing := dataset second.
	covariatesTr := training allButLast asFloatTensor.
	size := testing first size.
	predictions :=
		(1 to: size) collect: [:i | | covariates index predicted results trueValue |
			covariates := testing collect: [:col | Array with: (col at: i)].
			covariatesTe := covariates allButLast asFloatTensor.
			results := plan predict: covariatesTe from: covariatesTr.
			index := results first.
			trueValue := covariates fifth first.
			predicted := training fifth at: index.
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
