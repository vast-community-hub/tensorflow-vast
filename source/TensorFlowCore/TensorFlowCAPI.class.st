Class {
	#name : 'TensorFlowCAPI',
	#superclass : 'Object',
	#instVars : [
		'library'
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

	
	^ library allocateTensorOf: aTensorDomain length: aSmallInteger 
]

{ #category : 'strings' }
TensorFlowCAPI >> allStringsOf: aTFTensor [

	^ library allStringsOf: aTFTensor
]

{ #category : 'deleting' }
TensorFlowCAPI >> closeSession: aTFSession [

	library checkStatusAfter: [:status | library closeSession: aTFSession status: status]
]

{ #category : 'buffer' }
TensorFlowCAPI >> deleteBuffer: aTFBuffer [

	^ library deleteBuffer: aTFBuffer
]

{ #category : 'device list' }
TensorFlowCAPI >> deleteDeviceList: aTFDeviceList [


	^ library deleteDeviceList: aTFDeviceList 
]

{ #category : 'deleting' }
TensorFlowCAPI >> deleteGraph: aTFGraph [

	^library deleteGraph: aTFGraph
]

{ #category : 'options' }
TensorFlowCAPI >> deleteImportGraphDefOptions: aTFImportGraphDefOptions [

	
	^ library deleteImportGraphDefOptions: aTFImportGraphDefOptions 
]

{ #category : 'deleting' }
TensorFlowCAPI >> deleteSession: aTFSession [

	library checkStatusAfter: [:status | library deleteSession: aTFSession status: status]
]

{ #category : 'deleting' }
TensorFlowCAPI >> deleteSessionOptions: aTFSessionOptions [

	^library deleteSessionOptions: aTFSessionOptions
]

{ #category : 'deleting' }
TensorFlowCAPI >> deleteStatus: aTFStatus [

	^library deleteStatus: aTFStatus
]

{ #category : 'deleting' }
TensorFlowCAPI >> deleteTensor: aTFTensor [

	^library deleteTensor: aTFTensor
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription addControlInput: aTFOperation [

	
	^ library description: aTFOperationDescription addControlInput: aTFOperation 
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription addInput: aTFOutput [

	
	^ library description: aTFOperationDescription addInput: aTFOutput 
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription addInputs: anArray [

	^ library description: aTFOperationDescription addInputs: anArray
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription set: anAttributeName toBool: aBoolean [
	
	^ library description: aTFOperationDescription set: anAttributeName toBool: aBoolean
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription set: anAttributeName toFloat: aFloat [

	
	^ library description: aTFOperationDescription set: anAttributeName toFloat: aFloat 
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription set: anAttributeName toInt64: anInteger [

	^ library description: aTFOperationDescription set: anAttributeName toInt64: anInteger
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription set: anAttributeName toInts: aListOfIntegers [

	^ library description: aTFOperationDescription set: anAttributeName toInts: aListOfIntegers
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription set: anAttributeName toShape: aTensorShape [

	^ library description: aTFOperationDescription set: anAttributeName toShape: aTensorShape
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription set: anAttributeName toShapes: aListOfShapes [


	library description: aTFOperationDescription set: anAttributeName toShapes: aListOfShapes
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription set: anAttributeName toString: aString [

	library checkStatusAfter: [:status |
		library
			description: aTFOperationDescription
			set: anAttributeName asAsciiZ
			toString: aString
			size: aString size]
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription set: anAttributeName toStrings: aStringCollection [

	
	^ library description: aTFOperationDescription set: anAttributeName toStrings: aStringCollection 
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription set: anAttributeName toTensor: aTFTensor [

	library checkStatusAfter: [:status |
		library
			description: aTFOperationDescription
			set: anAttributeName asAsciiZ
			toTensor: aTFTensor
			status: status]
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription set: anAttributeName toType: aTensorType [
	
	^ library description: aTFOperationDescription set: anAttributeName toType: aTensorType
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription set: anAttributeName toTypes: aListOfTypes [

	library description: aTFOperationDescription set: anAttributeName toTypes: aListOfTypes
]

{ #category : 'operation description' }
TensorFlowCAPI >> description: aTFOperationDescription setDevice: aString [


	^ library description: aTFOperationDescription setDevice: aString 
]

{ #category : 'device list' }
TensorFlowCAPI >> deviceList: aTFDeviceList incarnationAt: anIndex [

	^library checkStatusAfter: [:status |
		library deviceList: aTFDeviceList incarnationAt: anIndex status: status]
]

{ #category : 'device list' }
TensorFlowCAPI >> deviceList: aTFDeviceList memoryAt: anIndex [

	^library checkStatusAfter: [:status |
		library deviceList: aTFDeviceList memoryAt: anIndex status: status]
]

{ #category : 'device list' }
TensorFlowCAPI >> deviceList: aTFDeviceList nameAt: anIndex [

	^library checkStatusAfter: [:status |
		library deviceList: aTFDeviceList nameAt: anIndex status: status]
]

{ #category : 'device list' }
TensorFlowCAPI >> deviceList: aTFDeviceList typeAt: anIndex [

	^library checkStatusAfter: [:status |
		library deviceList: aTFDeviceList typeAt: anIndex status: status]
]

{ #category : 'device list' }
TensorFlowCAPI >> deviceListCount: aTFDeviceList [

	^library deviceListCount: aTFDeviceList
]

{ #category : 'device list' }
TensorFlowCAPI >> deviceListForSession: aTFSession [

	^library checkStatusAfter: [:status | library deviceListForSession: aTFSession status: status]
]

{ #category : 'strings' }
TensorFlowCAPI >> externalizeString: aString [

	
	^ library externalizeString: aString 
]

{ #category : 'operation' }
TensorFlowCAPI >> finishOperation: aTFOperationDescription [

	^library checkStatusAfter: [:status | | answer |
		answer := library finishOperation: aTFOperationDescription status: status.
		aTFOperationDescription makeNull.
		answer]
]

{ #category : 'graph' }
TensorFlowCAPI >> forGraph: aTFGraph outputDims: aTFOutput [

	^library
		checkStatusAfter: [:status | library forGraph: aTFGraph outputDims: aTFOutput status: status]
]

{ #category : 'utils' }
TensorFlowCAPI >> getAllOps [
	
	^ library getAllOps
]

{ #category : 'initialization' }
TensorFlowCAPI >> getCodeOf: aTFStatus [

	^library getCode: aTFStatus
]

{ #category : 'gradients' }
TensorFlowCAPI >> gradientsOf: yArrayOfTFOutput withRespectTo: xArrayOfTFOutput product: dxArrayOfOutput in: aTFGraph [

	^ library
		gradientsOf: yArrayOfTFOutput
		withRespectTo: xArrayOfTFOutput
		product: dxArrayOfOutput
		in: aTFGraph
]

{ #category : 'graph' }
TensorFlowCAPI >> graph: aTFGraph getOperationNamed: anOperationName [
	
		^ library graph: aTFGraph getOperationNamed: anOperationName
]

{ #category : 'graph' }
TensorFlowCAPI >> graph: aTFGraph getRankOf: aTFOutputOrInput [

	^library checkStatusAfter: [:status |
		library graph: aTFGraph getRankOf: aTFOutputOrInput status: status]
]

{ #category : 'graph' }
TensorFlowCAPI >> graph: aTFGraph getShapeOf: aTFOutput [

	
	^ library graph: aTFGraph getShapeOf: aTFOutput 
]

{ #category : 'graph' }
TensorFlowCAPI >> graph: aTFGraph operationAt: contextULongLongPtr [

	^library graph: aTFGraph operationAt: contextULongLongPtr
]

{ #category : 'graph' }
TensorFlowCAPI >> graph: aTFGraph setShapeOf: aTFOutput to: aShape [


	^ library graph: aTFGraph setShapeOf: aTFOutput to: aShape 
]

{ #category : 'graph' }
TensorFlowCAPI >> graphDefinitionOf: aTFGraph [

	"Return the protobuff serialisation of the graph"

	| buffer |

	buffer := TFBuffer new.
	library checkStatusAfter: [:status | library graph: aTFGraph toGraphDef: buffer status: status].
	^buffer dataBytes asString
]

{ #category : 'graph' }
TensorFlowCAPI >> importGraphDefFrom: aTFBuffer into: aTFGraph [

	library checkStatusAfter: [:status | | options |
		options := TFImportGraphDefOptions create.
		library importGraphDefInto: aTFGraph from: aTFBuffer options: options status: status.
		options delete]
]

{ #category : 'initialization',
  #vaVisibility : 'private' }
TensorFlowCAPI >> initializeWrapping: aTensorFlowPharoLibrary [

	
	library := aTensorFlowPharoLibrary 
]

{ #category : 'status' }
TensorFlowCAPI >> message: aTFStatus [


	^ library message: aTFStatus 
]

{ #category : 'session' }
TensorFlowCAPI >> newAutoreleaseSessionOn: aTFGraph [


	^ library newAutoreleaseSessionOn: aTFGraph
]

{ #category : 'options' }
TensorFlowCAPI >> newAutoreleaseSessionOptions [
	
	^ library newAutoreleaseSessionOptions
	
]

{ #category : 'status' }
TensorFlowCAPI >> newAutoreleaseStatus [

	^library newAutoreleaseStatus
]

{ #category : 'buffer' }
TensorFlowCAPI >> newBuffer [

	^ library newBuffer
]

{ #category : 'buffer' }
TensorFlowCAPI >> newBufferFromString: aString [

	
	^ library newBufferFromString: aString size: aString size 
]

{ #category : 'graph' }
TensorFlowCAPI >> newGraph [
	
	^ library newGraph 
]

{ #category : 'options' }
TensorFlowCAPI >> newImportGraphDefOptions [
	
	^ library newImportGraphDefOptions
]

{ #category : 'operation description' }
TensorFlowCAPI >> newOperationDescriptionOn: aTFGraph type: aTensorType named: anOperationName [
	
	^ library newOperationDescriptionOn: aTFGraph type: aTensorType named: anOperationName
]

{ #category : 'status' }
TensorFlowCAPI >> newPersistentStatus [
	
	^ library newPersistentStatus
]

{ #category : 'options' }
TensorFlowCAPI >> newSessionOptions [
	
	^ library newSessionOptions
]

{ #category : 'status' }
TensorFlowCAPI >> newStatus [
	
	^ library newStatus
]

{ #category : 'operation attribute' }
TensorFlowCAPI >> operation: aTFOperation getBoolAt: anAttributeName [

	^ library operation: aTFOperation getBoolAt: anAttributeName
]

{ #category : 'operation attribute' }
TensorFlowCAPI >> operation: aTFOperation getFloatAt: anAttributeName [

	^ library operation: aTFOperation getFloatAt: anAttributeName
]

{ #category : 'operation attribute' }
TensorFlowCAPI >> operation: aTFOperation getInt64At: anAttributeName [


	^library operation: aTFOperation getInt64At: anAttributeName
]

{ #category : 'operation attribute' }
TensorFlowCAPI >> operation: aTFOperation getMetadataFor: anAttributeName [

	
	^  library operation: aTFOperation getMetadataFor: anAttributeName
]

{ #category : 'operation attribute' }
TensorFlowCAPI >> operation: aTFOperation getShapeAt: anAttributeName [

	^ library operation: aTFOperation getShapeAt: anAttributeName
]

{ #category : 'operation attribute' }
TensorFlowCAPI >> operation: aTFOperation getStringAt: anAttributeName [

	^ library operation: aTFOperation getStringAt: anAttributeName
]

{ #category : 'operation attribute' }
TensorFlowCAPI >> operation: aTFOperation getStringsAt: anAttributeName [

	^ library operation: aTFOperation getStringsAt: anAttributeName
]

{ #category : 'operation attribute' }
TensorFlowCAPI >> operation: aTFOperation getTensorAt: anAttributeName [


	^ library operation: aTFOperation getTensorAt: anAttributeName 
]

{ #category : 'operation attribute' }
TensorFlowCAPI >> operation: aTFOperation getTypeAt: anAttributeName [

	
	^ library operation: aTFOperation getTypeAt: anAttributeName
]

{ #category : 'operation' }
TensorFlowCAPI >> operationName: aTFOperation [

	
	^ library operationName: aTFOperation 
]

{ #category : 'operation' }
TensorFlowCAPI >> operationNumInputs: aTFOperation [


	^ library operationNumInputs: aTFOperation 
]

{ #category : 'operation' }
TensorFlowCAPI >> operationNumOutputs: aTFOperation [

	
	^ library operationNumOutputs: aTFOperation 
]

{ #category : 'operation' }
TensorFlowCAPI >> operationOpType: aTFOperation [


	^ library operationOpType: aTFOperation 
]

{ #category : 'operation' }
TensorFlowCAPI >> operationOutputType: aTFOutput [


	^ library operationOutputType: aTFOutput 
]

{ #category : 'session' }
TensorFlowCAPI >> runSession: aTFSession [

	library checkStatusAfter: [:status |
		library
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
	
	^ library runSession: aTFSession inputs: anArrayOfPlaceholders values: anArrayOfTensors outputs: anArrayOfOutputs
]

{ #category : 'session' }
TensorFlowCAPI >> runSession: aTFSession operation: aTFOperation output: aTFOutput [

	
	^ library runSession: aTFSession operation: aTFOperation output: aTFOutput 
]

{ #category : 'session' }
TensorFlowCAPI >> runSession: aTFSession operations: anArrayOfTFOperations [
	
	^ library runSession: aTFSession operations: anArrayOfTFOperations
]

{ #category : 'session' }
TensorFlowCAPI >> runSession: aTFSession outputs: aTFOutputArray [

	
	^ library runSession: aTFSession outputs: aTFOutputArray
]

{ #category : 'options' }
TensorFlowCAPI >> sessionOptions: aTFSessionOptions setConfig: aString [

	library checkStatusAfter: [:status |
		library
			sessionOptions: aTFSessionOptions
			setConfig: aString
			configSize: aString size
			status: status]
]

{ #category : 'options' }
TensorFlowCAPI >> sessionOptions: aTFSessionOptions setTarget: aString [

	library sessionOptions: aTFSessionOptions setTarget: (library externalizeString: aString)
]

{ #category : 'status' }
TensorFlowCAPI >> setStatus: aTFStatus code: aTFCode message: aString [

	| externalized |

	externalized := library externalizeString: aString.
	^ library setStatus: aTFStatus code: aTFCode message: externalized
]

{ #category : 'utils' }
TensorFlowCAPI >> sizeOfDataType: aSmallInteger [

	^ library sizeOfDataType: aSmallInteger
]

{ #category : 'tensor' }
TensorFlowCAPI >> tensor: aTFTensor sizeOn: aDimension [

	^ library tensor: aTFTensor sizeOn: aDimension
]

{ #category : 'tensor' }
TensorFlowCAPI >> tensorByteSize: aTFTensor [

	
	^ library tensorByteSize: aTFTensor 
]

{ #category : 'tensor' }
TensorFlowCAPI >> tensorDataOf: aTFTensor [

	^library tensorDataOf: aTFTensor
]

{ #category : 'tensor' }
TensorFlowCAPI >> tensorFromString: aString [


	^ library tensorFromString: aString
]

{ #category : 'tensor' }
TensorFlowCAPI >> tensorFromStrings: anArray shaped: aTensorShape [


	^ library tensorFromStrings: anArray shaped: aTensorShape 
]

{ #category : 'tensor' }
TensorFlowCAPI >> tensorRank: aTFTensor [

	^ library tensorRank: aTFTensor
]

{ #category : 'tensor' }
TensorFlowCAPI >> tensorType: aTFTensor [

	^library tensorType: aTFTensor
]

{ #category : 'utils' }
TensorFlowCAPI >> version [
	
	^ library version
]
