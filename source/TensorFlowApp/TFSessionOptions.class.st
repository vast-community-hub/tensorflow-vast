Class {
	#name : 'TFSessionOptions',
	#superclass : 'TFStructure',
	#category : 'TensorFlowApp'
}

{
	#category : 'Startup/Shutdown',
	#vaVisibility : 'private'
}
TFSessionOptions class >> initializeAfterLoad [
	"Set an opaque layout."

	self initializeOpaqueLayout
]

{
	#category : 'Creation'
}
TFSessionOptions class >> new [
	"Answer a new session options
	 
	 Answers:
		<TFSessionOptions>"

	| result |

	result := TensorFlowCAPI current newSessionOptions.
	result isNull ifTrue: [^nil].
	^result
]

{
	#category : 'API'
}
TFSessionOptions >> config: aByteObject [
	"Set the config in TF_SessionOptions.options.
	 config should be a serialized tensorflow.ConfigProto proto.
	 If config was not parsed successfully as a ConfigProto, record the
	 error information in *status.
	 
	 Arguments:
		aByteObject - <String | ByteArray>
	 Answers:
		<TFStatus>"

	| status |

	status := TFStatus new.
	self library
		sessionOptions: self
		setConfig: aByteObject
		configSize: aByteObject size
		status: status.
	status check.
	

]

{
	#category : 'Memory Management'
}
TFSessionOptions >> free [
	"Free session options memory"
	self delete.
	self makeUndefined
]

{
	#category : 'API'
}
TFSessionOptions >> target: aString [
	"Set the target in TF_SessionOptions.options.
	 target can be empty, a single entry, or a comma separated list of entries.
	 Each entry is in one of the following formats :
	 'local', ip:port, host:port
	 
	 Arguments:
		aString - <String>"

	self library
		sessionOptions: self
		setTarget: (self library externalizeString: aString)
]
