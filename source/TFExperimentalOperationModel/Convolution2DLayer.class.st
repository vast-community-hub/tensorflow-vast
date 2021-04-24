Class {
	#name : 'Convolution2DLayer',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'input'
	],
	#category : 'TFExperimentalOperationModel'
}

{ #category : 'Instance Creation' }
Convolution2DLayer class >> filtering: anInput withKernelLike: aConvolutionKernelSpecification [

	^self new initializeFiltering: anInput withKernelLike: aConvolutionKernelSpecification
]

{ #category : 'Accessing' }
Convolution2DLayer >> currentComputation [

	^input currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Convolution2DLayer >> defaultPaddingTechnique [

	^'VALID'
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Convolution2DLayer >> defaultStride [

	^#(1 1)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Convolution2DLayer >> initializeFiltering: anInput withKernelLike: aConvolutionKernelSpecification [

	| filter |

	input := anInput.
	filter :=
		VariableNode
			on: self currentComputation
			named: 'conv2d-filter'
			of: anInput outputType
			shaped: (
				TensorShape withDimensionsSized: (
					(OrderedCollection new)
						addAll: aConvolutionKernelSpecification kernelShape;
						add: input outputShape dimensionSizes last;
						add: aConvolutionKernelSpecification amountOfFilters;
						asArray))
			initializedWith: aConvolutionKernelSpecification variableInitializer.
			
	value :=
		Convolution2D
			on: self currentComputation
			filtering: anInput
			with: filter
			shiftedBy: self defaultStride
			paddedAccording: self defaultPaddingTechnique
]
