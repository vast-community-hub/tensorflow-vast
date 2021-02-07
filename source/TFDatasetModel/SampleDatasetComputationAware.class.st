Class {
	#name : 'SampleDatasetComputationAware',
	#superclass : 'Object',
	#instVars : [
		'trainingDataset',
		'currentComputation',
		'validationDataset',
		'featuresTransformation',
		'labelsTransformation',
		'datasetTransformation'
	],
	#category : 'TFDatasetModel'
}

{ #category : 'Instance Creation',
  #vaVisibility : 'private' }
SampleDatasetComputationAware class >> identityTransformation [

	^[:set | set]
]

{ #category : 'Instance Creation' }
SampleDatasetComputationAware class >> on: aTensorFlowComputation [

	^self on: aTensorFlowComputation transformingFeaturesWith: self identityTransformation
]

{ #category : 'Instance Creation' }
SampleDatasetComputationAware class >> on: aTensorFlowComputation transformingFeaturesWith: aFeaturesTransformation [

	^self
		on: aTensorFlowComputation
		transformingFeaturesWith: aFeaturesTransformation
		transformingLabelsWith: self identityTransformation
]

{ #category : 'Instance Creation' }
SampleDatasetComputationAware class >> on: aTensorFlowComputation transformingFeaturesWith: aFeaturesTransformation transformingLabelsWith: aLabelsTransformation [

	^self
		on: aTensorFlowComputation
		transformingFeaturesWith: aFeaturesTransformation
		transformingLabelsWith: aLabelsTransformation
		applying: self identityTransformation
]

{ #category : 'Instance Creation' }
SampleDatasetComputationAware class >> on: aTensorFlowComputation transformingFeaturesWith: aFeaturesTransformation transformingLabelsWith: aLabelsTransformation applying: aDatasetTransformation [

	^self new
		initializeOn: aTensorFlowComputation
		transformingFeaturesWith: aFeaturesTransformation
		transformingLabelsWith: aLabelsTransformation
		applying: aDatasetTransformation
]

{ #category : 'Configuring' }
SampleDatasetComputationAware >> bindSetsFrom: aSampleDataset [

	aSampleDataset
		withTrainingDatasetDo: [:features :labels |
			self bindTrainingFeaturesTo: features withLabels: labels];
		withValidationDatasetDo: [:features :labels |
			self bindValidationFeaturesTo: features withLabels: labels]
]

{ #category : 'Configuring' }
SampleDatasetComputationAware >> bindTrainingFeaturesTo: aFeaturesTensor withLabels: aLabelsTensor [

	| featuresNode labelsNode |

	featuresNode := featuresTransformation value: (currentComputation constantWith: aFeaturesTensor).
	labelsNode := labelsTransformation value: (currentComputation constantWith: aLabelsTensor).

	trainingDataset :=
		datasetTransformation value: (
			TensorDataset
				on: currentComputation
				slicingAll: (Array with: featuresNode with: labelsNode))
]

{ #category : 'Configuring' }
SampleDatasetComputationAware >> bindValidationFeaturesTo: aFeaturesTensor withLabels: aLabelsTensor [

	| featuresNode labelsNode |

	featuresNode := featuresTransformation value: (currentComputation constantWith: aFeaturesTensor).
	labelsNode := labelsTransformation value: (currentComputation constantWith: aLabelsTensor).

	validationDataset :=
		datasetTransformation value: (
			TensorDataset
				on: currentComputation
				slicingAll: (Array with: featuresNode with: labelsNode))
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
SampleDatasetComputationAware >> initializeOn: aTensorFlowComputation transformingFeaturesWith: aFeaturesTransformation transformingLabelsWith: aLabelsTransformation applying: aDatasetTransformation [

	currentComputation := aTensorFlowComputation.
	featuresTransformation := aFeaturesTransformation.
	labelsTransformation := aLabelsTransformation.
	datasetTransformation := aDatasetTransformation
]

{ #category : 'Accessing' }
SampleDatasetComputationAware >> withTrainingBatchesDo: aTwoArgBlock [

	trainingDataset
		do: [:batchSample | aTwoArgBlock value: (batchSample at: 1) value: (batchSample at: 2)]
]

{ #category : 'Accessing' }
SampleDatasetComputationAware >> withTrainingDatasetDo: aTwoArgBlock [

	trainingDataset ifNotNil: [:dataset |
		dataset
			do: [:batchSample | aTwoArgBlock value: (batchSample at: 1) value: (batchSample at: 2)]]
]

{ #category : 'Accessing' }
SampleDatasetComputationAware >> withValidationDatasetDo: aTwoArgBlock [

	validationDataset ifNotNil: [:dataset |
		dataset
			do: [:batchSample | aTwoArgBlock value: (batchSample at: 1) value: (batchSample at: 2)]]
]
