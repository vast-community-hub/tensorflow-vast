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
	#category : 'NeuralNetworkTrainingDatasetModel'
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
SampleDatasetComputationAware class >> on: aTensorFlowComputation applying: aDatasetTransformation [

	^self
		on: aTensorFlowComputation
		transformingFeaturesWith: self identityTransformation
		transformingLabelsWith: self identityTransformation
		applying: aDatasetTransformation
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

	currentComputation
		inScopeNamed: 'training_dataset'
		do: [
			featuresNode :=
				featuresTransformation value: (currentComputation constantWith: aFeaturesTensor).
			labelsNode := labelsTransformation
				value: (currentComputation constantWith: aLabelsTensor).

			trainingDataset :=
				datasetTransformation value: (
					TensorDataset
						on: currentComputation
						slicingAll: (Array with: featuresNode with: labelsNode))]
]

{ #category : 'Configuring' }
SampleDatasetComputationAware >> bindValidationFeaturesTo: aFeaturesTensor withLabels: aLabelsTensor [

	| featuresNode labelsNode |

	currentComputation
		inScopeNamed: 'validation_dataset'
		do: [
			featuresNode :=
				featuresTransformation value: (currentComputation constantWith: aFeaturesTensor).
			labelsNode := labelsTransformation
				value: (currentComputation constantWith: aLabelsTensor).

			validationDataset :=
				datasetTransformation value: (
					TensorDataset
						on: currentComputation
						slicingAll: (Array with: featuresNode with: labelsNode))]
]

{ #category : 'Testing' }
SampleDatasetComputationAware >> hasTrainingSetConfigured [

	^trainingDataset isNil not
]

{ #category : 'Testing' }
SampleDatasetComputationAware >> hasValidationSetConfigured [

	^validationDataset isNil not
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

	self hasTrainingSetConfigured
		ifTrue: [
			trainingDataset do: [:batchSample |
				aTwoArgBlock value: (batchSample at: 1) value: (batchSample at: 2)]]
]

{ #category : 'Accessing' }
SampleDatasetComputationAware >> withValidationDatasetDo: aTwoArgBlock [

	self hasValidationSetConfigured
		ifTrue: [
			validationDataset do: [:batchSample |
				aTwoArgBlock value: (batchSample at: 1) value: (batchSample at: 2)]]
]
