Class {
	#name : 'TensorFlowCoreTests',
	#superclass : 'Application',
	#category : 'TensorFlowCoreTests'
}

{ #category : 'loaded' }
TensorFlowCoreTests class >> loaded [
	"Send #initializeOnLoad to every class defined in this subapplication that implements it."

	defined do: [:aClass |
		(aClass class includesSelector: #initializeOnLoad) ifTrue: [aClass initializeOnLoad].
		(aClass class canUnderstand: #initializeAfterLoad) ifTrue: [aClass initializeAfterLoad]]
]
