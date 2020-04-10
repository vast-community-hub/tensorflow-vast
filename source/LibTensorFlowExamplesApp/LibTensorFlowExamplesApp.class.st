Class {
	#name : 'LibTensorFlowExamplesApp',
	#superclass : 'Application',
	#category : 'LibTensorFlowExamplesApp'
}

{ #category : 'loading/removing' }
LibTensorFlowExamplesApp class >> failedRemove [

	self loaded
]

{ #category : 'loading/removing' }
LibTensorFlowExamplesApp class >> loaded [
	"Send #initializeOnLoad to every class defined in this subapplication that implements it."

	defined do: [ :aClass |
		(aClass class includesSelector: #initializeOnLoad) ifTrue: [ aClass initializeOnLoad ] ]
]

{ #category : 'instance creation' }
LibTensorFlowExamplesApp class >> new [

	^super new initialize
]

{ #category : 'loading/removing' }
LibTensorFlowExamplesApp class >> removing [
	"Send #unload to every class defined in this subapplication that implements it."

	defined do: [ :aClass |
		(aClass class includesSelector: #unload) ifTrue: [ aClass unload ] ]
]
