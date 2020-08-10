Class {
	#name : 'DenseLayerBuilder',
	#superclass : 'Object',
	#instVars : [
		'outputSize',
		'inputSize',
		'weightSpecification',
		'activation',
		'input',
		'biasSpecification'
	],
	#category : 'MLNeuralNetworkLayerModel'
}

{ #category : 'Instance Creation' }
DenseLayerBuilder class >> ofSize: aNumberOfOutputFeatures receiving: anInput [

	^self new initializeOfSize: aNumberOfOutputFeatures receiving: anInput
]

{ #category : 'Configuring' }
DenseLayerBuilder >> activatedBy: anActivation [

	activation := anActivation
]

{ #category : 'Configuring - Bias' }
DenseLayerBuilder >> biasInitializedTo: anArray [

	self biasSpecifiedBy: (
		TFVariableSpecification
			of: TFTensor typeFloat
			initializedWith: (TFConstantInitializer with: anArray asFloatTensor))
]

{ #category : 'Configuring - Bias' }
DenseLayerBuilder >> biasInitializedToZero [

	self biasSpecifiedBy:
		(TFVariableSpecification of: TFTensor typeFloat initializedWith: TFZeroInitializer new)
]

{ #category : 'Configuring - Bias' }
DenseLayerBuilder >> biasSpecifiedBy: aVariableSpecification [

	biasSpecification := aVariableSpecification
]

{ #category : 'Building' }
DenseLayerBuilder >> build [

	| numberOfInputFeatures |
	" Assume input is a matrix of shape (rows x columns), then the second 
	 dimenssion is the number of input features "
	numberOfInputFeatures := inputSize ifNil: [input outputShape second] ifNotNil: [inputSize].
	
	^DenseLayer
		receiving: input
		featuresOfInput: numberOfInputFeatures
		featuresOfOutput: outputSize
		weightSpecifiedBy: weightSpecification
		biasSpecifiedBy: biasSpecification
		activatedBy: activation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
DenseLayerBuilder >> initializeOfSize: aNumberOfOutputFeatures receiving: anInput [

	outputSize := aNumberOfOutputFeatures.
	input := anInput.

	inputSize := nil.
	weightSpecification := nil.
	biasSpecification := nil.
	activation := nil
]

{ #category : 'Configuring' }
DenseLayerBuilder >> inputSize: aNumberOfInputFeatures [

	inputSize := aNumberOfInputFeatures
]

{ #category : 'Configuring - Weight' }
DenseLayerBuilder >> weightInitializedRandomly [

	self weightSpecifiedBy: (
		TFVariableSpecification
			of: TFTensor typeFloat
			initializedWith: TFTruncatedNormalInitializer new)
]

{ #category : 'Configuring - Weight' }
DenseLayerBuilder >> weightInitializedTo: anArray [

	self weightSpecifiedBy: (
		TFVariableSpecification
			of: TFTensor typeFloat
			initializedWith: (TFConstantInitializer with: anArray asFloatTensor))
]

{ #category : 'Configuring - Weight' }
DenseLayerBuilder >> weightInitializedToZero [

	self weightSpecifiedBy:
		(TFVariableSpecification of: TFTensor typeFloat initializedWith: TFZeroInitializer new)
]

{ #category : 'Configuring - Weight' }
DenseLayerBuilder >> weightSpecifiedBy: aVariableSpecification [

	weightSpecification := aVariableSpecification
]
