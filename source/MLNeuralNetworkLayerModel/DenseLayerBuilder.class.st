Class {
	#name : 'DenseLayerBuilder',
	#superclass : 'Object',
	#instVars : [
		'outputSize',
		'inputSize',
		'weightSpecification',
		'activation',
		'input',
		'biasSpecification',
		'inputSizeAsserter'
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

{ #category : 'Configuring' }
DenseLayerBuilder >> activatedByRelu [

	self activatedBy: RectifiedLinear
]

{ #category : 'Configuring' }
DenseLayerBuilder >> activatedBySigmoid [

	self activatedBy: Sigmoid
]

{ #category : 'Configuring' }
DenseLayerBuilder >> activatedByTanh [

	self activatedBy: Tanh
]

{ #category : 'Configuring - Bias' }
DenseLayerBuilder >> biasInitializedTo: anArray [

	self biasSpecifiedBy: (
		VariableNodeSpecification
			of: TFTensor typeFloat
			initializedWith: (ConstantInitializer with: anArray asFloatTensor))
]

{ #category : 'Configuring - Bias' }
DenseLayerBuilder >> biasInitializedToZero [

	self biasSpecifiedBy: (
		VariableNodeSpecification
			of: TFTensor typeFloat
			initializedWith: ConstantInitializer withZeros)
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
	inputSizeAsserter value. 
	numberOfInputFeatures :=
		inputSize ifNil: [input outputShape numberOfFeatures] ifNotNil: [inputSize].

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
	activation := nil.
	inputSizeAsserter := [
		inputSize isNil ifTrue: [AssertionFailure signal: #'Input size must be defined!']].
	self weightInitializedRandomly.
	self biasInitializedToZero
]

{ #category : 'Configuring' }
DenseLayerBuilder >> inputSize: aNumberOfInputFeatures [

	inputSize := aNumberOfInputFeatures
]

{ #category : 'Configuring' }
DenseLayerBuilder >> makeInputSizeOptional [

	inputSizeAsserter := []

	
]

{ #category : 'Configuring - Weight' }
DenseLayerBuilder >> weightInitializedRandomly [

	self weightInitializedWith: GlorotUniformInitializer new
]

{ #category : 'Configuring - Weight' }
DenseLayerBuilder >> weightInitializedTo: aTensor [

	self weightInitializedWith: (ConstantInitializer with: aTensor asFloatTensor)
]

{ #category : 'Configuring - Weight' }
DenseLayerBuilder >> weightInitializedToZero [

	self weightInitializedWith: ConstantInitializer withZeros
]

{ #category : 'Configuring - Weight' }
DenseLayerBuilder >> weightInitializedWith: anVariableInitializer [

	self weightSpecifiedBy:
		(VariableNodeSpecification of: TFTensor typeFloat initializedWith: anVariableInitializer)
]

{ #category : 'Configuring - Weight' }
DenseLayerBuilder >> weightSpecifiedBy: aVariableSpecification [

	weightSpecification := aVariableSpecification
]

{ #category : 'Configuring - Bias' }
DenseLayerBuilder >> withoutBias [

	self biasSpecifiedBy: nil
]
