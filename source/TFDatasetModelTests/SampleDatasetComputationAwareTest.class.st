Class {
	#name : 'SampleDatasetComputationAwareTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFDatasetModelTests'
}

{ #category : 'Tests' }
SampleDatasetComputationAwareTest >> testAccessingUnbindedTrainingSet [

	| adapter featuresCollected labelsCollected |

	adapter := SampleDatasetComputationAware on: tf.

	featuresCollected := OrderedCollection new.
	labelsCollected := OrderedCollection new.

	adapter withTrainingDatasetDo: [:features :label |
		featuresCollected add: features.
		labelsCollected add: label].

	self assert: featuresCollected isEmpty.
	self assert: labelsCollected isEmpty
]

{ #category : 'Tests' }
SampleDatasetComputationAwareTest >> testAccessingUnbindedValidationSet [

	| adapter featuresCollected labelsCollected |

	adapter := SampleDatasetComputationAware on: tf.

	featuresCollected := OrderedCollection new.
	labelsCollected := OrderedCollection new.

	adapter withValidationDatasetDo: [:features :label |
		featuresCollected add: features.
		labelsCollected add: label].

	self assert: featuresCollected isEmpty.
	self assert: labelsCollected isEmpty
]

{ #category : 'Tests' }
SampleDatasetComputationAwareTest >> testApplyingTransformationToWholeDataset [

	| adapter featuresCollected labelsCollected |

	adapter :=
		SampleDatasetComputationAware
			on: tf
			transformingFeaturesWith: [:features | features reshapeFlattened raisedTo: 3.0]
			transformingLabelsWith: [:labels | labels * 2]
			applying: [:dataset | dataset inBatchesOf: 2].

	adapter
		bindTrainingFeaturesTo: #(((1 1) (1 1)) ((2 2) (2 2)) ((3 3) (3 3))) asFloatTensor
		withLabels: #(1 2 3) asInt32Tensor.

	featuresCollected := OrderedCollection new.
	labelsCollected := OrderedCollection new.

	adapter withTrainingDatasetDo: [:features :label |
		featuresCollected add: features.
		labelsCollected add: label].

	self assert: featuresCollected size equals: 2.
	self assert: labelsCollected size equals: 2.

	self assert: (featuresCollected at: 1) isMatrixCloseTo: #((1 1 1 1) (8 8 8 8)).
	self assert: (labelsCollected at: 1) isIntegerVectorEqualsTo: #(2 4).
	self assert: (featuresCollected at: 2) isMatrixCloseTo: #((27 27 27 27)).
	self assert: (labelsCollected at: 2) isIntegerVectorEqualsTo: #(6)
]

{ #category : 'Tests' }
SampleDatasetComputationAwareTest >> testBindFromSampleDataset [

	| set adapter featuresCollected labelsCollected |

	set :=
		SampleDataset new
			bindTrainingSetTo: #(((1 1) (1 1)) ((2 2) (2 2)) ((3 3) (3 3))) asFloatTensor
				withLabels: #(1 2 3) asInt32Tensor;
			bindValidationSetTo: #(((4 4) (4 4)) ((5 5) (5 5)) ((6 6) (6 6))) asFloatTensor
				withLabels: #(4 5 6) asInt32Tensor;
			yourself.

	adapter :=
		SampleDatasetComputationAware
			on: tf
			transformingFeaturesWith: [:features | features reshapeFlattened raisedTo: 3.0]
			transformingLabelsWith: [:labels | labels * 2]
			applying: [:dataset | dataset inBatchesOf: 2].
	adapter bindSetsFrom: set.

	featuresCollected := OrderedCollection new.
	labelsCollected := OrderedCollection new.
	adapter withTrainingDatasetDo: [:features :label |
		featuresCollected add: features.
		labelsCollected add: label].

	self assert: featuresCollected size equals: 2.
	self assert: labelsCollected size equals: 2.

	self assert: (featuresCollected at: 1) isMatrixCloseTo: #((1 1 1 1) (8 8 8 8)).
	self assert: (labelsCollected at: 1) isIntegerVectorEqualsTo: #(2 4).
	self assert: (featuresCollected at: 2) isMatrixCloseTo: #((27 27 27 27)).
	self assert: (labelsCollected at: 2) isIntegerVectorEqualsTo: #(6).

	featuresCollected := OrderedCollection new.
	labelsCollected := OrderedCollection new.
	adapter withValidationDatasetDo: [:features :label |
		featuresCollected add: features.
		labelsCollected add: label].

	self assert: featuresCollected size equals: 2.
	self assert: labelsCollected size equals: 2.

	self assert: (featuresCollected at: 1) isMatrixCloseTo: #((64 64 64 64) (125 125 125 125)).
	self assert: (labelsCollected at: 1) isIntegerVectorEqualsTo: #(8 10).
	self assert: (featuresCollected at: 2) isMatrixCloseTo: #((216 216 216 216)).
	self assert: (labelsCollected at: 2) isIntegerVectorEqualsTo: #(12)
]

{ #category : 'Tests' }
SampleDatasetComputationAwareTest >> testBindTrainingSet [

	| adapter featuresCollected labelsCollected |

	adapter := SampleDatasetComputationAware on: tf.

	adapter
		bindTrainingFeaturesTo: #((1 1 1 1) (2 2 2 2) (3 3 3 3)) asFloatTensor
		withLabels: #(1 2 3) asInt32Tensor.

	featuresCollected := OrderedCollection new.
	labelsCollected := OrderedCollection new.

	adapter
		withTrainingDatasetDo: [:features :label |
			featuresCollected add: features.
			labelsCollected add: label];
		withValidationDatasetDo: [:features :label | self fail].

	self assert: featuresCollected size equals: 3.
	self assert: labelsCollected size equals: 3.

	self assert: (featuresCollected at: 1) isFloatVectorCloseTo: #(1 1 1 1).
	self assert: (labelsCollected at: 1) isIntegerScalarEqualTo: 1.
	self assert: (featuresCollected at: 2) isFloatVectorCloseTo: #(2 2 2 2).
	self assert: (labelsCollected at: 2) isIntegerScalarEqualTo: 2.
	self assert: (featuresCollected at: 3) isFloatVectorCloseTo: #(3 3 3 3).
	self assert: (labelsCollected at: 3) isIntegerScalarEqualTo: 3
]

{ #category : 'Tests' }
SampleDatasetComputationAwareTest >> testBindValidationSet [

	| adapter featuresCollected labelsCollected |

	adapter := SampleDatasetComputationAware on: tf.

	adapter
		bindValidationFeaturesTo: #((1 1 1 1) (2 2 2 2) (3 3 3 3)) asFloatTensor
		withLabels: #(1 2 3) asInt32Tensor.

	featuresCollected := OrderedCollection new.
	labelsCollected := OrderedCollection new.

	adapter
		withTrainingDatasetDo: [:features :label | self fail];
		withValidationDatasetDo: [:features :label |
			featuresCollected add: features.
			labelsCollected add: label].

	self assert: featuresCollected size equals: 3.
	self assert: labelsCollected size equals: 3.

	self assert: (featuresCollected at: 1) isFloatVectorCloseTo: #(1 1 1 1).
	self assert: (labelsCollected at: 1) isIntegerScalarEqualTo: 1.
	self assert: (featuresCollected at: 2) isFloatVectorCloseTo: #(2 2 2 2).
	self assert: (labelsCollected at: 2) isIntegerScalarEqualTo: 2.
	self assert: (featuresCollected at: 3) isFloatVectorCloseTo: #(3 3 3 3).
	self assert: (labelsCollected at: 3) isIntegerScalarEqualTo: 3
]

{ #category : 'Tests' }
SampleDatasetComputationAwareTest >> testTransformationsAppliesToValidationSet [

	| adapter featuresCollected labelsCollected |

	adapter :=
		SampleDatasetComputationAware
			on: tf
			transformingFeaturesWith: [:features | features reshapeFlattened raisedTo: 3.0]
			transformingLabelsWith: [:labels | labels * 2]
			applying: [:dataset | dataset inBatchesOf: 2].

	adapter
		bindValidationFeaturesTo:
			#(((1 1) (1 1)) ((2 2) (2 2)) ((3 3) (3 3))) asFloatTensor
		withLabels: #(1 2 3) asInt32Tensor.

	featuresCollected := OrderedCollection new.
	labelsCollected := OrderedCollection new.

	adapter withValidationDatasetDo: [:features :label |
		featuresCollected add: features.
		labelsCollected add: label].

	self assert: featuresCollected size equals: 2.
	self assert: labelsCollected size equals: 2.

	self assert: (featuresCollected at: 1) isMatrixCloseTo: #((1 1 1 1) (8 8 8 8)).
	self assert: (labelsCollected at: 1) isIntegerVectorEqualsTo: #(2 4).
	self assert: (featuresCollected at: 2) isMatrixCloseTo: #((27 27 27 27)).
	self assert: (labelsCollected at: 2) isIntegerVectorEqualsTo: #(6)
]

{ #category : 'Tests' }
SampleDatasetComputationAwareTest >> testTransformingFeatures [

	| adapter featuresCollected labelsCollected |

	adapter :=
		SampleDatasetComputationAware
			on: tf
			transformingFeaturesWith: [:features | features reshapeFlattened].

	adapter
		bindTrainingFeaturesTo: #(((1 1) (1 1)) ((2 2) (2 2)) ((3 3) (3 3))) asFloatTensor
		withLabels: #(1 2 3) asInt32Tensor.

	featuresCollected := OrderedCollection new.
	labelsCollected := OrderedCollection new.

	adapter withTrainingDatasetDo: [:features :label |
		featuresCollected add: features.
		labelsCollected add: label].

	self assert: featuresCollected size equals: 3.
	self assert: labelsCollected size equals: 3.

	self assert: (featuresCollected at: 1) isFloatVectorCloseTo: #(1 1 1 1).
	self assert: (labelsCollected at: 1) isIntegerScalarEqualTo: 1.
	self assert: (featuresCollected at: 2) isFloatVectorCloseTo: #(2 2 2 2).
	self assert: (labelsCollected at: 2) isIntegerScalarEqualTo: 2.
	self assert: (featuresCollected at: 3) isFloatVectorCloseTo: #(3 3 3 3).
	self assert: (labelsCollected at: 3) isIntegerScalarEqualTo: 3
]

{ #category : 'Tests' }
SampleDatasetComputationAwareTest >> testTransformingFeaturesAndLabels [

	| adapter featuresCollected labelsCollected |

	adapter :=
		SampleDatasetComputationAware
			on: tf
			transformingFeaturesWith: [:features | features reshapeFlattened raisedTo: 3.0]
			transformingLabelsWith: [:labels | labels * 2].

	adapter
		bindTrainingFeaturesTo: #(((1 1) (1 1)) ((2 2) (2 2)) ((3 3) (3 3))) asFloatTensor
		withLabels: #(1 2 3) asInt32Tensor.

	featuresCollected := OrderedCollection new.
	labelsCollected := OrderedCollection new.

	adapter withTrainingDatasetDo: [:features :label |
		featuresCollected add: features.
		labelsCollected add: label].

	self assert: featuresCollected size equals: 3.
	self assert: labelsCollected size equals: 3.

	self assert: (featuresCollected at: 1) isFloatVectorCloseTo: #(1 1 1 1).
	self assert: (labelsCollected at: 1) isIntegerScalarEqualTo: 2.
	self assert: (featuresCollected at: 2) isFloatVectorCloseTo: #(8 8 8 8).
	self assert: (labelsCollected at: 2) isIntegerScalarEqualTo: 4.
	self assert: (featuresCollected at: 3) isFloatVectorCloseTo: #(27 27 27 27).
	self assert: (labelsCollected at: 3) isIntegerScalarEqualTo: 6
]
