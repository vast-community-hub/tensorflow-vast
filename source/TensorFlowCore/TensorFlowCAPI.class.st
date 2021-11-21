Class {
	#name : 'TensorFlowCAPI',
	#superclass : 'Object',
	#instVars : [
		'platformLibrary'
	],
	#classInstVars : [
		'current'
	],
	#category : 'TensorFlowCore'
}

{ #category : 'Accessing' }
TensorFlowCAPI class >> current [

	current ifNil: [ self error: 'No tensorflow binding for this smalltalk platform was set' ].
	^ current
]

{ #category : 'Instance Creation' }
TensorFlowCAPI class >> setCurrentPlatformLibraryTo: aTensorFlowSmalltalkPlatformLibrary [

	current := self wrapping: aTensorFlowSmalltalkPlatformLibrary
]

{ #category : 'Instance Creation' }
TensorFlowCAPI class >> wrapping: aTensorFlowLibrary [

	
	^ self new initializeWrapping: aTensorFlowLibrary
]

{ #category : 'tensor' }
TensorFlowCAPI >> allocateTensorOf: aTensorDomain length: aSmallInteger [

	
	^ platformLibrary allocateTensorOf: aTensorDomain length: aSmallInteger 
]

{ #category : 'strings' }
TensorFlowCAPI >> allStringsOf: aTFTensor [

	^ platformLibrary allStringsOf: aTFTensor
]

{ #category : 'deleting' }
TensorFlowCAPI >> closeSession: aTFSession [

	platformLibrary checkStatusAfter: [:status | platformLibrary closeSession: aTFSession status: status]
]

{ #category : 'buffer' }
TensorFlowCAPI >> deleteBuffer: aTFBuffer [

	^ platformLibrary deleteBuffer: aTFBuffer
]

{ #category : 'device list' }
TensorFlowCAPI >> deleteDeviceList: aTFDeviceList [


	^ platformLibrary deleteDeviceList: aTFDeviceList 
]

{ #category : 'deleting' }
TensorFlowCAPI >> deleteGraph: aTFGraph [

	^platformLibrary deleteGraph: aTFGraph
]

{ #category : 'options' }
TensorFlowCAPI >> deleteImportGraphDefOptions: aTFImportGraphDefOptions [

	
	^ platformLibrary deleteImportGraphDefOptions: aTFImportGraphDefOptions 
]

{ #category : 'deleting' }
TensorFlowCAPI >> deleteSession: aTFSession [

	platformLibrary checkStatusAfter: [:status | platformLibrary deleteSession: aTFSession status: status]
]

{ #category : 'deleting' }
TensorFlowCAPI >> deleteSessionOptions: aTFSessionOptions [

	^platformLibrary deleteSessionOptions: aTFSessionOptions
]

{ #category : 'deleting' }
TensorFlowCAPI >> deleteStatus: aTFStatus [

	^platformLibrary deleteStatus: aTFStatus
]

{ #category : 'deleting' }
TensorFlowCAPI >> deleteTensor: aTFTensor [

	^platformLibrary deleteTensor: aTFTensor
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription addControlInput: aTFOperation [

	
	^ platformLibrary description: aTFOperationDescription addControlInput: aTFOperation 
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription addInput: aTFOutput [

	
	^ platformLibrary description: aTFOperationDescription addInput: aTFOutput 
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription addInputs: anArray [

	^ platformLibrary description: aTFOperationDescription addInputs: anArray
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription set: anAttributeName toBool: aBoolean [
	
	^ platformLibrary description: aTFOperationDescription set: anAttributeName toBool: aBoolean
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription set: anAttributeName toFloat: aFloat [

	
	^ platformLibrary description: aTFOperationDescription set: anAttributeName toFloat: aFloat 
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription set: anAttributeName toInt64: anInteger [

	^ platformLibrary description: aTFOperationDescription set: anAttributeName toInt64: anInteger
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription set: anAttributeName toInts: aListOfIntegers [

	^ platformLibrary description: aTFOperationDescription set: anAttributeName toInts: aListOfIntegers
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription set: anAttributeName toShape: aTensorShape [

	^ platformLibrary description: aTFOperationDescription set: anAttributeName toShape: aTensorShape
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription set: anAttributeName toShapes: aListOfShapes [


	platformLibrary description: aTFOperationDescription set: anAttributeName toShapes: aListOfShapes
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription set: anAttributeName toString: aString [

	platformLibrary checkStatusAfter: [:status |
		platformLibrary
			description: aTFOperationDescription
			set: anAttributeName asAsciiZ
			toString: aString
			size: aString size]
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription set: anAttributeName toStrings: aStringCollection [

	
	^ platformLibrary description: aTFOperationDescription set: anAttributeName toStrings: aStringCollection 
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription set: anAttributeName toTensor: aTFTensor [

	platformLibrary checkStatusAfter: [:status |
		platformLibrary
			description: aTFOperationDescription
			set: anAttributeName asAsciiZ
			toTensor: aTFTensor
			status: status]
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription set: anAttributeName toType: aTensorType [
	
	^ platformLibrary description: aTFOperationDescription set: anAttributeName toType: aTensorType
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription set: anAttributeName toTypes: aListOfTypes [

	platformLibrary description: aTFOperationDescription set: anAttributeName toTypes: aListOfTypes
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription setDevice: aString [


	^ platformLibrary description: aTFOperationDescription setDevice: aString 
]

{ #category : 'device list' }
TensorFlowCAPI >> deviceList: aTFDeviceList incarnationAt: anIndex [

	^platformLibrary checkStatusAfter: [:status |
		platformLibrary deviceList: aTFDeviceList incarnationAt: anIndex status: status]
]

{ #category : 'device list' }
TensorFlowCAPI >> deviceList: aTFDeviceList memoryAt: anIndex [

	^platformLibrary checkStatusAfter: [:status |
		platformLibrary deviceList: aTFDeviceList memoryAt: anIndex status: status]
]

{ #category : 'device list' }
TensorFlowCAPI >> deviceList: aTFDeviceList nameAt: anIndex [

	^platformLibrary checkStatusAfter: [:status |
		platformLibrary deviceList: aTFDeviceList nameAt: anIndex status: status]
]

{ #category : 'device list' }
TensorFlowCAPI >> deviceList: aTFDeviceList typeAt: anIndex [

	^platformLibrary checkStatusAfter: [:status |
		platformLibrary deviceList: aTFDeviceList typeAt: anIndex status: status]
]

{ #category : 'device list' }
TensorFlowCAPI >> deviceListCount: aTFDeviceList [

	^platformLibrary deviceListCount: aTFDeviceList
]

{ #category : 'device list' }
TensorFlowCAPI >> deviceListForSession: aTFSession [

	^platformLibrary checkStatusAfter: [:status | platformLibrary deviceListForSession: aTFSession status: status]
]

{ #category : 'operation attribute' }
TensorFlowCAPI >> deviceNameContaining: aTFOperation [

	
	^ platformLibrary deviceNameContaining: aTFOperation 
]

{ #category : 'strings' }
TensorFlowCAPI >> externalizeString: aString [

	
	^ platformLibrary externalizeString: aString 
]

{ #category : 'operation' }
TensorFlowCAPI >> finishOperation: aTFOperationDescription [

	^platformLibrary checkStatusAfter: [:status | | answer |
		answer := platformLibrary finishOperation: aTFOperationDescription status: status.
		aTFOperationDescription makeNull.
		answer]
]

{ #category : 'graph' }
TensorFlowCAPI >> forGraph: aTFGraph outputDims: aTFOutput [

	^platformLibrary
		checkStatusAfter: [:status | platformLibrary forGraph: aTFGraph outputDims: aTFOutput status: status]
]

{ #category : 'utils' }
TensorFlowCAPI >> getAllOps [
	
	^ platformLibrary getAllOps
]

{ #category : 'initialization' }
TensorFlowCAPI >> getCodeOf: aTFStatus [

	^platformLibrary getCode: aTFStatus
]

{ #category : 'gradients' }
TensorFlowCAPI >> gradientsOf: yArrayOfTFOutput withRespectTo: xArrayOfTFOutput product: dxArrayOfOutput in: aTFGraph [

	^ platformLibrary
		gradientsOf: yArrayOfTFOutput
		withRespectTo: xArrayOfTFOutput
		product: dxArrayOfOutput
		in: aTFGraph
]

{ #category : 'graph' }
TensorFlowCAPI >> graph: aTFGraph getOperationNamed: anOperationName [
	
		^ platformLibrary graph: aTFGraph getOperationNamed: anOperationName
]

{ #category : 'graph' }
TensorFlowCAPI >> graph: aTFGraph getRankOf: aTFOutputOrInput [

	^platformLibrary checkStatusAfter: [:status |
		platformLibrary graph: aTFGraph getRankOf: aTFOutputOrInput status: status]
]

{ #category : 'graph' }
TensorFlowCAPI >> graph: aTFGraph getShapeOf: aTFOutput [

	
	^ platformLibrary graph: aTFGraph getShapeOf: aTFOutput 
]

{ #category : 'graph' }
TensorFlowCAPI >> graph: aTFGraph operationAt: contextULongLongPtr [

	^platformLibrary graph: aTFGraph operationAt: contextULongLongPtr
]

{ #category : 'graph' }
TensorFlowCAPI >> graph: aTFGraph setShapeOf: aTFOutput to: aShape [


	^ platformLibrary graph: aTFGraph setShapeOf: aTFOutput to: aShape 
]

{ #category : 'graph' }
TensorFlowCAPI >> graphDefinitionOf: aTFGraph [

	"Return the protobuff serialisation of the graph"

	| buffer |

	buffer := TFBuffer new.
	platformLibrary checkStatusAfter: [:status | platformLibrary graph: aTFGraph toGraphDef: buffer status: status].
	^buffer dataBytes asString
]

{ #category : 'graph' }
TensorFlowCAPI >> importGraphDefFrom: aTFBuffer into: aTFGraph [

	platformLibrary checkStatusAfter: [:status | | options |
		options := TFImportGraphDefOptions create.
		platformLibrary importGraphDefInto: aTFGraph from: aTFBuffer options: options status: status.
		options delete]
]

{ #category : 'initialization',
  #vaVisibility : 'private' }
TensorFlowCAPI >> initializeWrapping: aPlatformLibrary [

	platformLibrary := aPlatformLibrary
]

{ #category : 'status' }
TensorFlowCAPI >> message: aTFStatus [


	^ platformLibrary message: aTFStatus 
]

{ #category : 'session' }
TensorFlowCAPI >> newAutoreleaseSessionOn: aTFGraph [


	^ platformLibrary newAutoreleaseSessionOn: aTFGraph
]

{ #category : 'options' }
TensorFlowCAPI >> newAutoreleaseSessionOptions [
	
	^ platformLibrary newAutoreleaseSessionOptions
	
]

{ #category : 'status' }
TensorFlowCAPI >> newAutoreleaseStatus [

	^platformLibrary newAutoreleaseStatus
]

{ #category : 'buffer' }
TensorFlowCAPI >> newBuffer [

	^ platformLibrary newBuffer
]

{ #category : 'buffer' }
TensorFlowCAPI >> newBufferFromString: aString [

	
	^ platformLibrary newBufferFromString: aString size: aString size 
]

{ #category : 'graph' }
TensorFlowCAPI >> newGraph [
	
	^ platformLibrary newGraph 
]

{ #category : 'options' }
TensorFlowCAPI >> newImportGraphDefOptions [
	
	^ platformLibrary newImportGraphDefOptions
]

{ #category : 'operation description' }
TensorFlowCAPI >> newOperationDescriptionOn: aTFGraph type: aTensorType named: anOperationName [
	
	^ platformLibrary newOperationDescriptionOn: aTFGraph type: aTensorType named: anOperationName
]

{ #category : 'status' }
TensorFlowCAPI >> newPersistentStatus [
	
	^ platformLibrary newPersistentStatus
]

{ #category : 'options' }
TensorFlowCAPI >> newSessionOptions [
	
	^ platformLibrary newSessionOptions
]

{ #category : 'status' }
TensorFlowCAPI >> newStatus [
	
	^ platformLibrary newStatus
]

{ #category : 'operation attribute' }
TensorFlowCAPI >> operation: aTFOperation getBoolAt: anAttributeName [

	^ platformLibrary operation: aTFOperation getBoolAt: anAttributeName
]

{ #category : 'operation attribute' }
TensorFlowCAPI >> operation: aTFOperation getFloatAt: anAttributeName [

	^ platformLibrary operation: aTFOperation getFloatAt: anAttributeName
]

{ #category : 'operation attribute' }
TensorFlowCAPI >> operation: aTFOperation getInt64At: anAttributeName [


	^platformLibrary operation: aTFOperation getInt64At: anAttributeName
]

{ #category : 'operation attribute' }
TensorFlowCAPI >> operation: aTFOperation getMetadataFor: anAttributeName [

	
	^  platformLibrary operation: aTFOperation getMetadataFor: anAttributeName
]

{ #category : 'operation attribute' }
TensorFlowCAPI >> operation: aTFOperation getShapeAt: anAttributeName [

	^ platformLibrary operation: aTFOperation getShapeAt: anAttributeName
]

{ #category : 'operation attribute' }
TensorFlowCAPI >> operation: aTFOperation getStringAt: anAttributeName [

	^ platformLibrary operation: aTFOperation getStringAt: anAttributeName
]

{ #category : 'operation attribute' }
TensorFlowCAPI >> operation: aTFOperation getStringsAt: anAttributeName [

	^ platformLibrary operation: aTFOperation getStringsAt: anAttributeName
]

{ #category : 'operation attribute' }
TensorFlowCAPI >> operation: aTFOperation getTensorAt: anAttributeName [


	^ platformLibrary operation: aTFOperation getTensorAt: anAttributeName 
]

{ #category : 'operation attribute' }
TensorFlowCAPI >> operation: aTFOperation getTypeAt: anAttributeName [

	
	^ platformLibrary operation: aTFOperation getTypeAt: anAttributeName
]

{ #category : 'operation' }
TensorFlowCAPI >> operationName: aTFOperation [

	
	^ platformLibrary operationName: aTFOperation 
]

{ #category : 'operation' }
TensorFlowCAPI >> operationNumInputs: aTFOperation [


	^ platformLibrary operationNumInputs: aTFOperation 
]

{ #category : 'operation' }
TensorFlowCAPI >> operationNumOutputs: aTFOperation [

	
	^ platformLibrary operationNumOutputs: aTFOperation 
]

{ #category : 'operation' }
TensorFlowCAPI >> operationOpType: aTFOperation [


	^ platformLibrary operationOpType: aTFOperation 
]

{ #category : 'operation' }
TensorFlowCAPI >> operationOutputType: aTFOutput [


	^ platformLibrary operationOutputType: aTFOutput 
]

{ #category : 'session' }
TensorFlowCAPI >> runSession: aTFSession [

	platformLibrary checkStatusAfter: [:status |
		platformLibrary
			runSession: aTFSession
			options: nil
			inputs: nil
			values: nil
			count: 0
			outputs: nil
			values: nil
			count: 0
			targets: nil
			count: 0
			metadata: nil
			status: status]
]

{ #category : 'session' }
TensorFlowCAPI >> runSession: aTFSession inputs: anArrayOfPlaceholders values: anArrayOfTensors outputs: anArrayOfOutputs [
	
	^ platformLibrary runSession: aTFSession inputs: anArrayOfPlaceholders values: anArrayOfTensors outputs: anArrayOfOutputs
]

{ #category : 'session' }
TensorFlowCAPI >> runSession: aTFSession operation: aTFOperation output: aTFOutput [

	
	^ platformLibrary runSession: aTFSession operation: aTFOperation output: aTFOutput 
]

{ #category : 'session' }
TensorFlowCAPI >> runSession: aTFSession operations: anArrayOfTFOperations [
	
	^ platformLibrary runSession: aTFSession operations: anArrayOfTFOperations
]

{ #category : 'session' }
TensorFlowCAPI >> runSession: aTFSession outputs: aTFOutputArray [

	
	^ platformLibrary runSession: aTFSession outputs: aTFOutputArray
]

{ #category : 'options' }
TensorFlowCAPI >> sessionOptions: aTFSessionOptions setConfig: aString [

	platformLibrary checkStatusAfter: [:status |
		platformLibrary
			sessionOptions: aTFSessionOptions
			setConfig: aString
			configSize: aString size
			status: status]
]

{ #category : 'options' }
TensorFlowCAPI >> sessionOptions: aTFSessionOptions setTarget: aString [

	platformLibrary sessionOptions: aTFSessionOptions setTarget: (platformLibrary externalizeString: aString)
]

{ #category : 'status' }
TensorFlowCAPI >> setStatus: aTFStatus code: aTFCode message: aString [

	| externalized |

	externalized := platformLibrary externalizeString: aString.
	^ platformLibrary setStatus: aTFStatus code: aTFCode message: externalized
]

{ #category : 'utils' }
TensorFlowCAPI >> sizeOfDataType: aSmallInteger [

	^ platformLibrary sizeOfDataType: aSmallInteger
]

{ #category : 'tensor' }
TensorFlowCAPI >> tensor: aTFTensor sizeOn: aDimension [

	^ platformLibrary tensor: aTFTensor sizeOn: aDimension
]

{ #category : 'tensor' }
TensorFlowCAPI >> tensorByteSize: aTFTensor [

	
	^ platformLibrary tensorByteSize: aTFTensor 
]

{ #category : 'tensor' }
TensorFlowCAPI >> tensorDataOf: aTFTensor [

	^platformLibrary tensorDataOf: aTFTensor
]

{ #category : 'tensor' }
TensorFlowCAPI >> tensorFromString: aString [


	^ platformLibrary tensorFromString: aString
]

{ #category : 'tensor' }
TensorFlowCAPI >> tensorFromStrings: anArray shaped: aTensorShape [


	^ platformLibrary tensorFromStrings: anArray shaped: aTensorShape 
]

{ #category : 'tensor' }
TensorFlowCAPI >> tensorRank: aTFTensor [

	^ platformLibrary tensorRank: aTFTensor
]

{ #category : 'tensor' }
TensorFlowCAPI >> tensorType: aTFTensor [

	^platformLibrary tensorType: aTFTensor
]

{ #category : 'utils' }
TensorFlowCAPI >> version [
	
	^ platformLibrary version
]
