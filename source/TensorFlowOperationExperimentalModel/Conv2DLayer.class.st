Class {
	#name : 'Conv2DLayer',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'input'
	],
	#category : 'TensorFlowOperationExperimentalModel'
}

{ #category : 'Instance Creation' }
Conv2DLayer class >> filtering: anInput withKernelLike: aConvolutionKernelSpecification [

	^self new initializeFiltering: anInput withKernelLike: aConvolutionKernelSpecification
]

{ #category : 'Accessing' }
Conv2DLayer >> currentComputation [

	^input currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Conv2DLayer >> defaultPaddingTechnique [

	^'VALID'
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Conv2DLayer >> defaultStride [

	^#(1 1)
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Conv2DLayer >> initializeFiltering: anInput withKernelLike: aConvolutionKernelSpecification [

	| filter |

	input := anInput.
	filter :=
		VariableTensor
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
		Conv2D
			on: self currentComputation
			filtering: anInput
			with: filter
			shiftedBy: self defaultStride
			paddedAccording: self defaultPaddingTechnique
]
