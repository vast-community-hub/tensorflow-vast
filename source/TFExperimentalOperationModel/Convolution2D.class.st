Class {
	#name : 'Convolution2D',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'currentComputation'
	],
	#category : 'TFExperimentalOperationModel'
}

{ #category : 'Instance Creation' }
Convolution2D class >> on: aTensorFlowComputation filtering: anInputTensor with: aFiltersTensor shiftedBy: stridesAlongHeightAndWeight paddedAccording: aPaddingTechnique [

	^self new
		initializeOn: aTensorFlowComputation
		filtering: anInputTensor
		with: aFiltersTensor
		shiftedBy: stridesAlongHeightAndWeight
		paddedAccording: aPaddingTechnique
]

{ #category : 'Accessing' }
Convolution2D class >> paddingToSameInputAndOutputSize [

	^'SAME'
]

{ #category : 'Accessing' }
Convolution2D >> currentComputation [

	^currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Convolution2D >> initializeOn: aTensorFlowComputation filtering: anInputTensor with: aFiltersTensor shiftedBy: stridesAlongHeightAndWeight paddedAccording: aPaddingTechnique [

	currentComputation := aTensorFlowComputation.
	value :=
		currentComputation
			newOperationOf: 'Conv2D'
			namePrefixed: 'Conv2D'
			withAll: (Array with: anInputTensor with: aFiltersTensor)
			describedBy: [:description |
				description
					atStridesPut: (
						OrderedCollection new
							add: 1;
							addAll: stridesAlongHeightAndWeight;
							add: 1;
							asArray);
					atPaddingPut: aPaddingTechnique]
]
