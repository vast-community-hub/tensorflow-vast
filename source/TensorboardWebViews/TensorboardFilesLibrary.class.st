Class {
	#name : 'TensorboardFilesLibrary',
	#superclass : 'WAFileLibrary',
	#category : 'TensorboardWebViews'
}

{ #category : 'Not categorized' }
TensorboardFilesLibrary class >> handle: aRequestContext [
	
	self halt
]

{ #category : 'Accessing' }
TensorboardFilesLibrary >> selectorsToInclude [

	^#(summaryIconSvg)
]

{ #category : 'Accessing' }
TensorboardFilesLibrary >> summaryIconSvg [

	^WAFileLibraryResource
		filepath: 'tensorboard/lib/svg/summary-icon.svg'
		mimeType: (WAMimeType main: 'image' sub: 'svg+xml')
		cacheDuration: self class defaultCacheDuration
		contents: (GRDelayedSend receiver: self selector: #summaryIconSvgContent)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TensorboardFilesLibrary >> summaryIconSvgContent [

	^'<svg fill="#848484" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg">
	<path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-7h2v7zm4 0h-2V7h2v10zm4 0h-2v-4h2v4z"/>
</svg>'
]
