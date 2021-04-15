Class {
	#name : 'PublicResourceDownloader',
	#superclass : 'Object',
	#category : 'DatasetProviderModel'
}

{ #category : 'Accessing' }
PublicResourceDownloader >> downloadFileAt: aURL to: aFileName [

	| byteMessage result |

	byteMessage := SstHttpClient fetch: aURL.
	byteMessage isSstError ifTrue: [byteMessage raise].
	result := aFileName writeStreamDo: [:stream | stream nextPutAll: byteMessage basicContents].
	result ifNil: [AssertionFailure signal: 'File could not be downloaded'].
	^result
]
