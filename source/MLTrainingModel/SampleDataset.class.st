Class {
	#name : 'SampleDataset',
	#superclass : 'Object',
	#instVars : [
		'trainingSet',
		'trainingLabels',
		'validationSet',
		'validationLabels',
		'testingSet',
		'testingLabels',
		'batchSize'
	],
	#category : 'MLTrainingModel'
}

{ #category : 'Initialization' }
SampleDataset class >> new [

	^super new initialize
]

{ #category : 'Configuring' }
SampleDataset >> bindTestingSetTo: aTrainingSet andLabelsTo: aLabelsSet [

	testingSet := aTrainingSet.
	testingLabels := aLabelsSet
]

{ #category : 'Configuring' }
SampleDataset >> bindTrainingSetTo: aTrainingSet andLabelsTo: aLabelsSet [

	trainingSet := aTrainingSet.
	trainingLabels := aLabelsSet
]

{ #category : 'Configuring' }
SampleDataset >> bindValidationSetTo: aValidationSet andLabelsTo: aLabelsSet [

	validationSet := aValidationSet.
	validationLabels := aLabelsSet
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
SampleDataset >> initialize [

	trainingSet := nil.
	trainingLabels := nil.

	validationSet := nil.
	validationLabels := nil.

	testingSet := nil.
	testingLabels := nil. 
	
	self splittedInBatchesOf: 32
]

{ #category : 'Configuring' }
SampleDataset >> splittedInBatchesOf: anAmountOfInstances [
	
	batchSize := anAmountOfInstances
]

{ #category : 'Accessing' }
SampleDataset >> withTestingDatasetDo: aBlock [

	testingSet isNil ifFalse: [aBlock value: testingSet value: testingLabels]
]

{ #category : 'Accessing' }
SampleDataset >> withTrainingBatchesDo: aBlock [

	self withTrainingDatasetDo: [:features :labels |
		(1 to: features size by: batchSize) do: [:index | | upperBound |
			upperBound := (index + batchSize - 1) min: features size.
			aBlock
				value: (features copyFrom: index to: upperBound)
				value: (labels copyFrom: index to: upperBound)]]
]

{ #category : 'Accessing' }
SampleDataset >> withTrainingDatasetDo: aBlock [

	trainingSet isNil ifFalse: [aBlock value: trainingSet value: trainingLabels]
]

{ #category : 'Accessing' }
SampleDataset >> withValidationDatasetDo: aTwoArgBlock [

	validationSet isNil ifFalse: [aTwoArgBlock value: validationSet value: validationLabels]
]
