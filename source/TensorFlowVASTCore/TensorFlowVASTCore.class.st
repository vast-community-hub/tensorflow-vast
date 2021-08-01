Class {
	#name : 'TensorFlowVASTCore',
	#superclass : 'Application',
	#category : 'TensorFlowVASTCore'
}

{ #category : 'Loading/Unloading' }
TensorFlowVASTCore class >> loaded [

	defined do: [:aClass |
		(aClass class includesSelector: #initializeOnLoad) ifTrue: [aClass initializeOnLoad].
		(aClass class canUnderstand: #initializeAfterLoad) ifTrue: [aClass initializeAfterLoad]].
		
	TensorFlowCAPI setCurrentPlatformLibraryTo: TensorFlowVASTLibrary current
]
