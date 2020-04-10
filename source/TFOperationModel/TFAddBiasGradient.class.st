Class {
	#name : 'TFAddBiasGradient',
	#superclass : 'TFGradientBehavior',
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFAddBiasGradient class >> withGradientsOfInputs: anInputGradients [

	^self new initializeWithGradientsOfInputs: anInputGradients
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFAddBiasGradient >> initializeWithGradientsOfInputs: anInputGradients [

	value :=
		anInputGradients value currentComputation
			newOperationOf: 'BiasAddGrad'
			named: 'BiasAddGrad'
			with: anInputGradients
]
