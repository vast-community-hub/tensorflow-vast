Class {
	#name : 'SampleDataset',
	#superclass : 'Object',
	#instVars : [
		'trainingSet',
		'trainingLabels',
		'validationSet',
		'validationLabels',
		'testingSet',
		'testingLabels'
	],
	#category : 'MLTrainingModel'
}

{ #category : 'Initialization' }
SampleDataset class >> new [

	^super new initialize
]

{ #category : 'Configuring' }
SampleDataset >> bindTestingSetTo: aTrainingSet withLabels: aLabelsSet [

	testingSet := aTrainingSet.
	testingLabels := aLabelsSet
]

{ #category : 'Configuring' }
SampleDataset >> bindTrainingSetTo: aTrainingSet withLabels: aLabelsSet [

	trainingSet := aTrainingSet.
	trainingLabels := aLabelsSet
]

{ #category : 'Configuring' }
SampleDataset >> bindValidationSetTo: aValidationSet withLabels: aLabelsSet [

	validationSet := aValidationSet.
	validationLabels := aLabelsSet
]

{ #category : 'Testing' }
SampleDataset >> hasTrainingSetConfigured [

	^trainingSet isNil not
]

{ #category : 'Testing' }
SampleDataset >> hasValidationSetConfigured [

	^validationSet isNil not
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
SampleDataset >> initialize [

	trainingSet := nil.
	trainingLabels := nil.

	validationSet := nil.
	validationLabels := nil.

	testingSet := nil.
	testingLabels := nil
]

{ #category : 'Accessing' }
SampleDataset >> withTestingDatasetDo: aBlock [

	testingSet isNil ifFalse: [aBlock value: testingSet value: testingLabels]
]

{ #category : 'Accessing' }
SampleDataset >> withTrainingDatasetDo: aBlock [

	trainingSet isNil ifFalse: [aBlock value: trainingSet value: trainingLabels]
]

{ #category : 'Accessing' }
SampleDataset >> withValidationDatasetDo: aTwoArgBlock [

	validationSet isNil ifFalse: [aTwoArgBlock value: validationSet value: validationLabels]
]
