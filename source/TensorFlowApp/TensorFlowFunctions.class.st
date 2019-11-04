Class {
	#name : 'TensorFlowFunctions',
	#superclass : 'SharedPool',
	#classVars : [
		'TF_StringDecode',
		'TF_ImportGraphDefOptionsSetDefaultDevice',
		'TF_GraphGetTensorShape',
		'TF_OperationNumControlInputs',
		'TF_OperationGetAttrString',
		'TF_OperationGetControlInputs',
		'TF_ApiDefMapGet',
		'TF_LoadSessionFromSavedModel',
		'TF_PRunSetup',
		'TF_GraphImportGraphDefWithReturnOutputs',
		'TF_GetOpList',
		'TF_GetRegisteredKernelsForOp',
		'TF_OperationGetAttrTensorList',
		'TF_StringEncode',
		'TF_OperationGetAttrFloat',
		'TF_NewOperation',
		'TF_OperationGetAttrIntList',
		'TF_FinishWhile',
		'TF_SetAttrFloat',
		'TF_SetAttrStringList',
		'TF_SetAttrString',
		'TF_GraphNextOperation',
		'TF_DeleteGraph',
		'TF_GetAllRegisteredKernels',
		'TF_PRun',
		'TF_FunctionToFunctionDef',
		'TF_DeviceListIncarnation',
		'TF_ImportGraphDefOptionsNumReturnOutputs',
		'TF_SetAttrBool',
		'TF_SessionListDevices',
		'TF_OperationToNodeDef',
		'TF_DeleteBuffer',
		'TF_SetAttrIntList',
		'TF_Dim',
		'TF_GraphVersions',
		'TF_ImportGraphDefOptionsNumReturnOperations',
		'TF_GraphGetFunctions',
		'TF_Run',
		'TF_FunctionName',
		'TF_DeviceListCount',
		'TF_TensorData',
		'TF_AddInput',
		'TF_NewSessionOptions',
		'TF_DeviceListName',
		'TF_ServerJoin',
		'TF_SetAttrTensorShapeProto',
		'TF_SetStatus',
		'TF_OperationGetAttrTensorShapeProtoList',
		'TF_OperationNumControlOutputs',
		'TF_GraphToFunction',
		'TF_DeleteImportGraphDefOptions',
		'TF_TensorMaybeMove',
		'TF_GraphCopyFunction',
		'TF_NewImportGraphDefOptions',
		'TF_SetAttrTypeList',
		'TF_GetCode',
		'TF_OperationGetAttrBoolList',
		'TF_DataTypeSize',
		'TF_SetConfig',
		'TF_OperationGetAttrTensor',
		'TF_SetAttrValueProto',
		'TF_GetAllOpList',
		'TF_ApiDefMapPut',
		'TF_ImportGraphDefOptionsAddControlDependency',
		'TF_AddGradients',
		'TF_SetAttrTensorList',
		'TF_CloseDeprecatedSession',
		'TF_NumDims',
		'TF_SetAttrInt',
		'TF_DeleteSessionOptions',
		'TF_OperationGetAttrFloatList',
		'TF_FunctionSetAttrValueProto',
		'TF_OperationOutputConsumers',
		'TF_GraphNumFunctions',
		'TF_OperationGetControlOutputs',
		'TF_OperationGetAttrType',
		'TF_ImportGraphDefOptionsAddInputMapping',
		'TF_Reset',
		'TF_ServerStop',
		'TF_OperationGetAttrTensorShapeProto',
		'TF_Version',
		'TF_FinishOperation',
		'TF_ServerStart',
		'TF_GetBuffer',
		'TF_Message',
		'TF_AddInputList',
		'TF_DeleteFunction',
		'TF_TensorType',
		'TF_NewBufferFromString',
		'TF_FunctionImportFunctionDef',
		'TF_SetAttrType',
		'TF_NewTensor',
		'TF_OperationInputType',
		'TF_OperationGetAttrStringList',
		'TF_OperationName',
		'TF_GraphOperationByName',
		'TF_OperationNumOutputs',
		'TF_FunctionGetAttrValueProto',
		'TF_OperationNumInputs',
		'TF_NewGraph',
		'TF_DeleteTensor',
		'TF_OperationGetAttrShapeList',
		'TF_ImportGraphDefOptionsSetPrefix',
		'TF_GraphGetTensorNumDims',
		'TF_SessionPRunSetup',
		'TF_ServerTarget',
		'TF_ImportGraphDefOptionsSetUniquifyNames',
		'TF_SetAttrShape',
		'TF_NewSession',
		'TF_DeviceListMemoryBytes',
		'TF_SetAttrShapeList',
		'TF_ImportGraphDefResultsMissingUnusedInputMappings',
		'TF_OperationInputListLength',
		'TF_ImportGraphDefOptionsAddReturnOperation',
		'TF_SetTarget',
		'TF_SetAttrFuncName',
		'TF_ImportGraphDefOptionsAddReturnOutput',
		'TF_GraphToFunctionWithControlOutputs',
		'TF_OperationGetAttrBool',
		'TF_SessionPRun',
		'TF_ExtendGraph',
		'TF_OperationGetAttrValueProto',
		'TF_OperationOutputListLength',
		'TF_OperationGetAttrMetadata',
		'TF_NewApiDefMap',
		'TF_CloseSession',
		'TF_NewServer',
		'TF_ImportGraphDefResultsReturnOperations',
		'TF_AddGradientsWithPrefix',
		'TF_GraphGetOpDef',
		'TF_SetAttrTensorShapeProtoList',
		'TF_SetAttrTensor',
		'TF_GraphToGraphDef',
		'TF_OperationGetAttrInt',
		'TF_TensorByteSize',
		'TF_AddControlInput',
		'TF_OperationDevice',
		'TF_DeletePRunHandle',
		'TF_DeleteSession',
		'TF_AbortWhile',
		'TF_OperationGetAttrTypeList',
		'TF_StringEncodedSize',
		'TF_DeleteLibraryHandle',
		'TF_SetDevice',
		'TF_DeleteStatus',
		'TF_TryEvaluateConstant',
		'TF_ImportGraphDefOptionsRemapControlDependency',
		'TF_OperationOutputType',
		'TF_NewDeprecatedSession',
		'TF_SessionRun',
		'TF_NewWhile',
		'TF_DeprecatedSessionListDevices',
		'TF_NewBuffer',
		'TF_DeleteDeprecatedSession',
		'TF_ImportGraphDefResultsReturnOutputs',
		'TF_AllocateTensor',
		'TF_OperationGetAttrShape',
		'TF_ImportGraphDefOptionsSetUniquifyPrefix',
		'TF_DeleteApiDefMap',
		'TF_DeleteImportGraphDefResults',
		'TF_OperationOpType',
		'TF_NewStatus',
		'TF_GraphImportGraphDefWithResults',
		'TF_DeviceListType',
		'TF_DeleteServer',
		'TF_OperationOutputNumConsumers',
		'TF_ColocateWith',
		'TF_DeleteDeviceList',
		'TF_GraphImportGraphDef',
		'TF_SetAttrBoolList',
		'TF_LoadLibrary',
		'TF_SetAttrFloatList',
		'TF_GraphSetTensorShape'
	],
	#type : 'variable',
	#category : 'TensorFlowApp'
}

{
	#category : 'Initializing'
}
TensorFlowFunctions class >> initialize [
	TF_ApiDefMapPut := (PlatformFunction callingConvention: #c
   function: 'TF_ApiDefMapPut'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer)
   returnType: #void).
	TF_DeleteDeprecatedSession := (PlatformFunction callingConvention: #c
   function: 'TF_DeleteDeprecatedSession'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer)
   returnType: #void).
	TF_AddGradientsWithPrefix := (PlatformFunction callingConvention: #c
   function: 'TF_AddGradientsWithPrefix'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #int32 #pointer #int32 #pointer #pointer #pointer)
   returnType: #void).
	TF_FinishWhile := (PlatformFunction callingConvention: #c
   function: 'TF_FinishWhile'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer)
   returnType: #void).
	TF_NewWhile := (PlatformFunction callingConvention: #c
   function: 'TF_NewWhile'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #int32 #pointer)
   returnType: #struct).
	TF_PRunSetup := (PlatformFunction callingConvention: #c
   function: 'TF_PRunSetup'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #int32 #pointer #int32 #pointer #int32 #pointer #pointer)
   returnType: #void).
	TF_ServerTarget := (PlatformFunction callingConvention: #c
   function: 'TF_ServerTarget'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #pointer).
	TF_DeleteDeviceList := (PlatformFunction callingConvention: #c
   function: 'TF_DeleteDeviceList'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #void).
	TF_GraphSetTensorShape := (PlatformFunction callingConvention: #c
   function: 'TF_GraphSetTensorShape'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #bytes #pointer #int32 #pointer)
   returnType: #void).
	TF_SetAttrTypeList := (PlatformFunction callingConvention: #c
   function: 'TF_SetAttrTypeList'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #int32)
   returnType: #void).
	TF_TensorData := (PlatformFunction callingConvention: #c
   function: 'TF_TensorData'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #pointer).
	TF_DeleteImportGraphDefResults := (PlatformFunction callingConvention: #c
   function: 'TF_DeleteImportGraphDefResults'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #void).
	TF_AllocateTensor := (PlatformFunction callingConvention: #c
   function: 'TF_AllocateTensor'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#uint32 #pointer #int32 #pointer)
   returnType: #pointer).
	TF_ImportGraphDefOptionsAddReturnOperation := (PlatformFunction callingConvention: #c
   function: 'TF_ImportGraphDefOptionsAddReturnOperation'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer)
   returnType: #void).
	TF_SetAttrShape := (PlatformFunction callingConvention: #c
   function: 'TF_SetAttrShape'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #int32)
   returnType: #void).
	TF_SetAttrInt := (PlatformFunction callingConvention: #c
   function: 'TF_SetAttrInt'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #int32)
   returnType: #void).
	TF_OperationGetAttrString := (PlatformFunction callingConvention: #c
   function: 'TF_OperationGetAttrString'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer #pointer)
   returnType: #void).
	TF_OperationGetControlInputs := (PlatformFunction callingConvention: #c
   function: 'TF_OperationGetControlInputs'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #int32)
   returnType: #int32).
	TF_GraphCopyFunction := (PlatformFunction callingConvention: #c
   function: 'TF_GraphCopyFunction'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer)
   returnType: #void).
	TF_NewBufferFromString := (PlatformFunction callingConvention: #c
   function: 'TF_NewBufferFromString'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer)
   returnType: #pointer).
	TF_OperationGetAttrStringList := (PlatformFunction callingConvention: #c
   function: 'TF_OperationGetAttrStringList'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer #int32 #pointer #pointer #pointer)
   returnType: #void).
	TF_FunctionGetAttrValueProto := (PlatformFunction callingConvention: #c
   function: 'TF_FunctionGetAttrValueProto'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer)
   returnType: #void).
	TF_SetConfig := (PlatformFunction callingConvention: #c
   function: 'TF_SetConfig'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer)
   returnType: #void).
	TF_StringDecode := (PlatformFunction callingConvention: #c
   function: 'TF_StringDecode'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer #pointer)
   returnType: #pointer).
	TF_SessionRun := (PlatformFunction callingConvention: #c
   function: 'TF_SessionRun'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer #int32 #pointer #pointer #int32 #pointer #int32 #pointer #pointer)
   returnType: #void).
	TF_DeviceListIncarnation := (PlatformFunction callingConvention: #c
   function: 'TF_DeviceListIncarnation'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #int32 #pointer)
   returnType: #uint64).
	TF_GraphImportGraphDef := (PlatformFunction callingConvention: #c
   function: 'TF_GraphImportGraphDef'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer)
   returnType: #void).
	TF_OperationGetAttrTypeList := (PlatformFunction callingConvention: #c
   function: 'TF_OperationGetAttrTypeList'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #int32 #pointer)
   returnType: #void).
	TF_NewServer := (PlatformFunction callingConvention: #c
   function: 'TF_NewServer'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer)
   returnType: #pointer).
	TF_OperationToNodeDef := (PlatformFunction callingConvention: #c
   function: 'TF_OperationToNodeDef'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer)
   returnType: #void).
	TF_DeleteBuffer := (PlatformFunction callingConvention: #c
   function: 'TF_DeleteBuffer'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #void).
	TF_OperationNumInputs := (PlatformFunction callingConvention: #c
   function: 'TF_OperationNumInputs'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #int32).
	TF_GraphToFunctionWithControlOutputs := (PlatformFunction callingConvention: #c
   function: 'TF_GraphToFunctionWithControlOutputs'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #uint8 #int32 #pointer #int32 #pointer #int32 #pointer #pointer #int32 #pointer #pointer #pointer #pointer #pointer)
   returnType: #pointer).
	TF_OperationGetAttrFloatList := (PlatformFunction callingConvention: #c
   function: 'TF_OperationGetAttrFloatList'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #int32 #pointer)
   returnType: #void).
	TF_SetAttrStringList := (PlatformFunction callingConvention: #c
   function: 'TF_SetAttrStringList'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer #int32)
   returnType: #void).
	TF_StringEncode := (PlatformFunction callingConvention: #c
   function: 'TF_StringEncode'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer #pointer)
   returnType: #pointer).
	TF_DeleteStatus := (PlatformFunction callingConvention: #c
   function: 'TF_DeleteStatus'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #void).
	TF_TensorType := (PlatformFunction callingConvention: #c
   function: 'TF_TensorType'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #uint32).
	TF_OperationGetAttrTensorList := (PlatformFunction callingConvention: #c
   function: 'TF_OperationGetAttrTensorList'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #int32 #pointer)
   returnType: #void).
	TF_ApiDefMapGet := (PlatformFunction callingConvention: #c
   function: 'TF_ApiDefMapGet'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer)
   returnType: #pointer).
	TF_DeviceListType := (PlatformFunction callingConvention: #c
   function: 'TF_DeviceListType'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #int32 #pointer)
   returnType: #pointer).
	TF_SetAttrString := (PlatformFunction callingConvention: #c
   function: 'TF_SetAttrString'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer)
   returnType: #void).
	TF_ImportGraphDefOptionsRemapControlDependency := (PlatformFunction callingConvention: #c
   function: 'TF_ImportGraphDefOptionsRemapControlDependency'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer)
   returnType: #void).
	TF_TryEvaluateConstant := (PlatformFunction callingConvention: #c
   function: 'TF_TryEvaluateConstant'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #bytes #pointer #pointer)
   returnType: #uint8).
	TF_ImportGraphDefOptionsSetUniquifyNames := (PlatformFunction callingConvention: #c
   function: 'TF_ImportGraphDefOptionsSetUniquifyNames'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #uint8)
   returnType: #void).
	TF_OperationGetControlOutputs := (PlatformFunction callingConvention: #c
   function: 'TF_OperationGetControlOutputs'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #int32)
   returnType: #int32).
	TF_OperationGetAttrValueProto := (PlatformFunction callingConvention: #c
   function: 'TF_OperationGetAttrValueProto'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer)
   returnType: #void).
	TF_ImportGraphDefOptionsSetUniquifyPrefix := (PlatformFunction callingConvention: #c
   function: 'TF_ImportGraphDefOptionsSetUniquifyPrefix'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #uint8)
   returnType: #void).
	TF_NewSessionOptions := (PlatformFunction callingConvention: #c
   function: 'TF_NewSessionOptions'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #()
   returnType: #pointer).
	TF_ExtendGraph := (PlatformFunction callingConvention: #c
   function: 'TF_ExtendGraph'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer)
   returnType: #void).
	TF_LoadLibrary := (PlatformFunction callingConvention: #c
   function: 'TF_LoadLibrary'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer)
   returnType: #pointer).
	TF_OperationGetAttrBool := (PlatformFunction callingConvention: #c
   function: 'TF_OperationGetAttrBool'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer)
   returnType: #void).
	TF_OperationNumControlOutputs := (PlatformFunction callingConvention: #c
   function: 'TF_OperationNumControlOutputs'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #int32).
	TF_TensorMaybeMove := (PlatformFunction callingConvention: #c
   function: 'TF_TensorMaybeMove'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #pointer).
	TF_ServerStop := (PlatformFunction callingConvention: #c
   function: 'TF_ServerStop'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer)
   returnType: #void).
	TF_ServerStart := (PlatformFunction callingConvention: #c
   function: 'TF_ServerStart'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer)
   returnType: #void).
	TF_NewStatus := (PlatformFunction callingConvention: #c
   function: 'TF_NewStatus'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #()
   returnType: #pointer).
	TF_AddControlInput := (PlatformFunction callingConvention: #c
   function: 'TF_AddControlInput'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer)
   returnType: #void).
	TF_LoadSessionFromSavedModel := (PlatformFunction callingConvention: #c
   function: 'TF_LoadSessionFromSavedModel'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer #int32 #pointer #pointer #pointer)
   returnType: #pointer).
	TF_NewImportGraphDefOptions := (PlatformFunction callingConvention: #c
   function: 'TF_NewImportGraphDefOptions'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #()
   returnType: #pointer).
	TF_CloseDeprecatedSession := (PlatformFunction callingConvention: #c
   function: 'TF_CloseDeprecatedSession'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer)
   returnType: #void).
	TF_ImportGraphDefResultsReturnOperations := (PlatformFunction callingConvention: #c
   function: 'TF_ImportGraphDefResultsReturnOperations'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer)
   returnType: #void).
	TF_OperationInputType := (PlatformFunction callingConvention: #c
   function: 'TF_OperationInputType'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#bytes)
   returnType: #uint32).
	TF_Version := (PlatformFunction callingConvention: #c
   function: 'TF_Version'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #()
   returnType: #pointer).
	TF_OperationOutputConsumers := (PlatformFunction callingConvention: #c
   function: 'TF_OperationOutputConsumers'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#bytes #pointer #int32)
   returnType: #int32).
	TF_DeleteGraph := (PlatformFunction callingConvention: #c
   function: 'TF_DeleteGraph'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #void).
	TF_SetAttrBool := (PlatformFunction callingConvention: #c
   function: 'TF_SetAttrBool'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #uint8)
   returnType: #void).
	TF_ColocateWith := (PlatformFunction callingConvention: #c
   function: 'TF_ColocateWith'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer)
   returnType: #void).
	TF_NewDeprecatedSession := (PlatformFunction callingConvention: #c
   function: 'TF_NewDeprecatedSession'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer)
   returnType: #pointer).
	TF_SetAttrBoolList := (PlatformFunction callingConvention: #c
   function: 'TF_SetAttrBoolList'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #int32)
   returnType: #void).
	TF_SetAttrType := (PlatformFunction callingConvention: #c
   function: 'TF_SetAttrType'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #uint32)
   returnType: #void).
	TF_SetAttrFloat := (PlatformFunction callingConvention: #c
   function: 'TF_SetAttrFloat'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #float)
   returnType: #void).
	TF_ImportGraphDefOptionsAddReturnOutput := (PlatformFunction callingConvention: #c
   function: 'TF_ImportGraphDefOptionsAddReturnOutput'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #int32)
   returnType: #void).
	TF_GraphToGraphDef := (PlatformFunction callingConvention: #c
   function: 'TF_GraphToGraphDef'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer)
   returnType: #void).
	TF_OperationGetAttrTensorShapeProtoList := (PlatformFunction callingConvention: #c
   function: 'TF_OperationGetAttrTensorShapeProtoList'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #int32 #pointer)
   returnType: #void).
	TF_CloseSession := (PlatformFunction callingConvention: #c
   function: 'TF_CloseSession'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer)
   returnType: #void).
	TF_GetOpList := (PlatformFunction callingConvention: #c
   function: 'TF_GetOpList'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #struct).
	TF_OperationGetAttrTensorShapeProto := (PlatformFunction callingConvention: #c
   function: 'TF_OperationGetAttrTensorShapeProto'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer)
   returnType: #void).
	TF_GetRegisteredKernelsForOp := (PlatformFunction callingConvention: #c
   function: 'TF_GetRegisteredKernelsForOp'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer)
   returnType: #pointer).
	TF_GraphImportGraphDefWithReturnOutputs := (PlatformFunction callingConvention: #c
   function: 'TF_GraphImportGraphDefWithReturnOutputs'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer #int32 #pointer)
   returnType: #void).
	TF_DeleteLibraryHandle := (PlatformFunction callingConvention: #c
   function: 'TF_DeleteLibraryHandle'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #void).
	TF_SessionPRunSetup := (PlatformFunction callingConvention: #c
   function: 'TF_SessionPRunSetup'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #int32 #pointer #int32 #pointer #int32 #pointer #pointer)
   returnType: #void).
	TF_SessionPRun := (PlatformFunction callingConvention: #c
   function: 'TF_SessionPRun'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer #int32 #pointer #pointer #int32 #pointer #int32 #pointer)
   returnType: #void).
	TF_DeletePRunHandle := (PlatformFunction callingConvention: #c
   function: 'TF_DeletePRunHandle'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #void).
	TF_OperationGetAttrShape := (PlatformFunction callingConvention: #c
   function: 'TF_OperationGetAttrShape'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #int32 #pointer)
   returnType: #void).
	TF_FunctionImportFunctionDef := (PlatformFunction callingConvention: #c
   function: 'TF_FunctionImportFunctionDef'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer)
   returnType: #pointer).
	TF_ImportGraphDefResultsReturnOutputs := (PlatformFunction callingConvention: #c
   function: 'TF_ImportGraphDefResultsReturnOutputs'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer)
   returnType: #void).
	TF_GetAllOpList := (PlatformFunction callingConvention: #c
   function: 'TF_GetAllOpList'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #()
   returnType: #pointer).
	TF_GraphGetTensorNumDims := (PlatformFunction callingConvention: #c
   function: 'TF_GraphGetTensorNumDims'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #bytes #pointer)
   returnType: #int32).
	TF_SetAttrTensorShapeProtoList := (PlatformFunction callingConvention: #c
   function: 'TF_SetAttrTensorShapeProtoList'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer #int32 #pointer)
   returnType: #void).
	TF_GraphGetTensorShape := (PlatformFunction callingConvention: #c
   function: 'TF_GraphGetTensorShape'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #bytes #pointer #int32 #pointer)
   returnType: #void).
	TF_OperationNumControlInputs := (PlatformFunction callingConvention: #c
   function: 'TF_OperationNumControlInputs'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #int32).
	TF_GetBuffer := (PlatformFunction callingConvention: #c
   function: 'TF_GetBuffer'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #struct).
	TF_GraphVersions := (PlatformFunction callingConvention: #c
   function: 'TF_GraphVersions'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer)
   returnType: #void).
	TF_SetAttrFuncName := (PlatformFunction callingConvention: #c
   function: 'TF_SetAttrFuncName'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer)
   returnType: #void).
	TF_AddInputList := (PlatformFunction callingConvention: #c
   function: 'TF_AddInputList'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #int32)
   returnType: #void).
	TF_Message := (PlatformFunction callingConvention: #c
   function: 'TF_Message'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #pointer).
	TF_NewBuffer := (PlatformFunction callingConvention: #c
   function: 'TF_NewBuffer'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #()
   returnType: #pointer).
	TF_SetAttrTensorShapeProto := (PlatformFunction callingConvention: #c
   function: 'TF_SetAttrTensorShapeProto'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer #pointer)
   returnType: #void).
	TF_OperationGetAttrIntList := (PlatformFunction callingConvention: #c
   function: 'TF_OperationGetAttrIntList'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #int32 #pointer)
   returnType: #void).
	TF_SetStatus := (PlatformFunction callingConvention: #c
   function: 'TF_SetStatus'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #uint32 #pointer)
   returnType: #void).
	TF_DeleteImportGraphDefOptions := (PlatformFunction callingConvention: #c
   function: 'TF_DeleteImportGraphDefOptions'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #void).
	TF_SetAttrShapeList := (PlatformFunction callingConvention: #c
   function: 'TF_SetAttrShapeList'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer #int32)
   returnType: #void).
	TF_SetTarget := (PlatformFunction callingConvention: #c
   function: 'TF_SetTarget'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer)
   returnType: #void).
	TF_TensorByteSize := (PlatformFunction callingConvention: #c
   function: 'TF_TensorByteSize'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #pointer).
	TF_OperationGetAttrShapeList := (PlatformFunction callingConvention: #c
   function: 'TF_OperationGetAttrShapeList'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer #int32 #pointer #int32 #pointer)
   returnType: #void).
	TF_SetAttrTensor := (PlatformFunction callingConvention: #c
   function: 'TF_SetAttrTensor'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer)
   returnType: #void).
	TF_AbortWhile := (PlatformFunction callingConvention: #c
   function: 'TF_AbortWhile'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #void).
	TF_NewApiDefMap := (PlatformFunction callingConvention: #c
   function: 'TF_NewApiDefMap'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer)
   returnType: #pointer).
	TF_OperationInputListLength := (PlatformFunction callingConvention: #c
   function: 'TF_OperationInputListLength'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer)
   returnType: #int32).
	TF_NewGraph := (PlatformFunction callingConvention: #c
   function: 'TF_NewGraph'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #()
   returnType: #pointer).
	TF_OperationGetAttrInt := (PlatformFunction callingConvention: #c
   function: 'TF_OperationGetAttrInt'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer)
   returnType: #void).
	TF_StringEncodedSize := (PlatformFunction callingConvention: #c
   function: 'TF_StringEncodedSize'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #pointer).
	TF_GraphToFunction := (PlatformFunction callingConvention: #c
   function: 'TF_GraphToFunction'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #uint8 #int32 #pointer #int32 #pointer #int32 #pointer #pointer #pointer #pointer #pointer)
   returnType: #pointer).
	TF_OperationGetAttrBoolList := (PlatformFunction callingConvention: #c
   function: 'TF_OperationGetAttrBoolList'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #int32 #pointer)
   returnType: #void).
	TF_ImportGraphDefOptionsNumReturnOutputs := (PlatformFunction callingConvention: #c
   function: 'TF_ImportGraphDefOptionsNumReturnOutputs'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #int32).
	TF_Reset := (PlatformFunction callingConvention: #c
   function: 'TF_Reset'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #int32 #pointer)
   returnType: #void).
	TF_ServerJoin := (PlatformFunction callingConvention: #c
   function: 'TF_ServerJoin'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer)
   returnType: #void).
	TF_GraphNumFunctions := (PlatformFunction callingConvention: #c
   function: 'TF_GraphNumFunctions'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #int32).
	TF_AddInput := (PlatformFunction callingConvention: #c
   function: 'TF_AddInput'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #bytes)
   returnType: #void).
	TF_AddGradients := (PlatformFunction callingConvention: #c
   function: 'TF_AddGradients'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #int32 #pointer #int32 #pointer #pointer #pointer)
   returnType: #void).
	TF_DeviceListMemoryBytes := (PlatformFunction callingConvention: #c
   function: 'TF_DeviceListMemoryBytes'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #int32 #pointer)
   returnType: #int32).
	TF_PRun := (PlatformFunction callingConvention: #c
   function: 'TF_PRun'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer #int32 #pointer #pointer #int32 #pointer #int32 #pointer)
   returnType: #void).
	TF_OperationGetAttrMetadata := (PlatformFunction callingConvention: #c
   function: 'TF_OperationGetAttrMetadata'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer)
   returnType: #struct).
	TF_GraphGetOpDef := (PlatformFunction callingConvention: #c
   function: 'TF_GraphGetOpDef'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer)
   returnType: #void).
	TF_NewOperation := (PlatformFunction callingConvention: #c
   function: 'TF_NewOperation'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer)
   returnType: #pointer).
	TF_DeprecatedSessionListDevices := (PlatformFunction callingConvention: #c
   function: 'TF_DeprecatedSessionListDevices'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer)
   returnType: #pointer).
	TF_ImportGraphDefOptionsAddControlDependency := (PlatformFunction callingConvention: #c
   function: 'TF_ImportGraphDefOptionsAddControlDependency'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer)
   returnType: #void).
	TF_NewTensor := (PlatformFunction callingConvention: #c
   function: 'TF_NewTensor'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#uint32 #pointer #int32 #pointer #pointer #pointer #pointer)
   returnType: #pointer).
	TF_SetAttrIntList := (PlatformFunction callingConvention: #c
   function: 'TF_SetAttrIntList'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #int32)
   returnType: #void).
	TF_OperationOutputType := (PlatformFunction callingConvention: #c
   function: 'TF_OperationOutputType'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#bytes)
   returnType: #uint32).
	TF_FunctionName := (PlatformFunction callingConvention: #c
   function: 'TF_FunctionName'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #pointer).
	TF_OperationGetAttrTensor := (PlatformFunction callingConvention: #c
   function: 'TF_OperationGetAttrTensor'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer)
   returnType: #void).
	TF_DataTypeSize := (PlatformFunction callingConvention: #c
   function: 'TF_DataTypeSize'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#uint32)
   returnType: #pointer).
	TF_OperationGetAttrFloat := (PlatformFunction callingConvention: #c
   function: 'TF_OperationGetAttrFloat'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer)
   returnType: #void).
	TF_DeviceListCount := (PlatformFunction callingConvention: #c
   function: 'TF_DeviceListCount'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #int32).
	TF_FunctionToFunctionDef := (PlatformFunction callingConvention: #c
   function: 'TF_FunctionToFunctionDef'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer)
   returnType: #void).
	TF_DeleteApiDefMap := (PlatformFunction callingConvention: #c
   function: 'TF_DeleteApiDefMap'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #void).
	TF_SetDevice := (PlatformFunction callingConvention: #c
   function: 'TF_SetDevice'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer)
   returnType: #void).
	TF_Run := (PlatformFunction callingConvention: #c
   function: 'TF_Run'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer #int32 #pointer #pointer #int32 #pointer #int32 #pointer #pointer)
   returnType: #void).
	TF_OperationDevice := (PlatformFunction callingConvention: #c
   function: 'TF_OperationDevice'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #pointer).
	TF_OperationName := (PlatformFunction callingConvention: #c
   function: 'TF_OperationName'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #pointer).
	TF_ImportGraphDefOptionsAddInputMapping := (PlatformFunction callingConvention: #c
   function: 'TF_ImportGraphDefOptionsAddInputMapping'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #int32 #bytes)
   returnType: #void).
	TF_NumDims := (PlatformFunction callingConvention: #c
   function: 'TF_NumDims'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #int32).
	TF_DeleteFunction := (PlatformFunction callingConvention: #c
   function: 'TF_DeleteFunction'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #void).
	TF_FunctionSetAttrValueProto := (PlatformFunction callingConvention: #c
   function: 'TF_FunctionSetAttrValueProto'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer #pointer)
   returnType: #void).
	TF_DeleteTensor := (PlatformFunction callingConvention: #c
   function: 'TF_DeleteTensor'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #void).
	TF_SessionListDevices := (PlatformFunction callingConvention: #c
   function: 'TF_SessionListDevices'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer)
   returnType: #pointer).
	TF_OperationGetAttrType := (PlatformFunction callingConvention: #c
   function: 'TF_OperationGetAttrType'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer)
   returnType: #void).
	TF_DeleteSessionOptions := (PlatformFunction callingConvention: #c
   function: 'TF_DeleteSessionOptions'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #void).
	TF_NewSession := (PlatformFunction callingConvention: #c
   function: 'TF_NewSession'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer)
   returnType: #pointer).
	TF_DeviceListName := (PlatformFunction callingConvention: #c
   function: 'TF_DeviceListName'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #int32 #pointer)
   returnType: #pointer).
	TF_GraphGetFunctions := (PlatformFunction callingConvention: #c
   function: 'TF_GraphGetFunctions'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #int32 #pointer)
   returnType: #int32).
	TF_SetAttrFloatList := (PlatformFunction callingConvention: #c
   function: 'TF_SetAttrFloatList'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #int32)
   returnType: #void).
	TF_OperationOpType := (PlatformFunction callingConvention: #c
   function: 'TF_OperationOpType'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #pointer).
	TF_SetAttrValueProto := (PlatformFunction callingConvention: #c
   function: 'TF_SetAttrValueProto'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer #pointer)
   returnType: #void).
	TF_DeleteServer := (PlatformFunction callingConvention: #c
   function: 'TF_DeleteServer'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #void).
	TF_GraphImportGraphDefWithResults := (PlatformFunction callingConvention: #c
   function: 'TF_GraphImportGraphDefWithResults'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer)
   returnType: #pointer).
	TF_OperationOutputListLength := (PlatformFunction callingConvention: #c
   function: 'TF_OperationOutputListLength'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer)
   returnType: #int32).
	TF_Dim := (PlatformFunction callingConvention: #c
   function: 'TF_Dim'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #int32)
   returnType: #int32).
	TF_ImportGraphDefOptionsSetPrefix := (PlatformFunction callingConvention: #c
   function: 'TF_ImportGraphDefOptionsSetPrefix'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer)
   returnType: #void).
	TF_ImportGraphDefOptionsNumReturnOperations := (PlatformFunction callingConvention: #c
   function: 'TF_ImportGraphDefOptionsNumReturnOperations'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #int32).
	TF_GetAllRegisteredKernels := (PlatformFunction callingConvention: #c
   function: 'TF_GetAllRegisteredKernels'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #pointer).
	TF_GetCode := (PlatformFunction callingConvention: #c
   function: 'TF_GetCode'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #uint32).
	TF_OperationNumOutputs := (PlatformFunction callingConvention: #c
   function: 'TF_OperationNumOutputs'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer)
   returnType: #int32).
	TF_DeleteSession := (PlatformFunction callingConvention: #c
   function: 'TF_DeleteSession'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer)
   returnType: #void).
	TF_ImportGraphDefOptionsSetDefaultDevice := (PlatformFunction callingConvention: #c
   function: 'TF_ImportGraphDefOptionsSetDefaultDevice'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer)
   returnType: #void).
	TF_GraphNextOperation := (PlatformFunction callingConvention: #c
   function: 'TF_GraphNextOperation'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer)
   returnType: #pointer).
	TF_FinishOperation := (PlatformFunction callingConvention: #c
   function: 'TF_FinishOperation'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer)
   returnType: #pointer).
	TF_OperationOutputNumConsumers := (PlatformFunction callingConvention: #c
   function: 'TF_OperationOutputNumConsumers'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#bytes)
   returnType: #int32).
	TF_GraphOperationByName := (PlatformFunction callingConvention: #c
   function: 'TF_GraphOperationByName'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer)
   returnType: #pointer).
	TF_ImportGraphDefResultsMissingUnusedInputMappings := (PlatformFunction callingConvention: #c
   function: 'TF_ImportGraphDefResultsMissingUnusedInputMappings'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #pointer)
   returnType: #void).
	TF_SetAttrTensorList := (PlatformFunction callingConvention: #c
   function: 'TF_SetAttrTensorList'
   library: 'TENSORFLOW_LIB'
   parameterTypes: #(#pointer #pointer #pointer #int32 #pointer)
   returnType: #void).

]
