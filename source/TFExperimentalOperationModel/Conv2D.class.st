Class {
	#name : 'Conv2D',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'currentComputation'
	],
	#category : 'TFExperimentalOperationModel'
}

{ #category : 'Instance Creation' }
Conv2D class >> on: aTensorFlowComputation applying: aFiltersTensor to: anInputTensor shiftingBy: stridesAlongHeightAndWeight paddedBy: aPaddingTechnique [

	^self new
		initializeOn: aTensorFlowComputation
		applying: aFiltersTensor
		to: anInputTensor
		shiftingBy: stridesAlongHeightAndWeight
		paddedBy: aPaddingTechnique
]

{ #category : 'Accessing' }
Conv2D class >> paddingToSameInputAndOutputSize [

	^'SAME'
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Conv2D >> initializeOn: aTensorFlowComputation applying: aFiltersTensor to: anInputTensor shiftingBy: stridesAlongHeightAndWeight paddedBy: aPaddingTechnique [

	currentComputation := aTensorFlowComputation.
	value :=
		currentComputation
			newOperationOf: 'Conv2D'
			namePrefixed: 'Conv2D'
			withAll: (Array with: anInputTensor with: aFiltersTensor)
			describedBy: [:description |
				description
					at: 'strides'
						putInts: (
							OrderedCollection new
								add: 1;
								addAll: stridesAlongHeightAndWeight;
								add: 1;
								asArray);
					at: 'padding' putString: aPaddingTechnique]
]
