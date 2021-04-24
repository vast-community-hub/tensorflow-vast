Class {
	#name : 'ConvolutionKernelSpecification',
	#superclass : 'Object',
	#instVars : [
		'amountOfFilters',
		'kernelInitializer',
		'kernelShape'
	],
	#category : 'TFExperimentalOperationModel'
}

{ #category : 'Instance Creation' }
ConvolutionKernelSpecification class >> totalFilters: anAmount sized: aKernelSize initializedWith: aVariableInitializer [

	^self new
		initializeTotalFilters: anAmount
		sized: aKernelSize
		initializedWith: aVariableInitializer
]

{ #category : 'Accessing' }
ConvolutionKernelSpecification >> amountOfFilters [

	^amountOfFilters
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
ConvolutionKernelSpecification >> initializeTotalFilters: anAmountOfFilters sized: aTensorShape initializedWith: aVariableInitializer [

	amountOfFilters := anAmountOfFilters.
	kernelShape := aTensorShape.
	kernelInitializer := aVariableInitializer
]

{ #category : 'Accessing' }
ConvolutionKernelSpecification >> kernelShape [

	^kernelShape dimensionSizes
]

{ #category : 'Accessing' }
ConvolutionKernelSpecification >> variableInitializer [

	^kernelInitializer
]
