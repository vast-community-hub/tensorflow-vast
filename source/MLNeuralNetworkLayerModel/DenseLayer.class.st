Class {
	#name : 'DenseLayer',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'inputSize',
		'outputSize',
		'weightSpec',
		'biasSpec',
		'tf',
		'weights',
		'activation',
		'input'
	],
	#category : 'MLNeuralNetworkLayerModel'
}

{ #category : 'Instance Creation' }
DenseLayer class >> receiving: anInput featuresOfInput: anInputSize featuresOfOutput: anOutputSize weightSpecifiedBy: aWeightSpecification [

	^self
		receiving: anInput
		featuresOfInput: anInputSize
		featuresOfOutput: anOutputSize
		weightSpecifiedBy: aWeightSpecification
		biasSpecifiedBy: nil
]

{ #category : 'Instance Creation' }
DenseLayer class >> receiving: anInput featuresOfInput: anInputSize featuresOfOutput: anOutputSize weightSpecifiedBy: aWeightSpecification biasSpecifiedBy: aBiasSpecification [

	^self
		receiving: anInput
		featuresOfInput: anInputSize
		featuresOfOutput: anOutputSize
		weightSpecifiedBy: aWeightSpecification
		biasSpecifiedBy: aBiasSpecification
		activatedBy: nil
]

{ #category : 'Instance Creation' }
DenseLayer class >> receiving: anInput featuresOfInput: anInputSize featuresOfOutput: anOutputSize weightSpecifiedBy: aWeightSpecification biasSpecifiedBy: aBiasSpecification activatedBy: anActivation [

	^self new
		initializeReceiving: anInput
		featuresOfInput: anInputSize
		featuresOfOutput: anOutputSize
		weightSpecifiedBy: aWeightSpecification
		biasSpecifiedBy: aBiasSpecification
		activatedBy: anActivation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
DenseLayer >> calculateValue [

	| output |

	output := input dot: weights.

	biasSpec ifNotNil: [:spec | | bias |
		bias :=
			tf
				floatVariableNamed: 'bias'
				shaped: (Array with: outputSize)
				initializedWith: spec variableInitializer.
		output := output biasedBy: bias].

	activation ifNotNil: [:activ | output := activ activating: output].

	^output
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
DenseLayer >> initializeReceiving: anInput featuresOfInput: anInputSize featuresOfOutput: anOutputSize weightSpecifiedBy: aWeightSpecification biasSpecifiedBy: aBiasSpecification activatedBy: anActivation [

	tf := anInput value currentComputation.
	input := anInput.
	inputSize := anInputSize.
	outputSize := anOutputSize.
	weightSpec := aWeightSpecification.
	biasSpec := aBiasSpecification.
	activation := anActivation.

	self initializeWeight.
	value := self calculateValue 
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
DenseLayer >> initializeWeight [

	weights :=
		TFVariable
			on: tf
			named: 'weight'
			of: input outputType
			shaped: (Array with: inputSize with: outputSize)
			initializedWith: weightSpec variableInitializer
]
