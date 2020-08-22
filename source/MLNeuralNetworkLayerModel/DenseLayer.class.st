Class {
	#name : 'DenseLayer',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'tf',
		'inputSize',
		'outputSize',
		'weights',
		'activation',
		'input',
		'trainableVariables'
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
DenseLayer >> calculateValueUsing: aBiasSpec [

	| output |

	output := input dot: weights.

	aBiasSpec ifNotNil: [| bias |
		bias :=
			TFVariable
				on: tf
				named: 'bias'
				of: aBiasSpec variableType
				shaped: (Array with: outputSize)
				initializedWith: aBiasSpec variableInitializer.
		trainableVariables add: bias.
		output := output biasedBy: bias].

	activation ifNotNil: [:activ | output := activ activating: output].

	^output
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
DenseLayer >> initializeReceiving: anInput featuresOfInput: anInputSize featuresOfOutput: anOutputSize weightSpecifiedBy: aWeightSpecification biasSpecifiedBy: aBiasSpecification activatedBy: anActivation [

	tf := anInput value currentComputation.
	trainableVariables := OrderedCollection new: 2.
	input := anInput.
	inputSize := anInputSize.
	outputSize := anOutputSize.
	activation := anActivation.

	self initializeWeightFrom: aWeightSpecification.
	value := self calculateValueUsing: aBiasSpecification
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
DenseLayer >> initializeWeightFrom: aVariableSpec [

	weights :=
		TFVariable
			on: tf
			named: 'weight'
			of: aVariableSpec variableType
			shaped: (Array with: inputSize with: outputSize)
			initializedWith: aVariableSpec variableInitializer. 
	
	trainableVariables add: weights
]

{ #category : 'Initialization' }
DenseLayer >> printOn: aStream [

	aStream nextPutAll: ('Dense Layer[<1p> -> <2p>]' expandMacrosWith: inputSize with: outputSize)
]

{ #category : 'Accessing' }
DenseLayer >> trainableVariables [

	^trainableVariables
]
