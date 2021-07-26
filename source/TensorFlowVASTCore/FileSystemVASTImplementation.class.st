Class {
	#name : 'FileSystemVASTImplementation',
	#superclass : 'Object',
	#category : 'TensorFlowVASTCore'
}

{ #category : 'Not categorized' }
FileSystemVASTImplementation class >> initializeAfterLoad [

	FileSystemAPI setCurrentToUse: self new
]

{ #category : 'Accessing' }
FileSystemVASTImplementation >> directoryNamed: aDirectoryName [

	| directory |

	directory := aDirectoryName asFileReference.
	directory realize ifFalse: [AssertionFailure signal: 'Folder could not be created'].
	^directory
]

{ #category : 'Accessing' }
FileSystemVASTImplementation >> downloadFileAt: aURL to: aFileName [

	| byteMessage result |

	aFileName exists ifTrue: [^aFileName asPath].

	byteMessage := SstHttpClient fetch: aURL.
	byteMessage isSstError ifTrue: [byteMessage raise].
	result := aFileName writeStreamDo: [:stream | stream nextPutAll: byteMessage basicContents].
	result ifNil: [AssertionFailure signal: 'File could not be downloaded'].
	^aFileName asPath
]

{ #category : 'Accessing' }
FileSystemVASTImplementation >> idxReaderOn: aFileName [

	| file |

	file := aFileName asFileReference.
	file exists ifFalse: [AssertionFailure signal: (#'Can''t find %1' bindWith: file asString)].
	file readStreamDo: [:compressed |
		^IdxReader onStream: compressed contents gzipDecompress readStream]
]

{ #category : 'Accessing' }
FileSystemVASTImplementation >> readIdxFileNamed: aFileName thenDo: aBlockClosure [

	| reader |

	reader := self idxReaderOn: aFileName.
	aBlockClosure value: reader dimensionSizes value: reader next
]
