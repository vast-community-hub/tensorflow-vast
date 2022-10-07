Class {
	#name : 'SampleDatasetTest',
	#superclass : 'TestCase',
	#category : 'NeuralNetworkTrainingDatasetModelTests'
}

{ #category : 'Testing' }
SampleDatasetTest >> testBindTestingSet [

	| sample wasBinded |

	sample := SampleDataset new.

	sample bindTestingSetTo: #((1) (2) (3)) withLabels: #(1 2 3).

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

	sample bindTrainingSetTo: #((1) (2) (3)) withLabels: #(1 2 3).

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

	sample bindValidationSetTo: #((1) (2) (3)) withLabels: #(1 2 3).

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
