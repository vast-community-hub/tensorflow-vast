Class {
	#name : 'VariableTensorSpecification',
	#superclass : 'Object',
	#instVars : [
		'type',
		'variableInitializer',
		'regularizer'
	],
	#category : 'NeuralNetworkLayerModel'
}

{ #category : 'Instance Creation' }
VariableTensorSpecification class >> of: aType initializedWith: aVariableInitializer [

	^self of: aType initializedWith: aVariableInitializer regularizedWith: nil
]

{ #category : 'Instance Creation' }
VariableTensorSpecification class >> of: aType initializedWith: aVariableInitializer regularizedWith: aRegularizer [

	^self new
		initializedOf: aType
		initializedWith: aVariableInitializer
		regularizedWith: aRegularizer
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
VariableTensorSpecification >> initializedOf: aType initializedWith: aVariableInitializer regularizedWith: aRegularizer [

	type := aType.
	variableInitializer := aVariableInitializer.
	regularizer := aRegularizer
]

{ #category : 'Accessing' }
VariableTensorSpecification >> variableInitializer [

	^variableInitializer
]

{ #category : 'Accessing' }
VariableTensorSpecification >> variableType [

	^type
]

{ #category : 'Accessing' }
VariableTensorSpecification >> withRegularizerDo: aBlock [

	regularizer ifNotNil: aBlock
]
