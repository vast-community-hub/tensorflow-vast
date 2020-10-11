Class {
	#name : 'SampleDatasetTest',
	#superclass : 'TestCase',
	#category : 'MLTrainingModelTests'
}

{ #category : 'Testing' }
SampleDatasetTest >> testBindTestingSet [

	| sample wasBinded |

	sample := SampleDataset new.

	sample bindTestingSetTo: #((1) (2) (3)) andLabelsTo: #(1 2 3).

	wasBinded := false.
	sample
		withTrainingDatasetDo: [:features :labels | self fail];
		withValidationDatasetDo: [:features :labels | self fail];
		withTestingDatasetDo: [:features :labels |
			wasBinded := true.
			self assert: features equals: #((1) (2) (3)).
			self assert: labels equals: #(1 2 3)].

	self assert: wasBinded
]

{ #category : 'Testing' }
SampleDatasetTest >> testBindTrainingSet [

	| sample wasBinded |

	sample := SampleDataset new.

	sample bindTrainingSetTo: #((1) (2) (3)) andLabelsTo: #(1 2 3).

	wasBinded := false.
	sample
		withTrainingDatasetDo: [:features :labels |
			wasBinded := true.
			self assert: features equals: #((1) (2) (3)).
			self assert: labels equals: #(1 2 3)];
		withValidationDatasetDo: [:features :labels | self fail];
		withTestingDatasetDo: [:features :labels | self fail].
		
	self assert: wasBinded
]

{ #category : 'Testing' }
SampleDatasetTest >> testBindValidationSet [

	| sample wasBinded |

	sample := SampleDataset new.

	sample bindValidationSetTo: #((1) (2) (3)) andLabelsTo: #(1 2 3).

	wasBinded := false.
	sample
		withTrainingDatasetDo: [:features :labels | self fail];
		withValidationDatasetDo: [:features :labels |
			wasBinded := true.
			self assert: features equals: #((1) (2) (3)).
			self assert: labels equals: #(1 2 3)];
		withTestingDatasetDo: [:features :labels | self fail].

	self assert: wasBinded
]

{ #category : 'Testing' }
SampleDatasetTest >> testIterateTrainingSetInBatches [

	| sample expectedFeaturesBatches expectedLabelsBatches batchIndex |

	sample := SampleDataset new.
	sample
		splittedInBatchesOf: 3;
		bindTrainingSetTo: #((1) (2) (3) (4)) andLabelsTo: #(1 2 3 4).

	expectedFeaturesBatches :=
		OrderedCollection new
			add: #((1) (2) (3));
			add: #((4));
			yourself.
	expectedLabelsBatches :=
		OrderedCollection new
			add: #(1 2 3);
			add: #(4);
			yourself.
	batchIndex := 0.
	sample withTrainingBatchesDo: [:features :labels |
		batchIndex := batchIndex + 1.
		self assert: features equals: (expectedFeaturesBatches at: batchIndex).
		self assert: labels equals: (expectedLabelsBatches at: batchIndex)].

	self assert: batchIndex equals: 2
]

{ #category : 'Testing' }
SampleDatasetTest >> testIterateTrainingSetInBatchesWhenNoSizeSpecified [

	| sample expectedFeaturesBatches expectedLabelsBatches batchIndex |

	sample := SampleDataset new.
	sample bindTrainingSetTo: #((1) (2) (3) (4)) andLabelsTo: #(1 2 3 4).

	expectedFeaturesBatches :=
		OrderedCollection new
			add: #((1) (2) (3) (4));
			yourself.
	expectedLabelsBatches :=
		OrderedCollection new
			add: #(1 2 3 4);
			yourself.
	batchIndex := 0.
	sample withTrainingBatchesDo: [:features :labels |
		batchIndex := batchIndex + 1.
		self assert: features equals: (expectedFeaturesBatches at: batchIndex).
		self assert: labels equals: (expectedLabelsBatches at: batchIndex)].

	self assert: batchIndex equals: 1
]
