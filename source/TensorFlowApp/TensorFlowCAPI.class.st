Class {
	#name : 'TensorFlowCAPI',
	#superclass : 'ExternalLibrary',
	#classInstVars : [
		'current'
	],
	#category : 'TensorFlowApp'
}

{
	#category : 'Not categorized'
}
TensorFlowCAPI class >> current [
	^ current ifNil: [ current := self new ]
]

{
	#category : 'Not categorized'
}
TensorFlowCAPI class >> dispatcher [
	"Get a handle on the dispatcher"

	^TFLibraryDispatcher default
]

{
	#category : 'Not categorized'
}
TensorFlowCAPI class >> moduleName [
	^ 'libtensorflow'
]

{
	#category : 'instance creation'
}
TensorFlowCAPI class >> new [

	^super new initialize
]

{
	#category : 'tensor'
}
TensorFlowCAPI >> allocateTensorType: anInteger shape: aLonnLongArray rank: dimCount length: len [
	| address |
	address := self dispatcher callTF_AllocateTensorWith: anInteger with: aLonnLongArray with: dimCount with: len.
	^ TFTensor address: address
]

{
	#category : 'session'
}
TensorFlowCAPI >> closeSession: aTFSession status: aTFStatus [
	^ self dispatcher callTF_CloseSessionWith: aTFSession with: aTFStatus
	
]

{
	#category : 'buffer'
}
TensorFlowCAPI >> deleteBuffer: aTFBuffer [
	^ self dispatcher callTF_DeleteBufferWith: aTFBuffer
]

{
	#category : 'device list'
}
TensorFlowCAPI >> deleteDeviceList: aTFDeviceList [
	^ self dispatcher callTF_DeleteDeviceListWith: aTFDeviceList
]

{
	#category : 'graph'
}
TensorFlowCAPI >> deleteGraph: aTFGraph [
	^ self dispatcher callTF_DeleteGraphWith: aTFGraph
]

{
	#category : 'options'
}
TensorFlowCAPI >> deleteImportGraphDefOptions: aTFImportGraphDefOptions [
	^ self dispatcher callTF_DeleteImportGraphDefOptionsWith: aTFImportGraphDefOptions
]

{
	#category : 'session'
}
TensorFlowCAPI >> deleteSession: aTFSession status: aTFStatus [
	^ self dispatcher callTF_DeleteSessionWith: aTFSession with: aTFStatus

]

{
	#category : 'options'
}
TensorFlowCAPI >> deleteSessionOptions: aTFSessionOptions [
	^ self dispatcher callTF_DeleteSessionOptionsWith: aTFSessionOptions
]

{
	#category : 'status'
}
TensorFlowCAPI >> deleteStatus: aTFStatus [
	^ self dispatcher callTF_DeleteStatusWith: aTFStatus
]

{
	#category : 'tensor'
}
TensorFlowCAPI >> deleteTensor: aTFTensor [
	^ self dispatcher callTF_DeleteTensorWith: aTFTensor
]

{
	#category : 'operation description'
}
TensorFlowCAPI >> description: aTFOperationDescription addControlInput: aTFOutputOrOperation [
	"	old version:
			void 'TF_AddControlInput' (TFOperationDescription* TFOutput)
		new version:
			void 'TF_AddControlInput' (TFOperationDescription* *TFOperation)"
	| operation |
	(aTFOutputOrOperation isKindOf: TFOutput)
		ifTrue: [
			self halt: 'Deprecated interface: The second argument type has changed from TFOutput to *TFOperation'.
			operation := aTFOutputOrOperation operation.
			operation := TFOperation address: operation.
		] ifFalse: [
			operation := aTFOutputOrOperation].
	^ self dispatcher callTF_AddControlInputWith: aTFOperationDescription with: operation
]

{
	#category : 'operation description'
}
TensorFlowCAPI >> description: aTFOperationDescription addInput: aTFOutput [
	^ self dispatcher callTF_AddInputWith: aTFOperationDescription with: aTFOutput
]

{
	#category : 'operation description'
}
TensorFlowCAPI >> description: aTFOperationDescription addInputs: aTFOutputArray size: anInteger [
	^ self dispatcher callTF_AddInputListWith: aTFOperationDescription with: aTFOutputArray with: anInteger
]

{
	#category : 'operation description'
}
TensorFlowCAPI >> description: aTFOperationDescription set: aString toBool: anInt [
	^ self dispatcher callTF_SetAttrBoolWith: aTFOperationDescription with: aString with: anInt
]

{
	#category : 'operation description'
}
TensorFlowCAPI >> description: aTFOperationDescription set: aString toFloat: valueFloat [
	"	<cdecl: void 'TF_SetAttrFloat' (TFOperationDescription* char* float)>"
	^ self dispatcher callTF_SetAttrFloatWith: aTFOperationDescription with: aString with: valueFloat
]

{
	#category : 'operation description'
}
TensorFlowCAPI >> description: aTFOperationDescription set: aString toInt64: anInt [
	^ self dispatcher callTF_SetAttrIntWith: aTFOperationDescription with: aString with: anInt
]

{
	#category : 'operation description'
}
TensorFlowCAPI >> description: aTFOperationDescription set: aString toShape: anInt64Array size: size [
	^ self dispatcher callTF_SetAttrShapeWith: aTFOperationDescription with: aString with: anInt64Array with: size
]

{
	#category : 'operation description'
}
TensorFlowCAPI >> description: aTFOperationDescription set: nameString toString: valueString size: size [
	"	<cdecl: void 'TF_SetAttrString' (TFOperationDescription* char* char* ulonglong)>"
	^ self dispatcher callTF_SetAttrStringWith: aTFOperationDescription with: nameString with: valueString with: size
]

{
	#category : 'operation description'
}
TensorFlowCAPI >> description: aTFOperationDescription set: aString toStrings: anArrayOfString sizes: sizes count: count [
	"	<cdecl: void 'TF_SetAttrStringList' (TFOperationDescription* char* void* Int64Array* longlong)>"
	^ self dispatcher callTF_SetAttrStringListWith: aTFOperationDescription with: aString with: anArrayOfString with: sizes with: count
]

{
	#category : 'operation description'
}
TensorFlowCAPI >> description: aTFOperationDescription set: aString toTensor: aTFTensor status: aTFStatus [
	^ self dispatcher callTF_SetAttrTensorWith: aTFOperationDescription with: aString with: aTFTensor with: aTFStatus

]

{
	#category : 'operation description'
}
TensorFlowCAPI >> description: aTFOperationDescription set: aString toType: anInt [
	^ self dispatcher callTF_SetAttrTypeWith: aTFOperationDescription with: aString  with: anInt

]

{
	#category : 'operation description'
}
TensorFlowCAPI >> description: aTFOperationDescription setDevice: aString [
	"	<cdecl: void 'TF_SetDevice' (TFOperationDescription* char*)>"
	^ self dispatcher callTF_SetDeviceWith: aTFOperationDescription with: aString
]

{
	#category : 'device list'
}
TensorFlowCAPI >> deviceList: aDeviceList incarnationAt: anInteger status: aTFStatus [
	" char* TF_DeviceListIncarnation(const TF_DeviceList* list, int index, TF_Status* status) "

	^ self dispatcher callTF_DeviceListIncarnationWith: aDeviceList with: anInteger with: aTFStatus.
]

{
	#category : 'device list'
}
TensorFlowCAPI >> deviceList: aDeviceList memoryAt: anInteger status: aTFStatus [
	" char* TF_DeviceListMemoryBytes(const TF_DeviceList* list, int index, TF_Status* status) "

	^ self dispatcher callTF_DeviceListMemoryBytesWith: aDeviceList with: anInteger with: aTFStatus.
]

{
	#category : 'device list'
}
TensorFlowCAPI >> deviceList: aDeviceList nameAt: anInteger status: aTFStatus [
	" char* TF_DeviceListName(const TF_DeviceList* list, int index, TF_Status* status) "
	| answer |

	answer := self dispatcher callTF_DeviceListNameWith: aDeviceList with: anInteger with: aTFStatus.
	^ (OSStringZ address: answer) asString
]

{
	#category : 'device list'
}
TensorFlowCAPI >> deviceList: aDeviceList typeAt: anInteger status: aTFStatus [
	" char* TF_DeviceListType(const TF_DeviceList* list, int index, TF_Status* status) "
	| answer |

	answer := self dispatcher callTF_DeviceListTypeWith: aDeviceList with: anInteger with: aTFStatus.
	^ (OSStringZ address: answer) asString
]

{
	#category : 'device list'
}
TensorFlowCAPI >> deviceListCount: aTFDeviceList [
	^ self dispatcher callTF_DeviceListCountWith: aTFDeviceList

]

{
	#category : 'device list'
}
TensorFlowCAPI >> deviceListForSession: aTFSession status: aTFStatus [
	" TF_DeviceList* TF_SessionListDevices(TF_Session* session, TF_Status* status);"
	
	| answer |

	answer := self dispatcher callTF_SessionListDevicesWith: aTFSession with: aTFStatus.
	^ TFDeviceList address: answer
]

{
	#category : 'utils'
}
TensorFlowCAPI >> dispatcher [
	^self class dispatcher
]

{
	#category : 'utils'
}
TensorFlowCAPI >> externalizeString: aString [
	^ aString copyToOSMemory
]

{
	#category : 'operation description'
}
TensorFlowCAPI >> finishOperation: aTFOperationDescription status: aTFStatus [
	| answer |
	answer := self
		finishOperationAsVoid: aTFOperationDescription
		status: aTFStatus.
	^ TFOperation address: answer
]

{
	#category : 'operation description'
}
TensorFlowCAPI >> finishOperationAsVoid: aTFOperationDescription status: aTFStatus [
	^ self dispatcher callTF_FinishOperationWith: aTFOperationDescription with: aTFStatus.

]

{
	#category : 'operation'
}
TensorFlowCAPI >> forGraph: aTFGraph outputDims: aTFOutput status: aTFStatus [
	^ self dispatcher callTF_GraphGetTensorNumDimsWith: aTFGraph with: aTFOutput with: aTFStatus
]

{
	#category : 'utils'
}
TensorFlowCAPI >> getAllOps [
	^ TFBuffer address: self dispatcher callTF_GetAllOpList
]

{
	#category : 'status'
}
TensorFlowCAPI >> getCode: aTFStatus [
	^self dispatcher callTF_GetCodeWith: aTFStatus
]

{
	#category : 'graph'
}
TensorFlowCAPI >> graph: aTFGraph getOperationNamed: aString [
	| answer |
	answer := self graph: aTFGraph getOperationNamedAsVoid: aString.
	answer := TFOperation address: answer.
	answer graph: aTFGraph.
	^ answer
]

{
	#category : 'graph'
}
TensorFlowCAPI >> graph: aTFGraph getOperationNamedAsVoid: aString [
	^ self dispatcher callTF_GraphOperationByNameWith: aTFGraph with: aString
]

{
	#category : 'graph'
}
TensorFlowCAPI >> graph: aTFGraph getRankOf: aTFOutputOrInput status: status [
	^ self dispatcher callTF_GraphGetTensorNumDimsWith: aTFGraph with: aTFOutputOrInput with: status
]

{
	#category : 'graph'
}
TensorFlowCAPI >> graph: aTFGraph getShapeOf: aTFOutputOrInput into: anInt64Array size: anInteger status: status [
	^ self dispatcher callTF_GraphGetTensorShapeWith: aTFGraph with: aTFOutputOrInput with: anInt64Array with: anInteger with: status
]

{
	#category : 'operation'
}
TensorFlowCAPI >> graph: aTFGraph operationAt: contextULongLongPtr [
	| answer |
	answer := self graph: aTFGraph operationAtAsVoid: contextULongLongPtr.
	answer := TFOperation address: answer.
	answer graph: aTFGraph.
	^ answer
]

{
	#category : 'operation'
}
TensorFlowCAPI >> graph: aTFGraph operationAtAsVoid: contextULongLongPtr [
	^ self dispatcher callTF_GraphNextOperationWith: aTFGraph with: contextULongLongPtr
]

{
	#category : 'graph'
}
TensorFlowCAPI >> graph: aTFGraph setShapeOf: aTFOutputOrInput to: anInt64Array size: anInteger status: status [
	"	<cdecl: void 'TF_GraphSetTensorShape' (TFGraph* TFOutput Int64Array* ulonglong TFStatus*)>"
	^ self dispatcher callTF_GraphSetTensorShapeWith: aTFGraph with: aTFOutputOrInput with: anInt64Array with: anInteger with: status
]

{
	#category : 'graph'
}
TensorFlowCAPI >> graph: aTFGraph toGraphDef: aTFBuffer status: aTFStatus [
	^ self dispatcher callTF_GraphToGraphDefWith: aTFGraph with: aTFBuffer with: aTFStatus
]

{
	#category : 'graph'
}
TensorFlowCAPI >> graph: aTFGraph y: yTFOutputArray yCount: yCount x: xTFOutputArray xCount: xCount dx: dxTFOutputArray status: aTFStatus [

]

{
	#category : 'graph'
}
TensorFlowCAPI >> graph: aTFGraph y: yTFOutputArray yCount: yCount x: xTFOutputArray xCount: xCount dx: dxTFOutputArray status: aTFStatus into: dyTFOutputArray [
	" void TF_AddGradients(TF_Graph* g, TF_Output* y, int ny,
						   TF_Output* x, int nx, TF_Output* dx,
						   TF_Status* status, TF_Output* dy); "
	^ self dispatcher
		callTF_AddGradientsWith: aTFGraph
		with: yTFOutputArray with: yCount
		with: xTFOutputArray with: xCount
		with: dxTFOutputArray
		with: aTFStatus
		with: dyTFOutputArray
]

{
	#category : 'graph'
}
TensorFlowCAPI >> importGraphDefInto: aTFGraph from: aTFBuffer options: aTFImportGraphDefOptions status: aTFStatus [
	^ self dispatcher
		callTF_GraphImportGraphDefWith: aTFGraph
		with: aTFBuffer
		with: aTFImportGraphDefOptions
		with: aTFStatus

]

{
	#category : 'status'
}
TensorFlowCAPI >> message: aTFStatus [
	^(OSStringZ address: (self dispatcher callTF_MessageWith: aTFStatus)) asString
]

{
	#category : 'buffer'
}
TensorFlowCAPI >> newBufferFromString: aString size: anInteger [
	^ TFBuffer address: (self dispatcher callTF_NewBufferFromStringWith: aString with: anInteger)
]

{
	#category : 'graph'
}
TensorFlowCAPI >> newGraph [
	^ TFGraph address: self dispatcher callTF_NewGraph
]

{
	#category : 'options'
}
TensorFlowCAPI >> newImportGraphDefOptions [
	^ TFImportGraphDefOptions address: self dispatcher callTF_NewImportGraphDefOptions
]

{
	#category : 'operation'
}
TensorFlowCAPI >> newOperationDescriptionOn: graph type: type named: name [
	| address |
	address := self dispatcher callTF_NewOperationWith: graph with: type with: name.
	^ TFOperationDescription address: address
]

{
	#category : 'session'
}
TensorFlowCAPI >> newSession: aTFGraph options: aTFSessionOptions status: aTFStatus [
	| answer |
	answer := self dispatcher callTF_NewSessionWith: aTFGraph with: aTFSessionOptions with: aTFStatus. 
	^ TFSession address: answer.
	
]

{
	#category : 'options'
}
TensorFlowCAPI >> newSessionOptions [
	^ TFSessionOptions address: (self dispatcher callTF_NewSessionOptions)
]

{
	#category : 'status'
}
TensorFlowCAPI >> newStatus [
	^TFStatus address: (self dispatcher callTF_NewStatus)
]

{
	#category : 'operation'
}
TensorFlowCAPI >> operation: aTFOperation attr: nameZString getBool: valueBoolPtr status: status [
	^ self dispatcher callTF_OperationGetAttrBoolWith: aTFOperation with: nameZString with: valueBoolPtr address with: status
]

{
	#category : 'operation'
}
TensorFlowCAPI >> operation: aTFOperation attr: nameZString getFloat: valueFloatPtr status: status [
	^ self dispatcher callTF_OperationGetAttrFloatWith: aTFOperation with: nameZString with: valueFloatPtr with: status
]

{
	#category : 'operation'
}
TensorFlowCAPI >> operation: aTFOperation attr: nameZString getInt64: valueLongPtr status: status [
	^ self dispatcher callTF_OperationGetAttrIntWith: aTFOperation with: nameZString with: valueLongPtr with: status
]

{
	#category : 'operation'
}
TensorFlowCAPI >> operation: aTFOperation attr: nameZString getShape: int64array size: maxSize status: status [
	"	<cdecl: void 'TF_OperationGetAttrShape' (TFOperation* char* Int64Array* ulonglong TFStatus*)>"
	^ self dispatcher callTF_OperationGetAttrShapeWith: aTFOperation with: nameZString with: int64array with: maxSize with: status
]

{
	#category : 'operation'
}
TensorFlowCAPI >> operation: aTFOperation attr: nameZString getString: valueString size: maxSize status: status [
	"	<cdecl: void 'TF_OperationGetAttrString' (TFOperation* char* void* ulonglong TFStatus*)>"
	^ self dispatcher callTF_OperationGetAttrStringWith: aTFOperation with: nameZString with: valueString with: maxSize with: status
]

{
	#category : 'operation'
}
TensorFlowCAPI >> operation: aTFOperation attr: nameZString getStrings: valueStringArray sizes: sizesArray maxCount: maxCount storage: aBytaArray size: storageSize status: status [
	"	<cdecl: void 'TF_OperationGetAttrStringList' (TFOperation* char* void* Int64Array* ulonglong void* size_t TFStatus*)>"
	^ self dispatcher callTF_OperationGetAttrStringListWith: aTFOperation with: nameZString with: valueStringArray with: sizesArray with: maxCount with: aBytaArray with: storageSize with: status
]

{
	#category : 'operation'
}
TensorFlowCAPI >> operation: aTFOperation attr: nameZString getTensor: valueLongPtr status: status [
	"	<cdecl: void 'TF_OperationGetAttrTensor' (TFOperation* char* void* TFStatus*)>"
	^ self dispatcher callTF_OperationGetAttrTensorWith: aTFOperation with: nameZString with: valueLongPtr with: status
]

{
	#category : 'operation'
}
TensorFlowCAPI >> operation: aTFOperation attr: nameZString getType: valueLongPtr status: status [
	"	<cdecl: void 'TF_OperationGetAttrType' (TFOperation* char* ulonglong* TFStatus*)>"
	^ self dispatcher callTF_OperationGetAttrTypeWith: aTFOperation with: nameZString with: valueLongPtr with: status
]

{
	#category : 'operation'
}
TensorFlowCAPI >> operation: aTFOperation getMetadataFor: nameZString status: status [
	"	<cdecl: TFAttrMetadata 'TF_OperationGetAttrMetadata' (TFOperation* char* TFStatus*)>"
	^ self dispatcher callTF_OperationGetAttrMetadataWith: aTFOperation with: nameZString with: status
]

{
	#category : 'operation'
}
TensorFlowCAPI >> operationDevice: aTFOperation [
	"	<cdecl: char* 'TF_OperationDevice' (TFOperation*)>"
	^ self dispatcher callTF_OperationDeviceWith: aTFOperation
]

{
	#category : 'operation'
}
TensorFlowCAPI >> operationName: aTFOperation [
	| address |
	address := self dispatcher callTF_OperationNameWith: aTFOperation.
	^ (OSStringZ address: address) asString
]

{
	#category : 'operation'
}
TensorFlowCAPI >> operationNumInputs: aTFOperation [
	^ self dispatcher callTF_OperationNumInputsWith: aTFOperation
]

{
	#category : 'operation'
}
TensorFlowCAPI >> operationNumOutputs: aTFOperation [
	^ self dispatcher callTF_OperationNumOutputsWith: aTFOperation
]

{
	#category : 'operation'
}
TensorFlowCAPI >> operationOpType: aTFOperation [
	| address |
	address := self dispatcher callTF_OperationOpTypeWith: aTFOperation.
	^ (OSStringZ address: address) asString
]

{
	#category : 'operation'
}
TensorFlowCAPI >> operationOutputType: aTFOutput [
	^ self dispatcher callTF_OperationOutputTypeWith: aTFOutput
]

{
	#category : 'strings'
}
TensorFlowCAPI >> primStringEncodedSize: anInteger [
	^ self dispatcher callTF_StringEncodedSizeWith:anInteger
]

{
	#category : 'session'
}
TensorFlowCAPI >> runSession: aTFSession options: runOptionsTFBufferOrNil inputs: inTFOutputArray values: inTFTensorArray count: inCount outputs: outTFOutputArray values: outTFTensorArrayPtr count: outCount targets: targetTFOperationArrayOrNil count: targetCount metadata: metadataTFBuffer status: aTFStatus [
	"	<cdecl: void 'TF_SessionRun' (
		TFSession* TFBuffer*
		TFOutputArray* TFTensorPtrArray* long
		TFOutputArray* TFTensorPtrArray* long
		TFOperationPtrArray* long	
		TFBuffer*
		TFStatus*)>"
		^ self dispatcher
			callTF_SessionRunWith: aTFSession
			with: runOptionsTFBufferOrNil
			with: inTFOutputArray with: inTFTensorArray with: inCount 
			with: outTFOutputArray with: outTFTensorArrayPtr with: outCount
			with: targetTFOperationArrayOrNil with: targetCount
			with: metadataTFBuffer
			with: aTFStatus
]

{
	#category : 'options'
}
TensorFlowCAPI >> sessionOptions: aTFSessionOptions setConfig: aByteObject configSize: anInteger status: aTFStatus [
	self dispatcher callTF_SetConfigWith: aTFSessionOptions with: aByteObject with: anInteger with: aTFStatus.
]

{
	#category : 'options'
}
TensorFlowCAPI >> sessionOptions: aTFSessionOptions setTarget: anExternalString [
	^self dispatcher callTF_SetTargetWith: aTFSessionOptions with: anExternalString
]

{
	#category : 'status'
}
TensorFlowCAPI >> setStatus: aTFStatus code: anInteger message: anExternalString [
	^ self dispatcher callTF_SetStatusWith: aTFStatus with: anInteger with: anExternalString
]

{
	#category : 'strings'
}
TensorFlowCAPI >> stringDecode: src [
	| destination status answer dstSize |
	destination := ByteArray new: 8.
	dstSize := ByteArray new: 8.
	status := TFStatus create.
	answer := self
		stringDecode: src
		len: src size
		destination: destination
		len: dstSize
		status: status.
	status check.
	dstSize := dstSize uint64At: 0.
	destination := OSPtr address: (destination pointerAt: 0).
	answer := destination memcpyStringFrom: 0 to: dstSize - 1.
	^ answer
]

{
	#category : 'strings'
}
TensorFlowCAPI >> stringDecode: srcString len: srcLen destination: dstPointer len: dstLenPointer status: status [
	"	<cdecl: ulonglong 'TF_StringDecode' (char* ulonglong char* ulonglong* TFStatus)>"
	^ self dispatcher callTF_StringDecodeWith: srcString with: srcLen with: dstPointer with: dstLenPointer with: status
]

{
	#category : 'strings'
}
TensorFlowCAPI >> stringEncode: srcString len: srcLen destination: dstString len: dstLen status: status [
	"	<cdecl: ulonglong 'TF_StringEncode' (char* ulonglong char* ulonglong TFStatus)>"
	^ self dispatcher callTF_StringEncodeWith: srcString with: srcLen with: dstString with: dstLen with: status
]

{
	#category : 'strings'
}
TensorFlowCAPI >> stringEncode: src to: dst [
	^ self stringEncode: src to: dst size: dst size
]

{
	#category : 'strings'
}
TensorFlowCAPI >> stringEncode: src to: dst size: dstSize [
	| status answer |
	status := TFStatus create.
	answer := self
		stringEncode: src
		len: src size
		destination: dst
		len: dstSize
		status: status.
	status check.
	^ answer
]

{
	#category : 'strings'
}
TensorFlowCAPI >> stringEncodedSize: aString [
	^ self primStringEncodedSize: aString size
]

{
	#category : 'tensor'
}
TensorFlowCAPI >> tensor: aTFTensor sizeOn: dimension [
	^ self dispatcher callTF_DimWith: aTFTensor  with: dimension
]

{
	#category : 'tensor'
}
TensorFlowCAPI >> tensorByteSize: aTFTensor [
	^ self dispatcher callTF_TensorByteSizeWith: aTFTensor
]

{
	#category : 'tensor'
}
TensorFlowCAPI >> tensorData: aTFTensor [
	"	<cdecl: void* 'TF_TensorData' (TFTensor*)>"
	^ self dispatcher callTF_TensorDataWith: aTFTensor
]

{
	#category : 'tensor'
}
TensorFlowCAPI >> tensorRank: aTFTensor [
	^ self dispatcher callTF_NumDimsWith: aTFTensor
]

{
	#category : 'tensor'
}
TensorFlowCAPI >> tensorType: aTFTensor [
	"	<cdecl: ulonglong 'TF_TensorType' (TFTensor*)>"
	^ self dispatcher callTF_TensorTypeWith: aTFTensor
]

{
	#category : 'utils'
}
TensorFlowCAPI >> version [
	#fixme. #repeated.
	^ self dispatcher callTF_Version
]
