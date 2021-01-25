Class {
	#name : 'TFLibraryDispatcher',
	#superclass : 'Object',
	#instVars : [
		'callEngine'
	],
	#classVars : [
		'Default'
	],
	#pools : [
		'TensorFlowFunctions'
	],
	#category : 'TensorFlowCore'
}

{ #category : 'Accessing' }
TFLibraryDispatcher class >> default [
	"Access the Singleton default instance.
	 
	 Answers:
		<TFLibraryDispatcher>"

	Default isNil ifTrue: [self default: self new].
	^Default
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFLibraryDispatcher class >> default: aDispatcher [
	"Set the Singleton default instance.
	 
	 Arguments:
		aDispatcher - <TFLibraryDispatcher>"

	Default := aDispatcher
]

{ #category : 'Creation' }
TFLibraryDispatcher class >> new [
	"Answer a new instance of a library dispatcher
	 
	 Answers:
		<TFLibraryDispatcher> new instance"

	^self new: TFCallEngine default new
]

{ #category : 'Creation' }
TFLibraryDispatcher class >> new: aTFCallEngine [
	"Answer a new dispatcher instance that uses the initialized call engine
	 
	 Answers:
		<TFLibraryDispatcher>"

	^self basicNew initialize: aTFCallEngine
]

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFLibraryDispatcher class >> resetLibrary [
	"Reset the class variables to nil"

	Default := nil
]

{ #category : 'Accessing' }
TFLibraryDispatcher class >> unsentMethods [
	^ self selectors select:[:eachSelector |
	(Object allMethodsSendingAll: (Array with: eachSelector)) isEmpty]
]

{ #category : 'Accessing' }
TFLibraryDispatcher class >> unsentMethodsFor: aString [
	" self unsentMethodsFor: 'DeviceList' "
	^ (self selectors select:[:eachSelector |
		(eachSelector includesSubString: aString)
		and: [(Object allMethodsSendingAll: (Array with: eachSelector)) isEmpty]]) asArray
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callEngine: aTFCallEngine [
	"Set the initialized call engine"

	callEngine notNil ifTrue: [callEngine release].
	callEngine := aTFCallEngine
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_AbortWhileWith: params [

	^callEngine call: TF_AbortWhile with: params
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_AddControlInputWith: desc with: input [

	^callEngine call: TF_AddControlInput with: desc with: input
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_AddGradientsWith: g with: y with: ny with: x with: nx with: dx with: status with: dy [

	^callEngine
		call: TF_AddGradients
		with: g
		with: y
		with: ny
		with: x
		with: nx
		with: dx
		with: status
		with: dy
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_AddGradientsWithPrefixWith: g with: prefix with: y with: ny with: x with: nx with: dx with: status with: dy [

	^callEngine
		call: TF_AddGradientsWithPrefix
		with: g
		with: prefix asPSZ
		with: y
		with: ny
		with: x
		with: nx
		with: dx
		with: status
		with: dy
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_AddInputListWith: desc with: inputs with: num_inputs [

	^callEngine call: TF_AddInputList with: desc with: inputs with: num_inputs
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_AddInputWith: desc with: input [

	^callEngine call: TF_AddInput with: desc with: input
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_AllocateTensorWith: TF_DataType with: dims with: num_dims with: len [

	^callEngine call: TF_AllocateTensor with: TF_DataType with: dims with: num_dims with: len
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_ApiDefMapGetWith: api_def_map with: name with: name_len with: status [

	^callEngine call: TF_ApiDefMapGet with: api_def_map with: name with: name_len with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_ApiDefMapPutWith: api_def_map with: text with: text_len with: status [

	^callEngine call: TF_ApiDefMapPut with: api_def_map with: text with: text_len with: status
]

{ #category : 'Deprecated',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_CloseDeprecatedSessionWith: TF_DeprecatedSession with: status [

	^callEngine call: TF_CloseDeprecatedSession with: TF_DeprecatedSession with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_CloseSessionWith: TF_Session with: status [

	^callEngine call: TF_CloseSession with: TF_Session with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_ColocateWithWith: desc with: op [

	^callEngine call: TF_ColocateWith with: desc with: op
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_DataTypeSizeWith: dt [

	^callEngine call: TF_DataTypeSize with: dt
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_DeleteApiDefMapWith: apimap [

	^callEngine call: TF_DeleteApiDefMap with: apimap
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_DeleteBufferWith: buffer [

	^callEngine call: TF_DeleteBuffer with: buffer
]

{ #category : 'Deprecated',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_DeleteDeprecatedSessionWith: TF_DeprecatedSession with: status [

	^callEngine call: TF_DeleteDeprecatedSession with: TF_DeprecatedSession with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_DeleteDeviceListWith: list [

	^callEngine call: TF_DeleteDeviceList with: list
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_DeleteFunctionWith: func [

	^callEngine call: TF_DeleteFunction with: func
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_DeleteGraphWith: graph [

	^callEngine call: TF_DeleteGraph with: graph
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_DeleteImportGraphDefOptionsWith: opts [

	^callEngine call: TF_DeleteImportGraphDefOptions with: opts
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_DeleteImportGraphDefResultsWith: results [

	^callEngine call: TF_DeleteImportGraphDefResults with: results
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_DeleteLibraryHandleWith: lib_handle [

	^callEngine call: TF_DeleteLibraryHandle with: lib_handle
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_DeletePRunHandleWith: handle [

	^callEngine call: TF_DeletePRunHandle with: handle
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_DeleteServerWith: server [

	^callEngine call: TF_DeleteServer with: server
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_DeleteSessionOptionsWith: options [

	^callEngine call: TF_DeleteSessionOptions with: options
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_DeleteSessionWith: TF_Session with: status [

	^callEngine call: TF_DeleteSession with: TF_Session with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_DeleteStatusWith: s [

	^callEngine call: TF_DeleteStatus with: s
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_DeleteTensorWith: tensor [

	^callEngine call: TF_DeleteTensor with: tensor
]

{ #category : 'Deprecated',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_DeprecatedSessionListDevicesWith: session with: status [

	^callEngine call: TF_DeprecatedSessionListDevices with: session with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_DeviceListCountWith: list [

	^callEngine call: TF_DeviceListCount with: list
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_DeviceListIncarnationWith: list with: index with: status [

	^callEngine call: TF_DeviceListIncarnation with: list with: index with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_DeviceListMemoryBytesWith: list with: index with: status [

	^callEngine call: TF_DeviceListMemoryBytes with: list with: index with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_DeviceListNameWith: list with: index with: status [

	^callEngine call: TF_DeviceListName with: list with: index with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_DeviceListTypeWith: list with: index with: status [

	^callEngine call: TF_DeviceListType with: list with: index with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_DimWith: tensor with: dim_index [

	^callEngine call: TF_Dim with: tensor with: dim_index
]

{ #category : 'Deprecated',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_ExtendGraphWith: TF_DeprecatedSession with: proto with: proto_len with: TF_Status [

	^callEngine
		call: TF_ExtendGraph
		with: TF_DeprecatedSession
		with: proto
		with: proto_len
		with: TF_Status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_FinishOperationWith: desc with: status [

	^callEngine call: TF_FinishOperation with: desc with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_FinishWhileWith: params with: status with: outputs [

	^callEngine call: TF_FinishWhile with: params with: status with: outputs
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_FunctionGetAttrValueProtoWith: func with: attr_name with: output_attr_value with: status [

	^callEngine
		call: TF_FunctionGetAttrValueProto
		with: func
		with: attr_name asPSZ
		with: output_attr_value
		with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_FunctionImportFunctionDefWith: proto with: proto_len with: status [

	^callEngine call: TF_FunctionImportFunctionDef with: proto with: proto_len with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_FunctionNameWith: func [

	^callEngine call: TF_FunctionName with: func
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_FunctionSetAttrValueProtoWith: func with: attr_name with: proto with: proto_len with: status [

	^callEngine
		call: TF_FunctionSetAttrValueProto
		with: func
		with: attr_name asPSZ
		with: proto
		with: proto_len
		with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_FunctionToFunctionDefWith: func with: output_func_def with: status [

	^callEngine call: TF_FunctionToFunctionDef with: func with: output_func_def with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_GetAllOpList [

	^callEngine call: TF_GetAllOpList
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_GetAllRegisteredKernelsWith: status [

	^callEngine call: TF_GetAllRegisteredKernels with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_GetBufferWith: s [

	| buffer |

	buffer := TFBuffer new.
	callEngine call: TF_GetBuffer withAll: (Array with: s) returnInto: buffer.
	^buffer
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_GetCodeWith: s [

	^callEngine call: TF_GetCode with: s
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_GetOpListWith: libHandle [

	| buffer |

	buffer := TFBuffer new.
	callEngine call: TF_GetOpList withAll: (Array with: libHandle) returnInto: buffer.
	^buffer
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_GetRegisteredKernelsForOpWith: name with: status [

	^callEngine call: TF_GetRegisteredKernelsForOp with: name asPSZ with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_GraphCopyFunctionWith: g with: func with: grad with: status [

	^callEngine call: TF_GraphCopyFunction with: g with: func with: grad with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_GraphGetFunctionsWith: g with: funcs with: max_func with: status [

	^callEngine call: TF_GraphGetFunctions with: g with: funcs with: max_func with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_GraphGetOpDefWith: graph with: op_name with: output_op_def with: status [

	^callEngine call: TF_GraphGetOpDef with: graph with: op_name asPSZ with: output_op_def with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_GraphGetTensorNumDimsWith: graph with: output with: status [

	^callEngine call: TF_GraphGetTensorNumDims with: graph with: output with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_GraphGetTensorShapeWith: graph with: output with: dims with: num_dims with: status [

	^callEngine
		call: TF_GraphGetTensorShape
		with: graph
		with: output
		with: dims
		with: num_dims
		with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_GraphImportGraphDefWith: graph with: graph_def with: options with: status [

	^callEngine call: TF_GraphImportGraphDef with: graph with: graph_def with: options with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_GraphImportGraphDefWithResultsWith: graph with: graph_def with: options with: status [

	^callEngine
		call: TF_GraphImportGraphDefWithResults
		with: graph
		with: graph_def
		with: options
		with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_GraphImportGraphDefWithReturnOutputsWith: graph with: graph_def with: options with: return_outputs with: num_return_outputs with: status [

	^callEngine
		call: TF_GraphImportGraphDefWithReturnOutputs
		with: graph
		with: graph_def
		with: options
		with: return_outputs
		with: num_return_outputs
		with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_GraphNextOperationWith: graph with: pos [

	^callEngine call: TF_GraphNextOperation with: graph with: pos
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_GraphNumFunctionsWith: g [

	^callEngine call: TF_GraphNumFunctions with: g
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_GraphOperationByNameWith: graph with: oper_name [

	^callEngine call: TF_GraphOperationByName with: graph with: oper_name asPSZ
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_GraphSetTensorShapeWith: graph with: output with: dims with: num_dims with: status [

	^callEngine
		call: TF_GraphSetTensorShape
		with: graph
		with: output
		with: dims
		with: num_dims
		with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_GraphToFunctionWith: fn_body with: fn_name with: append_hash_to_fn_name with: num_opers with: opers with: ninputs with: inputs with: noutputs with: outputs with: output_names with: opts with: description with: status [

	^callEngine
		call: TF_GraphToFunction
		with: fn_body
		with: fn_name asPSZ
		with: append_hash_to_fn_name
		with: num_opers
		with: opers
		with: ninputs
		with: inputs
		with: noutputs
		with: outputs
		with: output_names asPSZ
		with: opts
		with: description asPSZ
		with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_GraphToGraphDefWith: graph with: output_graph_def with: status [

	^callEngine call: TF_GraphToGraphDef with: graph with: output_graph_def with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_GraphVersionsWith: graph with: output_version_def with: status [

	^callEngine call: TF_GraphVersions with: graph with: output_version_def with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_ImportGraphDefOptionsAddControlDependencyWith: opts with: oper [

	^callEngine call: TF_ImportGraphDefOptionsAddControlDependency with: opts with: oper
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_ImportGraphDefOptionsAddInputMappingWith: opts with: src_name with: src_index with: dst [

	^callEngine
		call: TF_ImportGraphDefOptionsAddInputMapping
		with: opts
		with: src_name asPSZ
		with: src_index
		with: dst
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_ImportGraphDefOptionsAddReturnOperationWith: opts with: oper_name [

	^callEngine call: TF_ImportGraphDefOptionsAddReturnOperation with: opts with: oper_name asPSZ
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_ImportGraphDefOptionsAddReturnOutputWith: opts with: oper_name with: index [

	^callEngine call: TF_ImportGraphDefOptionsAddReturnOutput with: opts with: oper_name asPSZ with: index
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_ImportGraphDefOptionsNumReturnOperationsWith: opts [

	^callEngine call: TF_ImportGraphDefOptionsNumReturnOperations with: opts
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_ImportGraphDefOptionsNumReturnOutputsWith: opts [

	^callEngine call: TF_ImportGraphDefOptionsNumReturnOutputs with: opts
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_ImportGraphDefOptionsRemapControlDependencyWith: opts with: src_name with: dst [

	^callEngine
		call: TF_ImportGraphDefOptionsRemapControlDependency
		with: opts
		with: src_name asPSZ
		with: dst
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_ImportGraphDefOptionsSetDefaultDeviceWith: opts with: device [

	^callEngine call: TF_ImportGraphDefOptionsSetDefaultDevice with: opts with: device asPSZ
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_ImportGraphDefOptionsSetPrefixWith: opts with: prefix [

	^callEngine call: TF_ImportGraphDefOptionsSetPrefix with: opts with: prefix asPSZ
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_ImportGraphDefOptionsSetUniquifyNamesWith: opts with: uniquify_names [

	^callEngine call: TF_ImportGraphDefOptionsSetUniquifyNames with: opts with: uniquify_names
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_ImportGraphDefOptionsSetUniquifyPrefixWith: opts with: uniquify_prefix [

	^callEngine call: TF_ImportGraphDefOptionsSetUniquifyPrefix with: opts with: uniquify_prefix
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_ImportGraphDefResultsMissingUnusedInputMappingsWith: results with: num_missing_unused_input_mappings with: src_names with: src_indexes [

	^callEngine
		call: TF_ImportGraphDefResultsMissingUnusedInputMappings
		with: results
		with: num_missing_unused_input_mappings
		with: src_names
		with: src_indexes
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_ImportGraphDefResultsReturnOperationsWith: results with: num_opers with: opers [

	^callEngine
		call: TF_ImportGraphDefResultsReturnOperations
		with: results
		with: num_opers
		with: opers
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_ImportGraphDefResultsReturnOutputsWith: results with: num_outputs with: outputs [

	^callEngine
		call: TF_ImportGraphDefResultsReturnOutputs
		with: results
		with: num_outputs
		with: outputs
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_LoadLibraryWith: library_filename with: status [

	^callEngine call: TF_LoadLibrary with: library_filename asPSZ with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_LoadSessionFromSavedModelWith: session_options with: run_options with: export_dir with: tags with: tags_len with: graph with: meta_graph_def with: status [

	^callEngine
		call: TF_LoadSessionFromSavedModel
		with: session_options
		with: run_options
		with: export_dir asPSZ
		with: tags
		with: tags_len
		with: graph
		with: meta_graph_def
		with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_MessageWith: s [

	^callEngine call: TF_Message with: s
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_NewApiDefMapWith: op_list_buffer with: status [

	^callEngine call: TF_NewApiDefMap with: op_list_buffer with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_NewBuffer [

	^callEngine call: TF_NewBuffer
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_NewBufferFromStringWith: proto with: proto_len [

	^callEngine call: TF_NewBufferFromString with: proto with: proto_len
]

{ #category : 'Deprecated',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_NewDeprecatedSessionWith: TF_SessionOptions with: status [

	^callEngine call: TF_NewDeprecatedSession with: TF_SessionOptions with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_NewGraph [

	^callEngine call: TF_NewGraph
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_NewImportGraphDefOptions [

	^callEngine call: TF_NewImportGraphDefOptions
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_NewOperationWith: graph with: op_type with: oper_name [

	^callEngine call: TF_NewOperation with: graph with: op_type asPSZ with: oper_name asPSZ
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_NewServerWith: proto with: proto_len with: status [

	^callEngine call: TF_NewServer with: proto with: proto_len with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_NewSessionOptions [

	^callEngine call: TF_NewSessionOptions
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_NewSessionWith: graph with: opts with: status [

	^callEngine call: TF_NewSession with: graph with: opts with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_NewStatus [

	^callEngine call: TF_NewStatus
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_NewTensorWith: TF_DataType with: dims with: num_dims with: data with: len with: deallocator with: deallocator_arg [

	^callEngine
		call: TF_NewTensor
		with: TF_DataType
		with: dims
		with: num_dims
		with: data
		with: len
		with: deallocator
		with: deallocator_arg
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_NewWhileWith: g with: inputs with: ninputs with: status [

	| params |

	params := TFWhileParams new.
	callEngine call: TF_NewWhile withAll: (Array with: g with: inputs with: ninputs with: status) returnInto: params.
	^params
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_NumDimsWith: TF_Tensor [

	^callEngine call: TF_NumDims with: TF_Tensor
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationDeviceWith: oper [

	^callEngine call: TF_OperationDevice with: oper
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationGetAttrBoolListWith: oper with: attr_name with: values with: max_values with: status [

	^callEngine
		call: TF_OperationGetAttrBoolList
		with: oper
		with: attr_name asPSZ
		with: values
		with: max_values
		with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationGetAttrBoolWith: oper with: attr_name with: value with: status [

	^callEngine call: TF_OperationGetAttrBool with: oper with: attr_name asPSZ with: value with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationGetAttrFloatListWith: oper with: attr_name with: values with: max_values with: status [

	^callEngine
		call: TF_OperationGetAttrFloatList
		with: oper
		with: attr_name asPSZ
		with: values
		with: max_values
		with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationGetAttrFloatWith: oper with: attr_name with: value with: status [

	^callEngine call: TF_OperationGetAttrFloat with: oper with: attr_name asPSZ with: value with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationGetAttrIntListWith: oper with: attr_name with: values with: max_values with: status [

	^callEngine
		call: TF_OperationGetAttrIntList
		with: oper
		with: attr_name asPSZ
		with: values
		with: max_values
		with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationGetAttrIntWith: oper with: attr_name with: value with: status [

	^callEngine call: TF_OperationGetAttrInt with: oper with: attr_name asPSZ with: value with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationGetAttrMetadataWith: oper with: attrName with: status [

	| metadata |

	metadata := TFAttrMetadata new.
	callEngine call: TF_OperationGetAttrMetadata withAll: (Array with: oper with: attrName with: status) returnInto: metadata.
	^metadata
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationGetAttrShapeListWith: oper with: attr_name with: dims with: num_dims with: num_shapes with: storage with: storage_size with: status [

	^callEngine
		call: TF_OperationGetAttrShapeList
		with: oper
		with: attr_name asPSZ
		with: dims
		with: num_dims
		with: num_shapes
		with: storage
		with: storage_size
		with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationGetAttrShapeWith: oper with: attr_name with: value with: num_dims with: status [

	^callEngine
		call: TF_OperationGetAttrShape
		with: oper
		with: attr_name asPSZ
		with: value
		with: num_dims
		with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationGetAttrStringListWith: oper with: attr_name with: values with: lengths with: max_values with: storage with: storage_size with: status [

	^callEngine
		call: TF_OperationGetAttrStringList
		with: oper
		with: attr_name asPSZ
		with: values
		with: lengths
		with: max_values
		with: storage
		with: storage_size
		with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationGetAttrStringWith: oper with: attr_name with: value with: max_length with: status [

	^callEngine
		call: TF_OperationGetAttrString
		with: oper
		with: attr_name asPSZ
		with: value
		with: max_length
		with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationGetAttrTensorListWith: oper with: attr_name with: values with: max_values with: status [

	^callEngine
		call: TF_OperationGetAttrTensorList
		with: oper
		with: attr_name asPSZ
		with: values
		with: max_values
		with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationGetAttrTensorShapeProtoListWith: oper with: attr_name with: values with: max_values with: status [

	^callEngine
		call: TF_OperationGetAttrTensorShapeProtoList
		with: oper
		with: attr_name asPSZ
		with: values
		with: max_values
		with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationGetAttrTensorShapeProtoWith: oper with: attr_name with: value with: status [

	^callEngine
		call: TF_OperationGetAttrTensorShapeProto
		with: oper
		with: attr_name asPSZ
		with: value
		with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationGetAttrTensorWith: oper with: attr_name with: value with: status [

	^callEngine call: TF_OperationGetAttrTensor with: oper with: attr_name asPSZ with: value with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationGetAttrTypeListWith: oper with: attr_name with: values with: max_values with: status [

	^callEngine
		call: TF_OperationGetAttrTypeList
		with: oper
		with: attr_name asPSZ
		with: values
		with: max_values
		with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationGetAttrTypeWith: oper with: attr_name with: value with: status [

	^callEngine call: TF_OperationGetAttrType with: oper with: attr_name asPSZ with: value with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationGetAttrValueProtoWith: oper with: attr_name with: output_attr_value with: status [

	^callEngine
		call: TF_OperationGetAttrValueProto
		with: oper
		with: attr_name asPSZ
		with: output_attr_value
		with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationGetControlInputsWith: oper with: control_inputs with: max_control_inputs [

	^callEngine
		call: TF_OperationGetControlInputs
		with: oper
		with: control_inputs
		with: max_control_inputs
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationGetControlOutputsWith: oper with: control_outputs with: max_control_outputs [

	^callEngine
		call: TF_OperationGetControlOutputs
		with: oper
		with: control_outputs
		with: max_control_outputs
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationInputListLengthWith: oper with: arg_name with: status [

	^callEngine call: TF_OperationInputListLength with: oper with: arg_name asPSZ with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationInputTypeWith: oper_in [

	^callEngine call: TF_OperationInputType with: oper_in
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationNameWith: oper [

	^callEngine call: TF_OperationName with: oper
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationNumControlInputsWith: oper [

	^callEngine call: TF_OperationNumControlInputs with: oper
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationNumControlOutputsWith: oper [

	^callEngine call: TF_OperationNumControlOutputs with: oper
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationNumInputsWith: oper [

	^callEngine call: TF_OperationNumInputs with: oper
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationNumOutputsWith: oper [

	^callEngine call: TF_OperationNumOutputs with: oper
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationOpTypeWith: oper [

	^callEngine call: TF_OperationOpType with: oper
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationOutputConsumersWith: oper_out with: consumers with: max_consumers [

	^callEngine call: TF_OperationOutputConsumers with: oper_out with: consumers with: max_consumers
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationOutputListLengthWith: oper with: arg_name with: status [

	^callEngine call: TF_OperationOutputListLength with: oper with: arg_name asPSZ with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationOutputNumConsumersWith: oper_out [

	^callEngine call: TF_OperationOutputNumConsumers with: oper_out
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationOutputTypeWith: oper_out [

	^callEngine call: TF_OperationOutputType with: oper_out
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_OperationToNodeDefWith: oper with: output_node_def with: status [

	^callEngine call: TF_OperationToNodeDef with: oper with: output_node_def with: status
]

{ #category : 'Deprecated',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_PRunSetupWith: TF_DeprecatedSession with: input_names with: ninputs with: output_names with: noutputs with: target_oper_names with: ntargets with: handle with: TF_Status [

	^callEngine
		call: TF_PRunSetup
		with: TF_DeprecatedSession
		with: input_names
		with: ninputs
		with: output_names
		with: noutputs
		with: target_oper_names
		with: ntargets
		with: handle
		with: TF_Status
]

{ #category : 'Deprecated',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_PRunWith: TF_DeprecatedSession with: handle with: input_names with: inputs with: ninputs with: output_names with: outputs with: noutputs with: target_oper_names with: ntargets with: TF_Status [

	^callEngine
		call: TF_PRun
		with: TF_DeprecatedSession
		with: handle
		with: input_names
		with: inputs
		with: ninputs
		with: output_names
		with: outputs
		with: noutputs
		with: target_oper_names
		with: ntargets
		with: TF_Status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_ResetWith: opt with: containers with: ncontainers with: status [

	^callEngine call: TF_Reset with: opt with: containers with: ncontainers with: status
]

{ #category : 'Deprecated',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_RunWith: TF_DeprecatedSession with: run_options with: input_names with: inputs with: ninputs with: output_names with: outputs with: noutputs with: target_oper_names with: ntargets with: run_metadata with: TF_Status [

	^callEngine
		call: TF_Run
		with: TF_DeprecatedSession
		with: run_options
		with: input_names
		with: inputs
		with: ninputs
		with: output_names
		with: outputs
		with: noutputs
		with: target_oper_names
		with: ntargets
		with: run_metadata
		with: TF_Status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_ServerJoinWith: server with: status [

	^callEngine call: TF_ServerJoin with: server with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_ServerStartWith: server with: status [

	^callEngine call: TF_ServerStart with: server with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_ServerStopWith: server with: status [

	^callEngine call: TF_ServerStop with: server with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_ServerTargetWith: server [

	^callEngine call: TF_ServerTarget with: server
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_SessionListDevicesWith: session with: status [

	^callEngine call: TF_SessionListDevices with: session with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_SessionPRunSetupWith: TF_Session with: inputs with: ninputs with: outputs with: noutputs with: target_opers with: ntargets with: handle with: TF_Status [

	^callEngine
		call: TF_SessionPRunSetup
		with: TF_Session
		with: inputs
		with: ninputs
		with: outputs
		with: noutputs
		with: target_opers
		with: ntargets
		with: handle
		with: TF_Status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_SessionPRunWith: TF_Session with: handle with: inputs with: input_values with: ninputs with: outputs with: output_values with: noutputs with: target_opers with: ntargets with: TF_Status [

	^callEngine
		call: TF_SessionPRun
		with: TF_Session
		with: handle
		with: inputs
		with: input_values
		with: ninputs
		with: outputs
		with: output_values
		with: noutputs
		with: target_opers
		with: ntargets
		with: TF_Status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_SessionRunWith: session with: run_options with: inputs with: input_values with: ninputs with: outputs with: output_values with: noutputs with: target_opers with: ntargets with: run_metadata with: TF_Status [

	^callEngine
		call: TF_SessionRun
		with: session
		with: run_options
		with: inputs
		with: input_values
		with: ninputs
		with: outputs
		with: output_values
		with: noutputs
		with: target_opers
		with: ntargets
		with: run_metadata
		with: TF_Status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_SetAttrBoolListWith: desc with: attr_name with: values with: num_values [

	^callEngine call: TF_SetAttrBoolList with: desc with: attr_name asPSZ with: values with: num_values
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_SetAttrBoolWith: desc with: attr_name with: value [

	^callEngine call: TF_SetAttrBool with: desc with: attr_name asPSZ with: value
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_SetAttrFloatListWith: desc with: attr_name with: values with: num_values [

	^callEngine call: TF_SetAttrFloatList with: desc with: attr_name asPSZ with: values with: num_values
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_SetAttrFloatWith: desc with: attr_name with: value [

	^callEngine call: TF_SetAttrFloat with: desc with: attr_name asPSZ with: value
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_SetAttrFuncNameWith: desc with: attr_name with: value with: length [

	^callEngine call: TF_SetAttrFuncName with: desc with: attr_name asPSZ with: value with: length
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_SetAttrIntListWith: desc with: attr_name with: values with: num_values [

	^callEngine call: TF_SetAttrIntList with: desc with: attr_name asPSZ with: values with: num_values
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_SetAttrIntWith: desc with: attr_name with: value [

	^callEngine call: TF_SetAttrInt with: desc with: attr_name asPSZ with: value
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_SetAttrShapeListWith: desc with: attr_name with: dims with: num_dims with: num_shapes [

"`dims` and `num_dims` must point to arrays of length `num_shapes`.
Set `num_dims[i]` to -1 to represent 'unknown rank'.  
Otherwise, `dims[i]` points to an array of length `num_dims[i]`.  
`dims[i][j]` must be >= -1, with -1 meaning 'unknown dimension'."

	^callEngine
		call: TF_SetAttrShapeList
		with: desc
		with: attr_name asPSZ
		with: dims
		with: num_dims
		with: num_shapes
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_SetAttrShapeWith: desc with: attr_name with: dims with: num_dims [

" 
Set `num_dims` to -1 to represent 'unknown rank'.
Otherwise, `dims` points to an array of length `num_dims`.  
`dims[i]` must be >= -1, with -1 meaning 'unknown dimension'."

	^callEngine call: TF_SetAttrShape with: desc with: attr_name asPSZ with: dims with: num_dims
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_SetAttrStringListWith: desc with: attr_name with: values with: lengths with: num_values [

	^callEngine
		call: TF_SetAttrStringList
		with: desc
		with: attr_name asPSZ
		with: values
		with: lengths
		with: num_values
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_SetAttrStringWith: desc with: attr_name with: value with: length [

	^callEngine call: TF_SetAttrString with: desc with: attr_name asPSZ with: value with: length
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_SetAttrTensorListWith: desc with: attr_name with: values with: num_values with: status [

	^callEngine
		call: TF_SetAttrTensorList
		with: desc
		with: attr_name asPSZ
		with: values
		with: num_values
		with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_SetAttrTensorShapeProtoListWith: desc with: attr_name with: protos with: proto_lens with: num_shapes with: status [

	^callEngine
		call: TF_SetAttrTensorShapeProtoList
		with: desc
		with: attr_name asPSZ
		with: protos
		with: proto_lens
		with: num_shapes
		with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_SetAttrTensorShapeProtoWith: desc with: attr_name with: proto with: proto_len with: status [

	^callEngine
		call: TF_SetAttrTensorShapeProto
		with: desc
		with: attr_name asPSZ
		with: proto
		with: proto_len
		with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_SetAttrTensorWith: desc with: attr_name with: value with: status [

	^callEngine call: TF_SetAttrTensor with: desc with: attr_name asPSZ with: value with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_SetAttrTypeListWith: desc with: attr_name with: values with: num_values [

	^callEngine
		call: TF_SetAttrTypeList
		with: desc
		with: attr_name asPSZ
		with: values
		with: num_values
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_SetAttrTypeWith: desc with: attr_name with: value [

	^callEngine call: TF_SetAttrType with: desc with: attr_name asPSZ with: value
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_SetAttrValueProtoWith: desc with: attr_name with: proto with: proto_len with: status [

	^callEngine
		call: TF_SetAttrValueProto
		with: desc
		with: attr_name asPSZ
		with: proto
		with: proto_len
		with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_SetConfigWith: options with: proto with: proto_len with: status [

	^callEngine call: TF_SetConfig with: options with: proto with: proto_len with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_SetDeviceWith: desc with: device [

	^callEngine call: TF_SetDevice with: desc with: device asPSZ
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_SetStatusWith: s with: code with: msg [

	^callEngine call: TF_SetStatus with: s with: code with: msg asPSZ
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_SetTargetWith: options with: target [

	^callEngine call: TF_SetTarget with: options with: target asPSZ
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_StringDecodeWith: src with: src_len with: dst with: dst_len with: status [

	^callEngine call: TF_StringDecode with: src with: src_len with: dst with: dst_len with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_StringEncodedSizeWith: len [

	^callEngine call: TF_StringEncodedSize with: len
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_StringEncodeWith: src with: src_len with: dst with: dst_len with: status [

	^callEngine call: TF_StringEncode with: src with: src_len with: dst with: dst_len with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_TensorByteSizeWith: TF_Tensor [

	^callEngine call: TF_TensorByteSize with: TF_Tensor
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_TensorDataWith: TF_Tensor [

	^callEngine call: TF_TensorData with: TF_Tensor
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_TensorMaybeMoveWith: tensor [

	^callEngine call: TF_TensorMaybeMove with: tensor
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_TensorTypeWith: tensor [

	^callEngine call: TF_TensorType with: tensor
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_TryEvaluateConstantWith: graph with: output with: result with: status [

	^callEngine call: TF_TryEvaluateConstant with: graph with: output with: result with: status
]

{ #category : 'Functions',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> callTF_Version [

	^(OSStringZ address: (callEngine call: TF_Version)) asString
]

{ #category : 'Initialize',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> initialize: aTFCallEngine [
	"Initialize this dispatcher
	 
	 Arguments:
		aTFCallEngine - <TFCallEngine>"

	self callEngine: aTFCallEngine
]

{ #category : 'Initialize',
  #vaVisibility : 'private' }
TFLibraryDispatcher >> release [
	"Release resources.  Inform call engine"

	callEngine release
]
