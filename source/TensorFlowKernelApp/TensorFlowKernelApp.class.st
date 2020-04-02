Class {
	#name : 'TensorFlowKernelApp',
	#superclass : 'Application',
	#category : 'TensorFlowKernelApp'
}

{ #category : 'loading/removing' }
TensorFlowKernelApp class >> failedRemove [

	self loaded
]

{ #category : 'loading/removing' }
TensorFlowKernelApp class >> loaded [
	"Send #initializeOnLoad to every class defined in this subapplication that implements it."

	defined do: [ :aClass |
		(aClass class includesSelector: #initializeOnLoad) ifTrue: [ aClass initializeOnLoad ] ]
]

{ #category : 'instance creation' }
TensorFlowKernelApp class >> new [

	^super new initialize
]

{ #category : 'loading/removing' }
TensorFlowKernelApp class >> removing [
	"Send #unload to every class defined in this subapplication that implements it."

	defined do: [ :aClass |
		(aClass class includesSelector: #unload) ifTrue: [ aClass unload ] ]
]
