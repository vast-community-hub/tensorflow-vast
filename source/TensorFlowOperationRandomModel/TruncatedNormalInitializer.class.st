Class {
	#name : 'TruncatedNormalInitializer',
	#superclass : 'VariableTensorInitializer',
	#instVars : [
		'mean',
		'standardDeviation',
		'tensorGenerator'
	],
	#category : 'TensorFlowOperationRandomModel'
}

{ #category : 'Instance Creation' }
TruncatedNormalInitializer class >> centeredOn: aMeanValue spreadedBy: aStandardDeviation withSeed: anIntegerSeed [

	^self
		generatingValuesCenteredOn: aMeanValue
		spreadedBy: aStandardDeviation
		with: (DeterministicSeedTensorGenerator fixedTo: anIntegerSeed)
]

{ #category : 'Instance Creation' }
TruncatedNormalInitializer class >> centereredOn: aMeanValue spreadedBy: aStandardDeviation [

	^self
		generatingValuesCenteredOn: aMeanValue
		spreadedBy: aStandardDeviation
		with: RandomSeedTensorGenerator new
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TruncatedNormalInitializer class >> defaultMean [

	^0.0
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TruncatedNormalInitializer class >> defaultStandardDeviation [

	^0.05
]

{ #category : 'Instance Creation' }
TruncatedNormalInitializer class >> deviatedBy: aStandardDeviation [

	^self centereredOn: self defaultMean spreadedBy: aStandardDeviation
]

{ #category : 'Instance Creation' }
TruncatedNormalInitializer class >> generatingValuesCenteredOn: aMeanValue spreadedBy: aStandardDeviation with: aTensorGenerator [

	^super new
		initializeGeneratingValuesCenteredOn: aMeanValue
		spreadedBy: aStandardDeviation
		with: aTensorGenerator
]

{ #category : 'Instance Creation' }
TruncatedNormalInitializer class >> new [

	^self centereredOn: self defaultMean spreadedBy: self defaultStandardDeviation
]

{ #category : 'Instance Creation' }
TruncatedNormalInitializer class >> spreadedBy: aStandardDeviation withSeed: anIntegerSeed [

	^self
		generatingValuesCenteredOn: self defaultMean
		spreadedBy: aStandardDeviation
		with: (DeterministicSeedTensorGenerator fixedTo: anIntegerSeed)
]

{ #category : 'Instance Creation' }
TruncatedNormalInitializer class >> withSeed: anIntegerSeed [

	^self
		generatingValuesCenteredOn: self defaultMean
		spreadedBy: self defaultStandardDeviation
		with: (DeterministicSeedTensorGenerator fixedTo: anIntegerSeed)
]

{ #category : 'Evaluating' }
TruncatedNormalInitializer >> applyTo: aVariableTensor [

	aVariableTensor assign: (
		tensorGenerator
			truncatedNormalTensorOn: aVariableTensor currentComputation
			shaped: aVariableTensor outputShape
			centeredOn: mean
			spreadedBy: standardDeviation)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TruncatedNormalInitializer >> initializeGeneratingValuesCenteredOn: aMeanValue spreadedBy: aStandardDeviation with: aTensorGenerator [

	mean := aMeanValue.
	standardDeviation := aStandardDeviation.
	tensorGenerator := aTensorGenerator
]
