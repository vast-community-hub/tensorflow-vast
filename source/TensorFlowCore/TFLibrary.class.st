Class {
	#name : 'TFLibrary',
	#superclass : 'TFStructure',
	#category : 'TensorFlowCore'
}

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFLibrary class >> initializeAfterLoad [
	"Set an opaque layout."

	self initializeOpaqueLayout
]

{ #category : 'Factory' }
TFLibrary class >> loadLibrary: libraryFilename status: status [
	"Load the library specified by library_filename and register the ops and
	 kernels present in that library.
	 
	 Pass 'library_filename' to a platform-specific mechanism for dynamically
	 loading a library. The rules for determining the exact location of the
	 library are platform-specific and are not documented here.
	 
	 On success, place OK in status and return the newly created library handle.
	 The caller owns the library handle.
	 
	 On failure, place an error status in status and return nil.
	 
	 Arguments:
		libraryFilename - <String>
		status - <
	 Answers:
		<TFLibrary> or nil if failed"

	| result |

	result := self address: (self dispatcher callTF_LoadLibraryWith: libraryFilename with: status).
	result isNull ifTrue: [^nil].
	^result




]
