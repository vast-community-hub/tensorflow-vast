Class {
	#name : 'FileSystemAPI',
	#superclass : 'Object',
	#instVars : [
		'implementation'
	],
	#classInstVars : [
		'current'
	],
	#category : 'TensorFlowCore'
}

{ #category : 'accessing' }
FileSystemAPI class >> current [

	^current
]

{ #category : 'instance creation' }
FileSystemAPI class >> setCurrentToUse: aFileSystemImplementation [


	current := self using: aFileSystemImplementation 
]

{ #category : 'instance creation' }
FileSystemAPI class >> using: aFileSystemImplementation [

	^ self new initializeUsing: aFileSystemImplementation
]

{ #category : 'accessing' }
FileSystemAPI >> directoryNamed: aDirectoryName [
	
	^ implementation directoryNamed: aDirectoryName
]

{ #category : 'accessing' }
FileSystemAPI >> downloadFileAt: anUrl to: aFileName [
	
	^ implementation downloadFileAt: anUrl to: aFileName
]

{ #category : 'accessing' }
FileSystemAPI >> idxReaderOn: aFileName [

	
	^ implementation idxReaderOn: aFileName 
]

{ #category : 'initialization',
  #vaVisibility : 'private' }
FileSystemAPI >> initializeUsing: aFileSystemImplementation [

	implementation := aFileSystemImplementation
]

{ #category : 'accessing' }
FileSystemAPI >> readIdxFileNamed: aFileName thenDo: aBlock [

	
	^ implementation readIdxFileNamed: aFileName thenDo: aBlock 
]
