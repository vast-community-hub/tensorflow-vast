Class {
	#name : 'VariableNodeSpecification',
	#superclass : 'Object',
	#instVars : [
		'type',
		'variableInitializer',
		'regularizer'
	],
	#category : 'TFVariableSpecificationModel'
}

{ #category : 'Instance Creation' }
VariableNodeSpecification class >> of: aType initializedWith: aVariableInitializer [

	^self of: aType initializedWith: aVariableInitializer regularizedWith: nil
]

{ #category : 'Instance Creation' }
VariableNodeSpecification class >> of: aType initializedWith: aVariableInitializer regularizedWith: aRegularizer [

	^self new
		initializedOf: aType
		initializedWith: aVariableInitializer
		regularizedWith: aRegularizer
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
VariableNodeSpecification >> initializedOf: aType initializedWith: aVariableInitializer regularizedWith: aRegularizer [

	type := aType.
	variableInitializer := aVariableInitializer.
	regularizer := aRegularizer
]

{ #category : 'Accessing' }
VariableNodeSpecification >> variableInitializer [

	^variableInitializer
]

{ #category : 'Accessing' }
VariableNodeSpecification >> variableType [

	^type
]

{ #category : 'Accessing' }
VariableNodeSpecification >> withRegularizerDo: aBlock [

	regularizer ifNotNil: aBlock
]
