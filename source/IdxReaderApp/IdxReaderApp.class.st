Class {
	#name : 'IdxReaderApp',
	#superclass : 'Application',
	#category : 'IdxReaderApp'
}

{ #category : 'loading/removing' }
IdxReaderApp class >> failedRemove [

	self loaded
]

{ #category : 'loading/removing' }
IdxReaderApp class >> loaded [
	"Send #initializeOnLoad to every class defined in this subapplication that implements it."

	defined do: [ :aClass |
		(aClass class includesSelector: #initializeOnLoad) ifTrue: [ aClass initializeOnLoad ] ]
]

{ #category : 'instance creation' }
IdxReaderApp class >> new [

	^super new initialize
]

{ #category : 'loading/removing' }
IdxReaderApp class >> removing [
	"Send #unload to every class defined in this subapplication that implements it."

	defined do: [ :aClass |
		(aClass class includesSelector: #unload) ifTrue: [ aClass unload ] ]
]
