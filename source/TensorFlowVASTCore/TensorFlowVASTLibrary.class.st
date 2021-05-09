Class {
	#name : 'TensorFlowVASTLibrary',
	#superclass : 'Object',
	#classInstVars : [
		'current'
	],
	#category : 'TensorFlowVASTCore'
}

{ #category : 'Accessing' }
TensorFlowVASTLibrary class >> current [
	^ current ifNil: [ current := self new ]
]

{ #category : 'Accessing' }
TensorFlowVASTLibrary class >> dispatcher [
	"Get a handle on the dispatcher"

	^TFLibraryDispatcher default
]

{ #category : 'instance creation' }
TensorFlowVASTLibrary class >> initializeAfterLoad [

	TensorFlowCAPI setCurrentPlatformLibraryTo: self current
]

{ #category : 'Accessing' }
TensorFlowVASTLibrary class >> moduleName [
	^ 'libtensorflow'
]

{ #category : 'instance creation' }
TensorFlowVASTLibrary class >> new [

	^super new initialize
]

{ #category : 'tensor' }
TensorFlowVASTLibrary >> allocateTensorOf: aTensorDomain length: aLenght [

	| externalized answer |

	externalized := Int64Array externalFromArray: aTensorDomain shape dimensionSizes.
	answer :=
		self
			allocateTensorType: aTensorDomain type
			shape: externalized
			rank: aTensorDomain shape rank
			length: aLenght.
	answer useFinalization.
	^answer
]

{ #category : 'tensor',
  #vaVisibility : 'private' }
TensorFlowVASTLibrary >> allocateTensorType: anInteger shape: aLonnLongArray rank: dimCount length: len [
	| address |
	address := self dispatcher callTF_AllocateTensorWith: anInteger with: aLonnLongArray with: dimCount with: len.
	^ TFTensor address: address
]

{ #category : 'strings' }
TensorFlowVASTLibrary >> allStringsOf: aTFTensor [

	| total answer bytes data |

	total := aTFTensor size.
	answer := WriteStream on: (Array new: total).
	bytes := aTFTensor dataBytes.
	1 to: total do: [:i | | offset str |
		offset := bytes uint64At: (i - 1) * 8.
		data := bytes copyFrom: 8 * total + 1 + offset to: bytes size.
		str := self stringDecode: data.
		answer nextPut: str].
	^answer contents
]

{ #category : 'status' }
TensorFlowVASTLibrary >> checkStatusAfter: aBlock [

	| status answer |

	status := TFStatus create.
	answer := aBlock cull: status.
	status check.
	^answer
]

{ #category : 'session' }
TensorFlowVASTLibrary >> closeSession: aTFSession status: aTFStatus [

	^self dispatcher callTF_CloseSessionWith: aTFSession with: aTFStatus
]

{ #category : 'buffer' }
TensorFlowVASTLibrary >> deleteBuffer: aTFBuffer [

	^self dispatcher callTF_DeleteBufferWith: aTFBuffer
]

{ #category : 'device list' }
TensorFlowVASTLibrary >> deleteDeviceList: aTFDeviceList [

	^self dispatcher callTF_DeleteDeviceListWith: aTFDeviceList
]

{ #category : 'graph' }
TensorFlowVASTLibrary >> deleteGraph: aTFGraph [

	^self dispatcher callTF_DeleteGraphWith: aTFGraph
]

{ #category : 'options' }
TensorFlowVASTLibrary >> deleteImportGraphDefOptions: aTFImportGraphDefOptions [

	^self dispatcher callTF_DeleteImportGraphDefOptionsWith: aTFImportGraphDefOptions
]

{ #category : 'session' }
TensorFlowVASTLibrary >> deleteSession: aTFSession status: aTFStatus [

	^self dispatcher callTF_DeleteSessionWith: aTFSession with: aTFStatus
]

{ #category : 'options' }
TensorFlowVASTLibrary >> deleteSessionOptions: aTFSessionOptions [

	^self dispatcher callTF_DeleteSessionOptionsWith: aTFSessionOptions
]

{ #category : 'status' }
TensorFlowVASTLibrary >> deleteStatus: aTFStatus [

	^self dispatcher callTF_DeleteStatusWith: aTFStatus
]

{ #category : 'tensor' }
TensorFlowVASTLibrary >> deleteTensor: aTFTensor [

	^self dispatcher callTF_DeleteTensorWith: aTFTensor
]

{ #category : 'operation description' }
TensorFlowVASTLibrary >> description: aTFOperationDescription addControlInput: aTFOutputOrOperation [
	"	old version:
			void 'TF_AddControlInput' (TFOperationDescription* TFOutput)
		new version:
			void 'TF_AddControlInput' (TFOperationDescription* *TFOperation)"

	| operation |

	(aTFOutputOrOperation isKindOf: TFOutput)
		ifTrue: [
			self halt:
				'Deprecated interface: The second argument type has changed from TFOutput to *TFOperation'.
			operation := aTFOutputOrOperation operation.
			operation := TFOperation address: operation]
		ifFalse: [operation := aTFOutputOrOperation].
	^self dispatcher callTF_AddControlInputWith: aTFOperationDescription with: operation
]

{ #category : 'operation description' }
TensorFlowVASTLibrary >> description: aTFOperationDescription addInput: aTFOutput [

	^self dispatcher callTF_AddInputWith: aTFOperationDescription with: aTFOutput
]

{ #category : 'operation description' }
TensorFlowVASTLibrary >> description: aTFOperationDescription addInputs: anArrayOfTFOutput [

	| inputs |

	inputs := TFOutputArray externalFromArray: anArrayOfTFOutput.
	self description: aTFOperationDescription addInputs: inputs size: anArrayOfTFOutput size
]

{ #category : 'operation description',
  #vaVisibility : 'private' }
TensorFlowVASTLibrary >> description: aTFOperationDescription addInputs: aTFOutputArray size: anInteger [
	^ self dispatcher callTF_AddInputListWith: aTFOperationDescription with: aTFOutputArray with: anInteger
]

{ #category : 'operation description' }
TensorFlowVASTLibrary >> description: aTFOperationDescription set: aString toBool: anInt [

	^self dispatcher callTF_SetAttrBoolWith: aTFOperationDescription with: aString with: anInt
]

{ #category : 'operation description' }
TensorFlowVASTLibrary >> description: aTFOperationDescription set: aString toFloat: valueFloat [
	"	<cdecl: void 'TF_SetAttrFloat' (TFOperationDescription* char* float)>"

	^self dispatcher callTF_SetAttrFloatWith: aTFOperationDescription with: aString with: valueFloat
]

{ #category : 'operation description' }
TensorFlowVASTLibrary >> description: aTFOperationDescription set: aString toInt64: anInt [

	^self dispatcher callTF_SetAttrIntWith: aTFOperationDescription with: aString with: anInt
]

{ #category : 'operation description' }
TensorFlowVASTLibrary >> description: aTFOperationDescription set: anAttributeName toInts: aListOfIntegers [

	^self
		description: aTFOperationDescription
		set: anAttributeName
		toInts: (Int64Array externalFromArray: aListOfIntegers)
		size: aListOfIntegers size
]

{ #category : 'operation description',
  #vaVisibility : 'private' }
TensorFlowVASTLibrary >> description: aTFOperationDescription set: anAttributeName toInts: values size: size [

	^self dispatcher
		callTF_SetAttrIntListWith: aTFOperationDescription
		with: anAttributeName
		with: values
		with: size
]

{ #category : 'operation description' }
TensorFlowVASTLibrary >> description: aTFOperationDescription set: anAttributeName toShape: aTensorShape [

	^self checkStatusAfter: [
		self
			description: aTFOperationDescription
			set: anAttributeName asAsciiZ
			toShape: (Int64Array externalFromArray: aTensorShape dimensionSizes)
			size: aTensorShape size]
]

{ #category : 'operation description',
  #vaVisibility : 'private' }
TensorFlowVASTLibrary >> description: aTFOperationDescription set: aString toShape: anInt64Array size: size [
	^ self dispatcher callTF_SetAttrShapeWith: aTFOperationDescription with: aString with: anInt64Array with: size
]

{ #category : 'operation description' }
TensorFlowVASTLibrary >> description: aTFOperationDescription set: aString toShapes: aListOfShapes [

	| shapes shapeSizes |

	shapes := aListOfShapes collect: [:shape | Int64Array externalFromArray: shape dimensionSizes].
	shapeSizes := aListOfShapes collect: #rank.
	^self checkStatusAfter: [
		self
			description: aTFOperationDescription
			set: aString asAsciiZ
			toShapes: (Int64Array externalFromArray: shapes)
			sizesOfEach: (Int32Array externalFromArray: shapeSizes)
			size: aListOfShapes size]
]

{ #category : 'operation description',
  #vaVisibility : 'private' }
TensorFlowVASTLibrary >> description: aTFOperationDescription set: anAttributeName toShapes: dims sizesOfEach: num_dims size: num_shapes [

	^self dispatcher
		callTF_SetAttrShapeListWith: aTFOperationDescription
		with: anAttributeName
		with: dims
		with: num_dims
		with: num_shapes
]

{ #category : 'operation description',
  #vaVisibility : 'private' }
TensorFlowVASTLibrary >> description: aTFOperationDescription set: nameString toString: valueString size: size [
	"	<cdecl: void 'TF_SetAttrString' (TFOperationDescription* char* char* ulonglong)>"
	^ self dispatcher callTF_SetAttrStringWith: aTFOperationDescription with: nameString with: valueString with: size
]

{ #category : 'operation description' }
TensorFlowVASTLibrary >> description: aTFOperationDescription set: anAttributeName toStrings: anArrayOfStrings [

	| sizes strings pointers |

	sizes := anArrayOfStrings collect: [:str | str size].
	sizes := Int64Array externalFromArray: sizes.
	sizes useFinalization.
	strings := anArrayOfStrings collect: [:each | (self externalizeString: each)].
	pointers := ByteArray new: ExternalWordArray fixedSize * strings size.
	1 to: strings size do: [:index |
		pointers pointerAt: (index - 1) * ExternalWordArray fixedSize put: (strings at: index)].
	^self checkStatusAfter: [
		self
			description: aTFOperationDescription
			set: anAttributeName
			toStrings: pointers
			sizes: sizes
			count: anArrayOfStrings size.
		strings do: [:each | each free]]
]

{ #category : 'operation description',
  #vaVisibility : 'private' }
TensorFlowVASTLibrary >> description: aTFOperationDescription set: aString toStrings: anArrayOfString sizes: sizes count: count [
	"	<cdecl: void 'TF_SetAttrStringList' (TFOperationDescription* char* void* Int64Array* longlong)>"
	^ self dispatcher callTF_SetAttrStringListWith: aTFOperationDescription with: aString with: anArrayOfString with: sizes with: count
]

{ #category : 'operation description',
  #vaVisibility : 'private' }
TensorFlowVASTLibrary >> description: aTFOperationDescription set: aString toTensor: aTFTensor status: aTFStatus [
	^ self dispatcher callTF_SetAttrTensorWith: aTFOperationDescription with: aString with: aTFTensor with: aTFStatus

]

{ #category : 'operation description' }
TensorFlowVASTLibrary >> description: aTFOperationDescription set: aString toType: anInt [

	^self dispatcher callTF_SetAttrTypeWith: aTFOperationDescription with: aString with: anInt
]

{ #category : 'operation description' }
TensorFlowVASTLibrary >> description: aTFOperationDescription set: anAttributeName toTypes: aListOfTypes [

	^self checkStatusAfter: [
		self
			description: aTFOperationDescription
			set: anAttributeName
			toTypes: (Int32Array externalFromArray: aListOfTypes)
			size: aListOfTypes size]
]

{ #category : 'operation description',
  #vaVisibility : 'private' }
TensorFlowVASTLibrary >> description: aTFOperationDescription set: anAttributeName toTypes: values size: size [

	^self dispatcher
		callTF_SetAttrTypeListWith: aTFOperationDescription
		with: anAttributeName
		with: values
		with: size
]

{ #category : 'operation description' }
TensorFlowVASTLibrary >> description: aTFOperationDescription setDevice: aString [
	"	<cdecl: void 'TF_SetDevice' (TFOperationDescription* char*)>"

	^self dispatcher callTF_SetDeviceWith: aTFOperationDescription with: aString
]

{ #category : 'device list' }
TensorFlowVASTLibrary >> deviceList: aDeviceList incarnationAt: anInteger status: aTFStatus [
	" char* TF_DeviceListIncarnation(const TF_DeviceList* list, int index, TF_Status* status) "

	^self dispatcher callTF_DeviceListIncarnationWith: aDeviceList with: anInteger with: aTFStatus
]

{ #category : 'device list' }
TensorFlowVASTLibrary >> deviceList: aDeviceList memoryAt: anInteger status: aTFStatus [
	" char* TF_DeviceListMemoryBytes(const TF_DeviceList* list, int index, TF_Status* status) "

	^self dispatcher callTF_DeviceListMemoryBytesWith: aDeviceList with: anInteger with: aTFStatus
]

{ #category : 'device list' }
TensorFlowVASTLibrary >> deviceList: aDeviceList nameAt: anInteger status: aTFStatus [
	" char* TF_DeviceListName(const TF_DeviceList* list, int index, TF_Status* status) "

	| answer |

	answer := self dispatcher callTF_DeviceListNameWith: aDeviceList with: anInteger with: aTFStatus.
	^(OSStringZ address: answer) asString
]

{ #category : 'device list' }
TensorFlowVASTLibrary >> deviceList: aDeviceList typeAt: anInteger status: aTFStatus [
	" char* TF_DeviceListType(const TF_DeviceList* list, int index, TF_Status* status) "

	| answer |

	answer := self dispatcher callTF_DeviceListTypeWith: aDeviceList with: anInteger with: aTFStatus.
	^(OSStringZ address: answer) asString
]

{ #category : 'device list' }
TensorFlowVASTLibrary >> deviceListCount: aTFDeviceList [

	^self dispatcher callTF_DeviceListCountWith: aTFDeviceList
]

{ #category : 'device list' }
TensorFlowVASTLibrary >> deviceListForSession: aTFSession status: aTFStatus [
	" TF_DeviceList* TF_SessionListDevices(TF_Session* session, TF_Status* status);"

	| answer |

	answer := self dispatcher callTF_SessionListDevicesWith: aTFSession with: aTFStatus.
	^TFDeviceList address: answer
]

{ #category : 'utils' }
TensorFlowVASTLibrary >> dispatcher [

	^self class dispatcher
]

{ #category : 'strings' }
TensorFlowVASTLibrary >> externalizeString: aString [

	^aString copyToOSMemory
]

{ #category : 'operation description' }
TensorFlowVASTLibrary >> finishOperation: aTFOperationDescription status: aTFStatus [

	| answer |

	answer := self finishOperationAsVoid: aTFOperationDescription status: aTFStatus.
	^TFOperation address: answer
]

{ #category : 'operation description' }
TensorFlowVASTLibrary >> finishOperationAsVoid: aTFOperationDescription status: aTFStatus [

	^self dispatcher callTF_FinishOperationWith: aTFOperationDescription with: aTFStatus
]

{ #category : 'operation' }
TensorFlowVASTLibrary >> forGraph: aTFGraph outputDims: aTFOutput status: aTFStatus [

	^self dispatcher callTF_GraphGetTensorNumDimsWith: aTFGraph with: aTFOutput with: aTFStatus
]

{ #category : 'utils' }
TensorFlowVASTLibrary >> getAllOps [

	^TFBuffer address: self dispatcher callTF_GetAllOpList
]

{ #category : 'status' }
TensorFlowVASTLibrary >> getCode: aTFStatus [

	^self dispatcher callTF_GetCodeWith: aTFStatus
]

{ #category : 'gradients' }
TensorFlowVASTLibrary >> gradientsOf: yArrayOfTFOutput withRespectTo: xArrayOfTFOutput product: dxArrayOfOutput in: aTFGraph [

	| y x dx dy |

	y := TFOutputArray externalFromArray: yArrayOfTFOutput.
	x := TFOutputArray externalFromArray: xArrayOfTFOutput.
	dx := dxArrayOfOutput ifNil: [nil] ifNotNil: [TFOutputArray externalFromArray: dxArrayOfOutput].
	dy := TFOutputArray new: xArrayOfTFOutput size.
	self checkStatusAfter: [:status |
		self
			graph: aTFGraph
			y: y
			yCount: yArrayOfTFOutput size
			x: x
			xCount: xArrayOfTFOutput size
			dx: dx
			status: status
			into: dy].
	^dy
]

{ #category : 'graph' }
TensorFlowVASTLibrary >> graph: aTFGraph getOperationNamed: aString [

	| answer |

	answer := self graph: aTFGraph getOperationNamedAsVoid: aString.
	answer := TFOperation address: answer.
	answer graph: aTFGraph.
	^answer
]

{ #category : 'graph',
  #vaVisibility : 'private' }
TensorFlowVASTLibrary >> graph: aTFGraph getOperationNamedAsVoid: aString [
	^ self dispatcher callTF_GraphOperationByNameWith: aTFGraph with: aString
]

{ #category : 'graph' }
TensorFlowVASTLibrary >> graph: aTFGraph getRankOf: aTFOutputOrInput [

	^self
		checkStatusAfter: [:status | self graph: aTFGraph getRankOf: aTFOutputOrInput status: status]
]

{ #category : 'graph' }
TensorFlowVASTLibrary >> graph: aTFGraph getRankOf: aTFOutputOrInput status: status [

	^self dispatcher callTF_GraphGetTensorNumDimsWith: aTFGraph with: aTFOutputOrInput with: status
]

{ #category : 'operation' }
TensorFlowVASTLibrary >> graph: aTFGraph getShapeOf: aTFOutputOrInput [

	| value size answer |

	size := self graph: aTFGraph getRankOf: aTFOutputOrInput.
	value := Int64Array externalNew: size.
	answer :=
		self checkStatusAfter: [:status |
			self graph: aTFGraph getShapeOf: aTFOutputOrInput into: value size: size status: status].
	answer := (1 to: size) collect: [:i | value at: i].
	^answer asTensorShape
]

{ #category : 'graph',
  #vaVisibility : 'private' }
TensorFlowVASTLibrary >> graph: aTFGraph getShapeOf: aTFOutputOrInput into: anInt64Array size: anInteger status: status [
	^ self dispatcher callTF_GraphGetTensorShapeWith: aTFGraph with: aTFOutputOrInput with: anInt64Array with: anInteger with: status
]

{ #category : 'operation' }
TensorFlowVASTLibrary >> graph: aTFGraph operationAt: contextULongLongPtr [

	| answer |

	answer := self graph: aTFGraph operationAtAsVoid: contextULongLongPtr.
	answer := TFOperation address: answer.
	answer graph: aTFGraph.
	^answer
]

{ #category : 'operation' }
TensorFlowVASTLibrary >> graph: aTFGraph operationAtAsVoid: contextULongLongPtr [

	^self dispatcher callTF_GraphNextOperationWith: aTFGraph with: contextULongLongPtr
]

{ #category : 'graph' }
TensorFlowVASTLibrary >> graph: aTFGraph setShapeOf: aTFOutputOrInput to: aShape [

	| value |

	value := Int64Array externalFromArray: aShape.
	^self checkStatusAfter: [:status |
		self graph: aTFGraph setShapeOf: aTFOutputOrInput to: value size: aShape size status: status]
]

{ #category : 'graph',
  #vaVisibility : 'private' }
TensorFlowVASTLibrary >> graph: aTFGraph setShapeOf: aTFOutputOrInput to: anInt64Array size: anInteger status: status [
	"	<cdecl: void 'TF_GraphSetTensorShape' (TFGraph* TFOutput Int64Array* ulonglong TFStatus*)>"
	^ self dispatcher callTF_GraphSetTensorShapeWith: aTFGraph with: aTFOutputOrInput with: anInt64Array with: anInteger with: status
]

{ #category : 'graph',
  #vaVisibility : 'private' }
TensorFlowVASTLibrary >> graph: aTFGraph toGraphDef: aTFBuffer status: aTFStatus [
	^ self dispatcher callTF_GraphToGraphDefWith: aTFGraph with: aTFBuffer with: aTFStatus
]

{ #category : 'gradients',
  #vaVisibility : 'private' }
TensorFlowVASTLibrary >> graph: aTFGraph y: yTFOutputArray yCount: yCount x: xTFOutputArray xCount: xCount dx: dxTFOutputArray status: aTFStatus into: dyTFOutputArray [
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

{ #category : 'graph' }
TensorFlowVASTLibrary >> importGraphDefInto: aTFGraph from: aTFBuffer options: aTFImportGraphDefOptions status: aTFStatus [

	^self dispatcher
		callTF_GraphImportGraphDefWith: aTFGraph
		with: aTFBuffer
		with: aTFImportGraphDefOptions
		with: aTFStatus
]

{ #category : 'status' }
TensorFlowVASTLibrary >> message: aTFStatus [

	^(OSStringZ address: (self dispatcher callTF_MessageWith: aTFStatus)) asString
]

{ #category : 'session' }
TensorFlowVASTLibrary >> newAutoreleaseSessionOn: aTFGraph [

	| options answer |

	options := TFSessionOptions create.
	answer :=
		self checkStatusAfter: [:status | self newSession: aTFGraph options: options status: status].
	answer useFinalization.
	^answer
]

{ #category : 'options' }
TensorFlowVASTLibrary >> newAutoreleaseSessionOptions [

	^self newSessionOptions useFinalization
]

{ #category : 'status' }
TensorFlowVASTLibrary >> newAutoreleaseStatus [

	^(self newPersistentStatus)
		useFinalization;
		yourself
]

{ #category : 'buffer' }
TensorFlowVASTLibrary >> newBuffer [

	| result |

	result := TFBuffer address: self dispatcher callTF_NewBuffer.
	result isNull ifTrue: [^nil].
	^result
]

{ #category : 'buffer' }
TensorFlowVASTLibrary >> newBufferFromString: aString size: anInteger [

	^TFBuffer address: (self dispatcher callTF_NewBufferFromStringWith: aString with: anInteger)
]

{ #category : 'graph' }
TensorFlowVASTLibrary >> newGraph [

	^(TFGraph address: self dispatcher callTF_NewGraph) initialize useFinalization
]

{ #category : 'options' }
TensorFlowVASTLibrary >> newImportGraphDefOptions [

	^TFImportGraphDefOptions address: self dispatcher callTF_NewImportGraphDefOptions
]

{ #category : 'operation description' }
TensorFlowVASTLibrary >> newOperationDescriptionOn: graph type: type named: name [

	| address |

	address := self dispatcher callTF_NewOperationWith: graph with: type with: name.
	^TFOperationDescription address: address
]

{ #category : 'status' }
TensorFlowVASTLibrary >> newPersistentStatus [

	^TFStatus address: (self dispatcher callTF_NewStatus)
]

{ #category : 'session' }
TensorFlowVASTLibrary >> newSession: aTFGraph options: aTFSessionOptions status: aTFStatus [

	| answer |

	answer := self dispatcher callTF_NewSessionWith: aTFGraph with: aTFSessionOptions with: aTFStatus.
	^TFSession address: answer
]

{ #category : 'options' }
TensorFlowVASTLibrary >> newSessionOptions [

	^TFSessionOptions address: (self dispatcher callTF_NewSessionOptions)
]

{ #category : 'status' }
TensorFlowVASTLibrary >> newStatus [

	^self newPersistentStatus
]

{ #category : 'operation attribute',
  #vaVisibility : 'private' }
TensorFlowVASTLibrary >> operation: aTFOperation attr: nameZString getBool: valueBoolPtr status: status [
	^ self dispatcher callTF_OperationGetAttrBoolWith: aTFOperation with: nameZString with: valueBoolPtr address with: status
]

{ #category : 'operation attribute',
  #vaVisibility : 'private' }
TensorFlowVASTLibrary >> operation: aTFOperation attr: nameZString getFloat: valueFloatPtr status: status [
	^ self dispatcher callTF_OperationGetAttrFloatWith: aTFOperation with: nameZString with: valueFloatPtr with: status
]

{ #category : 'operation attribute',
  #vaVisibility : 'private' }
TensorFlowVASTLibrary >> operation: aTFOperation attr: nameZString getInt64: valueLongPtr status: status [
	^ self dispatcher callTF_OperationGetAttrIntWith: aTFOperation with: nameZString with: valueLongPtr with: status
]

{ #category : 'operation attribute',
  #vaVisibility : 'private' }
TensorFlowVASTLibrary >> operation: aTFOperation attr: nameZString getShape: int64array size: maxSize status: status [
	"	<cdecl: void 'TF_OperationGetAttrShape' (TFOperation* char* Int64Array* ulonglong TFStatus*)>"
	^ self dispatcher callTF_OperationGetAttrShapeWith: aTFOperation with: nameZString with: int64array with: maxSize with: status
]

{ #category : 'operation',
  #vaVisibility : 'private' }
TensorFlowVASTLibrary >> operation: aTFOperation attr: nameZString getString: valueString size: maxSize status: status [
	"	<cdecl: void 'TF_OperationGetAttrString' (TFOperation* char* void* ulonglong TFStatus*)>"
	^ self dispatcher callTF_OperationGetAttrStringWith: aTFOperation with: nameZString with: valueString with: maxSize with: status
]

{ #category : 'operation attribute',
  #vaVisibility : 'private' }
TensorFlowVASTLibrary >> operation: aTFOperation attr: nameZString getStrings: valueStringArray sizes: sizesArray maxCount: maxCount storage: aBytaArray size: storageSize status: status [
	"	<cdecl: void 'TF_OperationGetAttrStringList' (TFOperation* char* void* Int64Array* ulonglong void* size_t TFStatus*)>"
	^ self dispatcher callTF_OperationGetAttrStringListWith: aTFOperation with: nameZString with: valueStringArray with: sizesArray with: maxCount with: aBytaArray with: storageSize with: status
]

{ #category : 'operation attribute',
  #vaVisibility : 'private' }
TensorFlowVASTLibrary >> operation: aTFOperation attr: nameZString getTensor: valueLongPtr status: status [
	"	<cdecl: void 'TF_OperationGetAttrTensor' (TFOperation* char* void* TFStatus*)>"
	^ self dispatcher callTF_OperationGetAttrTensorWith: aTFOperation with: nameZString with: valueLongPtr with: status
]

{ #category : 'operation attribute',
  #vaVisibility : 'private' }
TensorFlowVASTLibrary >> operation: aTFOperation attr: nameZString getType: valueLongPtr status: status [
	"	<cdecl: void 'TF_OperationGetAttrType' (TFOperation* char* ulonglong* TFStatus*)>"
	^ self dispatcher callTF_OperationGetAttrTypeWith: aTFOperation with: nameZString with: valueLongPtr with: status
]

{ #category : 'operation attribute' }
TensorFlowVASTLibrary >> operation: aTFOperation getBoolAt: anAttributeName [

	| value |

	value := TFStructure externalNew: 1.
	self checkStatusAfter: [:status |
		self operation: aTFOperation attr: anAttributeName asAsciiZ getBool: value status: status].
	^value bool8At: 0
]

{ #category : 'operation attribute' }
TensorFlowVASTLibrary >> operation: aTFOperation getFloatAt: anAttributeName [

	| value |

	value := TFStructure new: 8.
	self checkStatusAfter: [:status |
		self operation: aTFOperation attr: anAttributeName asAsciiZ getFloat: value status: status].
	^value float32At: 0
]

{ #category : 'operation attribute' }
TensorFlowVASTLibrary >> operation: aTFOperation getInt64At: anAttributeName [

	| value |

	value := TFStructure new: 8.
	self checkStatusAfter: [:status |
		self operation: aTFOperation attr: anAttributeName getInt64: value status: status].
	^value uint64At: 0
]

{ #category : 'operation attribute' }
TensorFlowVASTLibrary >> operation: aTFOperation getMetadataFor: anAttributeName [

	^self checkStatusAfter: [:status |
		self operation: aTFOperation getMetadataFor: anAttributeName status: status]
]

{ #category : 'operation' }
TensorFlowVASTLibrary >> operation: aTFOperation getMetadataFor: nameZString status: status [
	"	<cdecl: TFAttrMetadata 'TF_OperationGetAttrMetadata' (TFOperation* char* TFStatus*)>"

	^self dispatcher callTF_OperationGetAttrMetadataWith: aTFOperation with: nameZString with: status
]

{ #category : 'operation attribute' }
TensorFlowVASTLibrary >> operation: aTFOperation getShapeAt: anAttributeName [

	| value size answer |

	size := (self operation: aTFOperation getMetadataFor: anAttributeName) totalSize.
	size = -1 ifTrue: [^TensorShape scalar].
	value := Int64Array externalNew: size.
	self checkStatusAfter: [:status |
		self operation: aTFOperation attr: anAttributeName getShape: value size: size status: status].
	answer := (1 to: size) collect: [:i | value at: i].
	^answer asTensorShape
]

{ #category : 'operation attribute' }
TensorFlowVASTLibrary >> operation: aTFOperation getStringAt: anAttributeName [

	| metadata value |

	metadata := self operation: aTFOperation getMetadataFor: anAttributeName.
	value := ByteArray new: metadata totalSize.
	self checkStatusAfter: [:status |
		self
			operation: aTFOperation
			attr: anAttributeName
			getString: value
			size: metadata totalSize
			status: status].
	^(value copyUpTo: 0) asString
]

{ #category : 'operation attribute' }
TensorFlowVASTLibrary >> operation: aTFOperation getStringsAt: anAttributeName [

	| pointers sizes spaceRequired storage metadata valuesCount |

	metadata := self operation: aTFOperation getMetadataFor: anAttributeName.
	spaceRequired := metadata totalSize.
	valuesCount := metadata listSize.
	pointers := ByteArray new: ExternalWordArray fixedSize * valuesCount.
	sizes := (Int64Array externalNew: valuesCount) useFinalization.
	storage := OSPtr calloc: spaceRequired.
	self checkStatusAfter: [:status |
		self
			operation: aTFOperation
			attr: anAttributeName asAsciiZ
			getStrings: pointers
			sizes: sizes
			maxCount: valuesCount
			storage: storage
			size: spaceRequired
			status: status].
	^(1 to: valuesCount) collect: [:i | | one |
		one := pointers pointerAt: (i - 1) * ExternalWordArray fixedSize.
		one := (OSPtr address: one) memcpyStringFrom: 0 to: (sizes at: i) - 1]
]

{ #category : 'operation attribute' }
TensorFlowVASTLibrary >> operation: aTFOperation getTensorAt: anAttributeName [

	| value |

	value := ByteArray new: ExternalWordArray fixedSize.
	self checkStatusAfter: [:status |
		self operation: aTFOperation attr: anAttributeName getTensor: value status: status].
	^TFTensor address: (value pointerAt: 0)
]

{ #category : 'operation attribute' }
TensorFlowVASTLibrary >> operation: aTFOperation getTypeAt: anAttributeName [

	| value |

	value := TFStructure new: 8.
	self checkStatusAfter: [:status |
		self operation: aTFOperation attr: anAttributeName getType: value status: status].
	^value uint64At: 0
]

{ #category : 'operation' }
TensorFlowVASTLibrary >> operationDevice: aTFOperation [
	"	<cdecl: char* 'TF_OperationDevice' (TFOperation*)>"

	^self dispatcher callTF_OperationDeviceWith: aTFOperation
]

{ #category : 'operation' }
TensorFlowVASTLibrary >> operationName: aTFOperation [

	| address |

	address := self dispatcher callTF_OperationNameWith: aTFOperation.
	^(OSStringZ address: address) asString
]

{ #category : 'operation' }
TensorFlowVASTLibrary >> operationNumInputs: aTFOperation [

	^self dispatcher callTF_OperationNumInputsWith: aTFOperation
]

{ #category : 'operation' }
TensorFlowVASTLibrary >> operationNumOutputs: aTFOperation [

	^self dispatcher callTF_OperationNumOutputsWith: aTFOperation
]

{ #category : 'operation' }
TensorFlowVASTLibrary >> operationOpType: aTFOperation [

	| address |

	address := self dispatcher callTF_OperationOpTypeWith: aTFOperation.
	^(OSStringZ address: address) asString
]

{ #category : 'operation' }
TensorFlowVASTLibrary >> operationOutputType: aTFOutput [

	^self dispatcher callTF_OperationOutputTypeWith: aTFOutput
]

{ #category : 'strings',
  #vaVisibility : 'private' }
TensorFlowVASTLibrary >> primStringEncodedSize: anInteger [
	^ self dispatcher callTF_StringEncodedSizeWith:anInteger
]

{ #category : 'session' }
TensorFlowVASTLibrary >> runSession: aTFSession inputs: inArrayOfTFOutputs values: inArrayOfTFTensor outputs: outArrayOfTFOutputs [

	| inputs invalues outputs outvalues |

	inputs := TFInputArray externalFromArray: inArrayOfTFOutputs.
	invalues := TFTensorPtrArray externalFromArray: inArrayOfTFTensor.
	outputs := TFOutputArray externalFromArray: outArrayOfTFOutputs.
	outvalues := TFTensorPtrArray new: outArrayOfTFOutputs size.
	self checkStatusAfter: [:status |
		self
			runSession: aTFSession
			options: nil
			inputs: inputs
			values: invalues
			count: inArrayOfTFOutputs size
			outputs: outputs
			values: outvalues
			count: outArrayOfTFOutputs size
			targets: nil
			count: 0
			metadata: nil
			status: status].
	^outvalues
]

{ #category : 'session' }
TensorFlowVASTLibrary >> runSession: aTFSession operation: aTFOperation output: aTFOutput [

	| operations answer outputs outvalues |

	operations := TFOperationPtrArray externalNew: 1.
	outputs := TFOutputArray externalNew: 1.
	outputs first: aTFOutput.
	operations first: aTFOperation.
	outvalues := TFTensorPtrArray new: 1.
	self checkStatusAfter: [:status |
		self
			runSession: aTFSession
			options: nil
			inputs: nil
			values: nil
			count: 0
			outputs: outputs
			values: outvalues
			count: 1
			targets: operations
			count: 1
			metadata: nil
			status: status].
	answer := outvalues.
	^answer first
]

{ #category : 'session' }
TensorFlowVASTLibrary >> runSession: aTFSession operations: anArrayOfTFOperations [

	| operations |

	operations := TFOperationPtrArray externalFromArray: anArrayOfTFOperations.
	^self checkStatusAfter: [:status |
		self
			runSession: aTFSession
			options: nil
			inputs: nil
			values: nil
			count: 0
			outputs: nil
			values: nil
			count: 0
			targets: operations
			count: anArrayOfTFOperations size
			metadata: nil
			status: status]
]

{ #category : 'session' }
TensorFlowVASTLibrary >> runSession: aTFSession options: runOptionsTFBufferOrNil inputs: inTFOutputArray values: inTFTensorArray count: inCount outputs: outTFOutputArray values: outTFTensorArrayPtr count: outCount targets: targetTFOperationArrayOrNil count: targetCount metadata: metadataTFBuffer status: aTFStatus [
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

{ #category : 'session' }
TensorFlowVASTLibrary >> runSession: aTFSession outputs: anArrayOfTFOutputs [

	| aTFOutputArray anInteger outvalues |

	aTFOutputArray := TFOutputArray externalFromArray: anArrayOfTFOutputs.
	anInteger := anArrayOfTFOutputs size.
	outvalues := TFTensorPtrArray new: anInteger.
	self checkStatusAfter: [:status |
		self
			runSession: aTFSession
			options: nil
			inputs: nil
			values: nil
			count: 0
			outputs: aTFOutputArray
			values: outvalues
			count: anInteger
			targets: nil
			count: 0
			metadata: nil
			status: status].
	^outvalues
]

{ #category : 'options' }
TensorFlowVASTLibrary >> sessionOptions: aTFSessionOptions setConfig: aByteObject configSize: anInteger status: aTFStatus [

	self dispatcher
		callTF_SetConfigWith: aTFSessionOptions
		with: aByteObject
		with: anInteger
		with: aTFStatus
]

{ #category : 'options' }
TensorFlowVASTLibrary >> sessionOptions: aTFSessionOptions setTarget: anExternalString [

	^self dispatcher callTF_SetTargetWith: aTFSessionOptions with: anExternalString
]

{ #category : 'status' }
TensorFlowVASTLibrary >> setStatus: aTFStatus code: anInteger message: anExternalString [

	^self dispatcher callTF_SetStatusWith: aTFStatus with: anInteger with: anExternalString
]

{ #category : 'utils' }
TensorFlowVASTLibrary >> sizeOfDataType: aDataType [

	^self dispatcher callTF_DataTypeSizeWith: aDataType
]

{ #category : 'strings',
  #vaVisibility : 'private' }
TensorFlowVASTLibrary >> stringDecode: src [

	| destination answer dstSize |

	destination := ByteArray new: 8.
	dstSize := ByteArray new: 8.
	answer :=
		self checkStatusAfter: [:status |
			self stringDecode: src len: src size destination: destination len: dstSize status: status].
	dstSize := dstSize uint64At: 0.
	destination := OSPtr address: (destination pointerAt: 0).
	answer := destination memcpyStringFrom: 0 to: dstSize - 1.
	^answer
]

{ #category : 'strings',
  #vaVisibility : 'private' }
TensorFlowVASTLibrary >> stringDecode: srcString len: srcLen destination: dstPointer len: dstLenPointer status: status [
	"	<cdecl: ulonglong 'TF_StringDecode' (char* ulonglong char* ulonglong* TFStatus)>"
	^ self dispatcher callTF_StringDecodeWith: srcString with: srcLen with: dstPointer with: dstLenPointer with: status
]

{ #category : 'strings',
  #vaVisibility : 'private' }
TensorFlowVASTLibrary >> stringEncode: srcString len: srcLen destination: dstString len: dstLen status: status [
	"	<cdecl: ulonglong 'TF_StringEncode' (char* ulonglong char* ulonglong TFStatus)>"
	^ self dispatcher callTF_StringEncodeWith: srcString with: srcLen with: dstString with: dstLen with: status
]

{ #category : 'strings',
  #vaVisibility : 'private' }
TensorFlowVASTLibrary >> stringEncode: src to: dst size: dstSize [

	^self checkStatusAfter: [:status |
		self stringEncode: src len: src size destination: dst len: dstSize status: status]
]

{ #category : 'strings' }
TensorFlowVASTLibrary >> stringEncodedSize: aString [

	^self primStringEncodedSize: aString size
]

{ #category : 'tensor' }
TensorFlowVASTLibrary >> tensor: aTFTensor sizeOn: dimension [

	^self dispatcher callTF_DimWith: aTFTensor with: dimension
]

{ #category : 'tensor' }
TensorFlowVASTLibrary >> tensorByteSize: aTFTensor [

	^self dispatcher callTF_TensorByteSizeWith: aTFTensor
]

{ #category : 'tensor' }
TensorFlowVASTLibrary >> tensorData: aTFTensor [
	"	<cdecl: void* 'TF_TensorData' (TFTensor*)>"

	^self dispatcher callTF_TensorDataWith: aTFTensor
]

{ #category : 'tensor' }
TensorFlowVASTLibrary >> tensorDataOf: aTFTensor [
	"Answers the size of the underlying data in bytes.
	 
	 Answers:
		<OSVoid>"

	^OSPtr address: (self tensorData: aTFTensor)
]

{ #category : 'tensor' }
TensorFlowVASTLibrary >> tensorFromString: aString [

	| bytesize |

	bytesize := self stringEncodedSize: aString.
	
	^ TFTensor
		newTyped: TFTensor typeString
		shaped: TensorShape scalar
		bytesize: bytesize
		thenDo: [ :answer | self stringEncode: aString to: answer data size: bytesize ]


]

{ #category : 'tensor' }
TensorFlowVASTLibrary >> tensorFromStrings: aStringArray shaped: aTensorShape [

	| sizes offsets offsetSize bytesize |

	sizes := aStringArray collect: [:each | self stringEncodedSize: each].
	offsetSize := self sizeOfDataType: TFTensor typeInt64.
	bytesize := offsetSize * aStringArray size + sizes sum.
	offsets := OrderedCollection new: sizes size.
	sizes
		inject: 0
		into: [:prev :each |
			offsets add: prev.
			each + prev].

	^TFTensor
		newTyped: TFTensor typeString
		shaped: aTensorShape
		bytesize: bytesize
		thenDo: [:answer |
			TFTensor int64Array: offsets into: answer data.
			1 to: aStringArray size do: [:index | | offset |
				offset := offsetSize * aStringArray size + (offsets at: index).
				self
					stringEncode: (aStringArray at: index)
					to: answer data + offset
					size: bytesize - offset]]
]

{ #category : 'tensor' }
TensorFlowVASTLibrary >> tensorRank: aTFTensor [

	^self dispatcher callTF_NumDimsWith: aTFTensor
]

{ #category : 'tensor' }
TensorFlowVASTLibrary >> tensorType: aTFTensor [
	"	<cdecl: ulonglong 'TF_TensorType' (TFTensor*)>"

	^self dispatcher callTF_TensorTypeWith: aTFTensor
]

{ #category : 'utils' }
TensorFlowVASTLibrary >> version [

	^self dispatcher callTF_Version
]
