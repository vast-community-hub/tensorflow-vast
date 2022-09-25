Class {
	#name : 'MaxPooling2D',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'currentComputation'
	],
	#category : 'TensorFlowOperationExperimentalModel'
}

{ #category : 'Instance Creation' }
MaxPooling2D class >> on: aTensorFlowComputation reducing: anInput inWindowsOf: aWindowSizes shiftedBy: aStrideAlongsideHeightAndWidth paddingAccording: aPaddingTechnique [

	^self new
		initializeOn: aTensorFlowComputation
		reducing: anInput
		inWindowsOf: aWindowSizes
		shiftedBy: aStrideAlongsideHeightAndWidth
		paddingAccording: aPaddingTechnique
]

{ #category : 'Initialization' }
MaxPooling2D >> currentComputation [

	^currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
MaxPooling2D >> initializeOn: aTensorFlowComputation reducing: anInput inWindowsOf: aWindowSizeArray shiftedBy: aStrideAlongHeightAndWidth paddingAccording: aPaddingTechnique [

	currentComputation := aTensorFlowComputation.
	value :=
		currentComputation
			newOperationOf: 'MaxPool'
			namePrefixed: 'MaxPool'
			withAll: (Array with: anInput)
			describedBy: [:description |
				description
					at: 'ksize'
						putInts: (
							OrderedCollection new
								add: 1;
								addAll: aWindowSizeArray;
								add: 1;
								yourself);
					atStridesPut: (
						OrderedCollection new
							add: 1;
							addAll: aStrideAlongHeightAndWidth;
							add: 1;
							yourself);
					atPaddingPut: aPaddingTechnique]
]
