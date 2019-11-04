Class {
	#name : 'TensorFlowTestsApp',
	#superclass : 'Application',
	#category : 'TensorFlowTestsApp'
}

{
	#category : 'loading/removing'
}
TensorFlowTestsApp class >> failedRemove [

	self loaded
]

{
	#category : 'loading/removing'
}
TensorFlowTestsApp class >> loaded [
	"Send #initializeOnLoad to every class defined in this subapplication that implements it."

	defined do: [ :aClass |
		(aClass class includesSelector: #initializeOnLoad) ifTrue: [ aClass initializeOnLoad ] ]
]

{
	#category : 'instance creation'
}
TensorFlowTestsApp class >> new [

	^super new initialize
]

{
	#category : 'loading/removing'
}
TensorFlowTestsApp class >> removing [
	"Send #unload to every class defined in this subapplication that implements it."

	defined do: [ :aClass |
		(aClass class includesSelector: #unload) ifTrue: [ aClass unload ] ]
]
