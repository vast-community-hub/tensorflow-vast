Class {
	#name : 'DenseLayer',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'inputSize',
		'outputSize',
		'weights',
		'input',
		'trainableVariables',
		'activation'
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
			VariableNode
				on: self currentComputation
				named: 'bias'
				of: aBiasSpec variableType
				shaped: (TensorShape vectorSized: outputSize)
				initializedWith: aBiasSpec variableInitializer.
		trainableVariables add: bias.
		output := output biasedBy: bias].

	activation ifNotNil: [:activ | output := activ activating: output].

	^output
]

{ #category : 'Accessing' }
DenseLayer >> currentComputation [

	^input currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
DenseLayer >> initializeReceiving: anInput featuresOfInput: anInputSize featuresOfOutput: anOutputSize weightSpecifiedBy: aWeightSpecification biasSpecifiedBy: aBiasSpecification activatedBy: anActivation [

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
		VariableNode
			on: self currentComputation
			named: 'weight'
			of: aVariableSpec variableType
			shaped: (TensorShape matrixSized: inputSize by: outputSize)
			initializedWith: aVariableSpec variableInitializer.

	trainableVariables add: weights
]

{ #category : 'Accessing' }
DenseLayer >> inputVariableName [

	^input operationName
]

{ #category : 'Initialization' }
DenseLayer >> printOn: aStream [

	aStream nextPutAll: ('Dense Layer[<1p> -> <2p>]' expandMacrosWith: inputSize with: outputSize)
]

{ #category : 'Accessing' }
DenseLayer >> trainableVariables [

	^trainableVariables
]
