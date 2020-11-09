Class {
	#name : 'TFVersion',
	#superclass : 'OSImmediate',
	#category : 'TensorFlowApp'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFVersion class >> bindingVersion [
	"1.13.1"

	^16r100D001
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFVersion class >> dispatcher [
	"Answer the dispatcher delgate used for platform function call management
	 
	 Answers:
		<TFLibraryDispatcher>"

	^TFLibraryDispatcher default
]

{ #category : 'Instance Creation' }
TFVersion class >> fromString: aString [
	| stream major minor patch |
	stream := aString readStream.
	major := (stream upTo: $.) asNumber.
	minor := (stream upTo: $.) asNumber.
	patch := stream upToEnd asNumber.
	^self immediate: (major << 24) + (minor << 12) + patch
]

{ #category : 'Factory' }
TFVersion class >> getBindingVersion [
	"Answer the binding version of the Smalltalk wrapper
	 
	 Answers:
		<TFVersion> - os immediate"

	^self immediate: self bindingVersion
]

{ #category : 'Factory' }
TFVersion class >> getLibraryVersion [
	"Answer the native library version on the client
	 Make a vm synchronous call
	 
	 Answers:
		<TFVersion> - semantic version"

	^self fromString: self dispatcher callTF_Version.
]

{ #category : 'Comparing' }
TFVersion >> < aTFVersion [
	^self major < aTFVersion major or: [
		self major = aTFVersion major and: [
			self minor < aTFVersion minor or: [
				self minor = aTFVersion minor and: [
					self patch < aTFVersion patch]]]]
]

{ #category : 'Comparing' }
TFVersion >> <= aTFVersion [
	^ (self < aTFVersion) or: [self = aTFVersion]
]

{ #category : 'Comparing' }
TFVersion >> = aTFVersion [
	^self major = aTFVersion major and: [
		self minor = aTFVersion minor and: [
			self patch = aTFVersion patch]]
]

{ #category : 'Comparing' }
TFVersion >> > aTFVersion [
	^ (self <= aTFVersion) not
]

{ #category : 'Comparing' }
TFVersion >> >= aTFVersion [
	^ (self < aTFVersion) not
]

{ #category : 'Version Number' }
TFVersion >> major [
	"Answer the major element of the version
	 
	 Answers:
		<Integer> major version number"

	^self value >> 24
]

{ #category : 'Version Number' }
TFVersion >> minor [
	"Answer the major element of the version
	 
	 Answers:
		<Integer> minor version number"

	^(self value >> 12) bitAnd: 16rFFF
]

{ #category : 'Version Number' }
TFVersion >> patch [
	"Answer the major element of the version
	 
	 Answers:
		<Integer> patch version number"

	^self value bitAnd: 16rFFF
]

{ #category : 'Printing' }
TFVersion >> printOn: aStream [
	"Print the full version information on @aStream
	 
	 Example: For the release version of 1.0.7, the following
	 <String> will be printed to @aStream: '1.0.7'
	 
	 Arguments:
		aStream - <WriteStream>"

	aStream nextPutAll: (
		'%1.%2.%3' bindWith: self major asString with: self minor asString with: self patch asString)
]
