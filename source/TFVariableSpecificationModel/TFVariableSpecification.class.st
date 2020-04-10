Class {
	#name : 'TFVariableSpecification',
	#superclass : 'Object',
	#instVars : [
		'type',
		'variableInitializer',
		'regularizer'
	],
	#category : 'TFVariableSpecificationModel'
}

{ #category : 'Instance Creation' }
TFVariableSpecification class >> of: aType initializedWith: aVariableInitializer [

	^self of: aType initializedWith: aVariableInitializer regularizedWith: nil
]

{ #category : 'Instance Creation' }
TFVariableSpecification class >> of: aType initializedWith: aVariableInitializer regularizedWith: aRegularizer [

	^self new
		initializedOf: aType
		initializedWith: aVariableInitializer
		regularizedWith: aRegularizer
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFVariableSpecification >> initializedOf: aType initializedWith: aVariableInitializer regularizedWith: aRegularizer [

	type := aType.
	variableInitializer := aVariableInitializer.
	regularizer := aRegularizer
]

{ #category : 'Accessing' }
TFVariableSpecification >> variableInitializer [

	^variableInitializer
]

{ #category : 'Accessing' }
TFVariableSpecification >> withRegularizerDo: aBlock [

	regularizer ifNotNil: aBlock
]
