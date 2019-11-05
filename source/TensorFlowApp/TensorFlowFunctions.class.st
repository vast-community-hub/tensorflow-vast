Class {
	#name : 'TensorFlowFunctions',
	#superclass : 'SharedPool',
	#classVars : [
		'TF_Version',
		'TF_DataTypeSize',
		'TF_NewStatus',
		'TF_DeleteStatus',
		'TF_GetBuffer',
		'TF_SetStatus',
		'TF_GetCode',
		'TF_Message',
		'TF_NewBufferFromString',
		'TF_NewBuffer',
		'TF_DeleteBuffer',
		'TF_NewTensor',
		'TF_AllocateTensor',
		'TF_TensorMaybeMove',
		'TF_DeleteTensor',
		'TF_TensorType',
		'TF_NumDims',
		'TF_Dim',
		'TF_TensorByteSize',
		'TF_TensorData',
		'TF_StringEncode',
		'TF_StringDecode',
		'TF_StringEncodedSize',
		'TF_NewSessionOptions',
		'TF_SetTarget',
		'TF_SetConfig',
		'TF_DeleteSessionOptions',
		'TF_NewGraph',
		'TF_DeleteGraph',
		'TF_GraphSetTensorShape',
		'TF_GraphGetTensorNumDims',
		'TF_GraphGetTensorShape',
		'TF_NewOperation',
		'TF_SetDevice',
		'TF_AddInput',
		'TF_AddInputList',
		'TF_AddControlInput',
		'TF_ColocateWith',
		'TF_SetAttrString',
		'TF_SetAttrStringList',
		'TF_SetAttrInt',
		'TF_SetAttrIntList',
		'TF_SetAttrFloat',
		'TF_SetAttrFloatList',
		'TF_SetAttrBool',
		'TF_SetAttrBoolList',
		'TF_SetAttrType',
		'TF_SetAttrTypeList',
		'TF_SetAttrFuncName',
		'TF_SetAttrShape',
		'TF_SetAttrShapeList',
		'TF_SetAttrTensorShapeProto',
		'TF_SetAttrTensorShapeProtoList',
		'TF_SetAttrTensor',
		'TF_SetAttrTensorList',
		'TF_SetAttrValueProto',
		'TF_FinishOperation',
		'TF_OperationName',
		'TF_OperationOpType',
		'TF_OperationDevice',
		'TF_OperationNumOutputs',
		'TF_OperationOutputType',
		'TF_OperationOutputListLength',
		'TF_OperationNumInputs',
		'TF_OperationInputType',
		'TF_OperationInputListLength',
		'TF_OperationOutputNumConsumers',
		'TF_OperationOutputConsumers',
		'TF_OperationNumControlInputs',
		'TF_OperationGetControlInputs',
		'TF_OperationNumControlOutputs',
		'TF_OperationGetControlOutputs',
		'TF_OperationGetAttrMetadata',
		'TF_OperationGetAttrString',
		'TF_OperationGetAttrStringList',
		'TF_OperationGetAttrInt',
		'TF_OperationGetAttrIntList',
		'TF_OperationGetAttrFloat',
		'TF_OperationGetAttrFloatList',
		'TF_OperationGetAttrBool',
		'TF_OperationGetAttrBoolList',
		'TF_OperationGetAttrType',
		'TF_OperationGetAttrTypeList',
		'TF_OperationGetAttrShape',
		'TF_OperationGetAttrShapeList',
		'TF_OperationGetAttrTensorShapeProto',
		'TF_OperationGetAttrTensorShapeProtoList',
		'TF_OperationGetAttrTensor',
		'TF_OperationGetAttrTensorList',
		'TF_OperationGetAttrValueProto',
		'TF_GraphOperationByName',
		'TF_GraphNextOperation',
		'TF_GraphToGraphDef',
		'TF_GraphGetOpDef',
		'TF_GraphVersions',
		'TF_NewImportGraphDefOptions',
		'TF_DeleteImportGraphDefOptions',
		'TF_ImportGraphDefOptionsSetPrefix',
		'TF_ImportGraphDefOptionsSetDefaultDevice',
		'TF_ImportGraphDefOptionsSetUniquifyNames',
		'TF_ImportGraphDefOptionsSetUniquifyPrefix',
		'TF_ImportGraphDefOptionsAddInputMapping',
		'TF_ImportGraphDefOptionsRemapControlDependency',
		'TF_ImportGraphDefOptionsAddControlDependency',
		'TF_ImportGraphDefOptionsAddReturnOutput',
		'TF_ImportGraphDefOptionsNumReturnOutputs',
		'TF_ImportGraphDefOptionsAddReturnOperation',
		'TF_ImportGraphDefOptionsNumReturnOperations',
		'TF_ImportGraphDefResultsReturnOutputs',
		'TF_ImportGraphDefResultsReturnOperations',
		'TF_ImportGraphDefResultsMissingUnusedInputMappings',
		'TF_DeleteImportGraphDefResults',
		'TF_GraphImportGraphDefWithResults',
		'TF_GraphImportGraphDefWithReturnOutputs',
		'TF_GraphImportGraphDef',
		'TF_GraphCopyFunction',
		'TF_GraphNumFunctions',
		'TF_GraphGetFunctions',
		'TF_OperationToNodeDef',
		'TF_NewWhile',
		'TF_FinishWhile',
		'TF_AbortWhile',
		'TF_AddGradients',
		'TF_AddGradientsWithPrefix',
		'TF_GraphToFunction',
		'TF_GraphToFunctionWithControlOutputs',
		'TF_FunctionName',
		'TF_FunctionToFunctionDef',
		'TF_FunctionImportFunctionDef',
		'TF_FunctionSetAttrValueProto',
		'TF_FunctionGetAttrValueProto',
		'TF_DeleteFunction',
		'TF_TryEvaluateConstant',
		'TF_NewSession',
		'TF_LoadSessionFromSavedModel',
		'TF_CloseSession',
		'TF_DeleteSession',
		'TF_SessionRun',
		'TF_SessionPRunSetup',
		'TF_SessionPRun',
		'TF_DeletePRunHandle',
		'TF_NewDeprecatedSession',
		'TF_CloseDeprecatedSession',
		'TF_DeleteDeprecatedSession',
		'TF_Reset',
		'TF_ExtendGraph',
		'TF_Run',
		'TF_PRunSetup',
		'TF_PRun',
		'TF_SessionListDevices',
		'TF_DeprecatedSessionListDevices',
		'TF_DeleteDeviceList',
		'TF_DeviceListCount',
		'TF_DeviceListName',
		'TF_DeviceListType',
		'TF_DeviceListMemoryBytes',
		'TF_DeviceListIncarnation',
		'TF_GetOpList',
		'TF_LoadLibrary',
		'TF_DeleteLibraryHandle',
		'TF_GetAllOpList',
		'TF_NewApiDefMap',
		'TF_DeleteApiDefMap',
		'TF_ApiDefMapPut',
		'TF_ApiDefMapGet',
		'TF_GetAllRegisteredKernels',
		'TF_GetRegisteredKernelsForOp',
		'TF_NewServer',
		'TF_ServerStart',
		'TF_ServerStop',
		'TF_ServerJoin',
		'TF_ServerTarget',
		'TF_DeleteServer'
	],
	#type : 'variable',
	#category : 'TensorFlowApp'
}

{
	#category : 'Initializing'
}
TensorFlowFunctions class >> initialize [
	TF_Version := PlatformFunction fromArray: #('C' 'TF_Version' nil 'TENSORFLOW_LIB' #() #pointer ).
	TF_DataTypeSize := PlatformFunction fromArray: #('C' 'TF_DataTypeSize' nil 'TENSORFLOW_LIB' #(#uint32 ) #pointer ).
	TF_NewStatus := PlatformFunction fromArray: #('C' 'TF_NewStatus' nil 'TENSORFLOW_LIB' #() #pointer ).
	TF_DeleteStatus := PlatformFunction fromArray: #('C' 'TF_DeleteStatus' nil 'TENSORFLOW_LIB' #(#pointer ) #void ).
	TF_GetBuffer := PlatformFunction fromArray: #('C' 'TF_GetBuffer' nil 'TENSORFLOW_LIB' #(#pointer ) #struct ).
	TF_SetStatus := PlatformFunction fromArray: #('C' 'TF_SetStatus' nil 'TENSORFLOW_LIB' #(#pointer #uint32 #pointer ) #void ).
	TF_GetCode := PlatformFunction fromArray: #('C' 'TF_GetCode' nil 'TENSORFLOW_LIB' #(#pointer ) #uint32 ).
	TF_Message := PlatformFunction fromArray: #('C' 'TF_Message' nil 'TENSORFLOW_LIB' #(#pointer ) #pointer ).
	TF_NewBufferFromString := PlatformFunction fromArray: #('C' 'TF_NewBufferFromString' nil 'TENSORFLOW_LIB' #(#pointer #pointer ) #pointer ).
	TF_NewBuffer := PlatformFunction fromArray: #('C' 'TF_NewBuffer' nil 'TENSORFLOW_LIB' #() #pointer ).
	TF_DeleteBuffer := PlatformFunction fromArray: #('C' 'TF_DeleteBuffer' nil 'TENSORFLOW_LIB' #(#pointer ) #void ).
	TF_NewTensor := PlatformFunction fromArray: #('C' 'TF_NewTensor' nil 'TENSORFLOW_LIB' #(#uint32 #pointer #int32 #pointer #pointer #pointer #pointer ) #pointer ).
	TF_AllocateTensor := PlatformFunction fromArray: #('C' 'TF_AllocateTensor' nil 'TENSORFLOW_LIB' #(#uint32 #pointer #int32 #pointer ) #pointer ).
	TF_TensorMaybeMove := PlatformFunction fromArray: #('C' 'TF_TensorMaybeMove' nil 'TENSORFLOW_LIB' #(#pointer ) #pointer ).
	TF_DeleteTensor := PlatformFunction fromArray: #('C' 'TF_DeleteTensor' nil 'TENSORFLOW_LIB' #(#pointer ) #void ).
	TF_TensorType := PlatformFunction fromArray: #('C' 'TF_TensorType' nil 'TENSORFLOW_LIB' #(#pointer ) #uint32 ).
	TF_NumDims := PlatformFunction fromArray: #('C' 'TF_NumDims' nil 'TENSORFLOW_LIB' #(#pointer ) #int32 ).
	TF_Dim := PlatformFunction fromArray: #('C' 'TF_Dim' nil 'TENSORFLOW_LIB' #(#pointer #int32 ) #int32 ).
	TF_TensorByteSize := PlatformFunction fromArray: #('C' 'TF_TensorByteSize' nil 'TENSORFLOW_LIB' #(#pointer ) #pointer ).
	TF_TensorData := PlatformFunction fromArray: #('C' 'TF_TensorData' nil 'TENSORFLOW_LIB' #(#pointer ) #pointer ).
	TF_StringEncode := PlatformFunction fromArray: #('C' 'TF_StringEncode' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer #pointer ) #pointer ).
	TF_StringDecode := PlatformFunction fromArray: #('C' 'TF_StringDecode' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer #pointer ) #pointer ).
	TF_StringEncodedSize := PlatformFunction fromArray: #('C' 'TF_StringEncodedSize' nil 'TENSORFLOW_LIB' #(#pointer ) #pointer ).
	TF_NewSessionOptions := PlatformFunction fromArray: #('C' 'TF_NewSessionOptions' nil 'TENSORFLOW_LIB' #() #pointer ).
	TF_SetTarget := PlatformFunction fromArray: #('C' 'TF_SetTarget' nil 'TENSORFLOW_LIB' #(#pointer #pointer ) #void ).
	TF_SetConfig := PlatformFunction fromArray: #('C' 'TF_SetConfig' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer ) #void ).
	TF_DeleteSessionOptions := PlatformFunction fromArray: #('C' 'TF_DeleteSessionOptions' nil 'TENSORFLOW_LIB' #(#pointer ) #void ).
	TF_NewGraph := PlatformFunction fromArray: #('C' 'TF_NewGraph' nil 'TENSORFLOW_LIB' #() #pointer ).
	TF_DeleteGraph := PlatformFunction fromArray: #('C' 'TF_DeleteGraph' nil 'TENSORFLOW_LIB' #(#pointer ) #void ).
	TF_GraphSetTensorShape := PlatformFunction fromArray: #('C' 'TF_GraphSetTensorShape' nil 'TENSORFLOW_LIB' #(#pointer #bytes #pointer #int32 #pointer ) #void ).
	TF_GraphGetTensorNumDims := PlatformFunction fromArray: #('C' 'TF_GraphGetTensorNumDims' nil 'TENSORFLOW_LIB' #(#pointer #bytes #pointer ) #int32 ).
	TF_GraphGetTensorShape := PlatformFunction fromArray: #('C' 'TF_GraphGetTensorShape' nil 'TENSORFLOW_LIB' #(#pointer #bytes #pointer #int32 #pointer ) #void ).
	TF_NewOperation := PlatformFunction fromArray: #('C' 'TF_NewOperation' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer ) #pointer ).
	TF_SetDevice := PlatformFunction fromArray: #('C' 'TF_SetDevice' nil 'TENSORFLOW_LIB' #(#pointer #pointer ) #void ).
	TF_AddInput := PlatformFunction fromArray: #('C' 'TF_AddInput' nil 'TENSORFLOW_LIB' #(#pointer #bytes ) #void ).
	TF_AddInputList := PlatformFunction fromArray: #('C' 'TF_AddInputList' nil 'TENSORFLOW_LIB' #(#pointer #pointer #int32 ) #void ).
	TF_AddControlInput := PlatformFunction fromArray: #('C' 'TF_AddControlInput' nil 'TENSORFLOW_LIB' #(#pointer #pointer ) #void ).
	TF_ColocateWith := PlatformFunction fromArray: #('C' 'TF_ColocateWith' nil 'TENSORFLOW_LIB' #(#pointer #pointer ) #void ).
	TF_SetAttrString := PlatformFunction fromArray: #('C' 'TF_SetAttrString' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer ) #void ).
	TF_SetAttrStringList := PlatformFunction fromArray: #('C' 'TF_SetAttrStringList' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer #int32 ) #void ).
	TF_SetAttrInt := PlatformFunction fromArray: #('C' 'TF_SetAttrInt' nil 'TENSORFLOW_LIB' #(#pointer #pointer #int32 ) #void ).
	TF_SetAttrIntList := PlatformFunction fromArray: #('C' 'TF_SetAttrIntList' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #int32 ) #void ).
	TF_SetAttrFloat := PlatformFunction fromArray: #('C' 'TF_SetAttrFloat' nil 'TENSORFLOW_LIB' #(#pointer #pointer #float ) #void ).
	TF_SetAttrFloatList := PlatformFunction fromArray: #('C' 'TF_SetAttrFloatList' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #int32 ) #void ).
	TF_SetAttrBool := PlatformFunction fromArray: #('C' 'TF_SetAttrBool' nil 'TENSORFLOW_LIB' #(#pointer #pointer #uint8 ) #void ).
	TF_SetAttrBoolList := PlatformFunction fromArray: #('C' 'TF_SetAttrBoolList' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #int32 ) #void ).
	TF_SetAttrType := PlatformFunction fromArray: #('C' 'TF_SetAttrType' nil 'TENSORFLOW_LIB' #(#pointer #pointer #uint32 ) #void ).
	TF_SetAttrTypeList := PlatformFunction fromArray: #('C' 'TF_SetAttrTypeList' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #int32 ) #void ).
	TF_SetAttrFuncName := PlatformFunction fromArray: #('C' 'TF_SetAttrFuncName' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer ) #void ).
	TF_SetAttrShape := PlatformFunction fromArray: #('C' 'TF_SetAttrShape' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #int32 ) #void ).
	TF_SetAttrShapeList := PlatformFunction fromArray: #('C' 'TF_SetAttrShapeList' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer #int32 ) #void ).
	TF_SetAttrTensorShapeProto := PlatformFunction fromArray: #('C' 'TF_SetAttrTensorShapeProto' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer #pointer ) #void ).
	TF_SetAttrTensorShapeProtoList := PlatformFunction fromArray: #('C' 'TF_SetAttrTensorShapeProtoList' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer #int32 #pointer ) #void ).
	TF_SetAttrTensor := PlatformFunction fromArray: #('C' 'TF_SetAttrTensor' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer ) #void ).
	TF_SetAttrTensorList := PlatformFunction fromArray: #('C' 'TF_SetAttrTensorList' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #int32 #pointer ) #void ).
	TF_SetAttrValueProto := PlatformFunction fromArray: #('C' 'TF_SetAttrValueProto' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer #pointer ) #void ).
	TF_FinishOperation := PlatformFunction fromArray: #('C' 'TF_FinishOperation' nil 'TENSORFLOW_LIB' #(#pointer #pointer ) #pointer ).
	TF_OperationName := PlatformFunction fromArray: #('C' 'TF_OperationName' nil 'TENSORFLOW_LIB' #(#pointer ) #pointer ).
	TF_OperationOpType := PlatformFunction fromArray: #('C' 'TF_OperationOpType' nil 'TENSORFLOW_LIB' #(#pointer ) #pointer ).
	TF_OperationDevice := PlatformFunction fromArray: #('C' 'TF_OperationDevice' nil 'TENSORFLOW_LIB' #(#pointer ) #pointer ).
	TF_OperationNumOutputs := PlatformFunction fromArray: #('C' 'TF_OperationNumOutputs' nil 'TENSORFLOW_LIB' #(#pointer ) #int32 ).
	TF_OperationOutputType := PlatformFunction fromArray: #('C' 'TF_OperationOutputType' nil 'TENSORFLOW_LIB' #(#bytes ) #uint32 ).
	TF_OperationOutputListLength := PlatformFunction fromArray: #('C' 'TF_OperationOutputListLength' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer ) #int32 ).
	TF_OperationNumInputs := PlatformFunction fromArray: #('C' 'TF_OperationNumInputs' nil 'TENSORFLOW_LIB' #(#pointer ) #int32 ).
	TF_OperationInputType := PlatformFunction fromArray: #('C' 'TF_OperationInputType' nil 'TENSORFLOW_LIB' #(#bytes ) #uint32 ).
	TF_OperationInputListLength := PlatformFunction fromArray: #('C' 'TF_OperationInputListLength' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer ) #int32 ).
	TF_OperationOutputNumConsumers := PlatformFunction fromArray: #('C' 'TF_OperationOutputNumConsumers' nil 'TENSORFLOW_LIB' #(#bytes ) #int32 ).
	TF_OperationOutputConsumers := PlatformFunction fromArray: #('C' 'TF_OperationOutputConsumers' nil 'TENSORFLOW_LIB' #(#bytes #pointer #int32 ) #int32 ).
	TF_OperationNumControlInputs := PlatformFunction fromArray: #('C' 'TF_OperationNumControlInputs' nil 'TENSORFLOW_LIB' #(#pointer ) #int32 ).
	TF_OperationGetControlInputs := PlatformFunction fromArray: #('C' 'TF_OperationGetControlInputs' nil 'TENSORFLOW_LIB' #(#pointer #pointer #int32 ) #int32 ).
	TF_OperationNumControlOutputs := PlatformFunction fromArray: #('C' 'TF_OperationNumControlOutputs' nil 'TENSORFLOW_LIB' #(#pointer ) #int32 ).
	TF_OperationGetControlOutputs := PlatformFunction fromArray: #('C' 'TF_OperationGetControlOutputs' nil 'TENSORFLOW_LIB' #(#pointer #pointer #int32 ) #int32 ).
	TF_OperationGetAttrMetadata := PlatformFunction fromArray: #('C' 'TF_OperationGetAttrMetadata' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer ) #struct ).
	TF_OperationGetAttrString := PlatformFunction fromArray: #('C' 'TF_OperationGetAttrString' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer #pointer ) #void ).
	TF_OperationGetAttrStringList := PlatformFunction fromArray: #('C' 'TF_OperationGetAttrStringList' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer #int32 #pointer #pointer #pointer ) #void ).
	TF_OperationGetAttrInt := PlatformFunction fromArray: #('C' 'TF_OperationGetAttrInt' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer ) #void ).
	TF_OperationGetAttrIntList := PlatformFunction fromArray: #('C' 'TF_OperationGetAttrIntList' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #int32 #pointer ) #void ).
	TF_OperationGetAttrFloat := PlatformFunction fromArray: #('C' 'TF_OperationGetAttrFloat' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer ) #void ).
	TF_OperationGetAttrFloatList := PlatformFunction fromArray: #('C' 'TF_OperationGetAttrFloatList' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #int32 #pointer ) #void ).
	TF_OperationGetAttrBool := PlatformFunction fromArray: #('C' 'TF_OperationGetAttrBool' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer ) #void ).
	TF_OperationGetAttrBoolList := PlatformFunction fromArray: #('C' 'TF_OperationGetAttrBoolList' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #int32 #pointer ) #void ).
	TF_OperationGetAttrType := PlatformFunction fromArray: #('C' 'TF_OperationGetAttrType' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer ) #void ).
	TF_OperationGetAttrTypeList := PlatformFunction fromArray: #('C' 'TF_OperationGetAttrTypeList' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #int32 #pointer ) #void ).
	TF_OperationGetAttrShape := PlatformFunction fromArray: #('C' 'TF_OperationGetAttrShape' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #int32 #pointer ) #void ).
	TF_OperationGetAttrShapeList := PlatformFunction fromArray: #('C' 'TF_OperationGetAttrShapeList' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer #int32 #pointer #int32 #pointer ) #void ).
	TF_OperationGetAttrTensorShapeProto := PlatformFunction fromArray: #('C' 'TF_OperationGetAttrTensorShapeProto' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer ) #void ).
	TF_OperationGetAttrTensorShapeProtoList := PlatformFunction fromArray: #('C' 'TF_OperationGetAttrTensorShapeProtoList' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #int32 #pointer ) #void ).
	TF_OperationGetAttrTensor := PlatformFunction fromArray: #('C' 'TF_OperationGetAttrTensor' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer ) #void ).
	TF_OperationGetAttrTensorList := PlatformFunction fromArray: #('C' 'TF_OperationGetAttrTensorList' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #int32 #pointer ) #void ).
	TF_OperationGetAttrValueProto := PlatformFunction fromArray: #('C' 'TF_OperationGetAttrValueProto' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer ) #void ).
	TF_GraphOperationByName := PlatformFunction fromArray: #('C' 'TF_GraphOperationByName' nil 'TENSORFLOW_LIB' #(#pointer #pointer ) #pointer ).
	TF_GraphNextOperation := PlatformFunction fromArray: #('C' 'TF_GraphNextOperation' nil 'TENSORFLOW_LIB' #(#pointer #pointer ) #pointer ).
	TF_GraphToGraphDef := PlatformFunction fromArray: #('C' 'TF_GraphToGraphDef' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer ) #void ).
	TF_GraphGetOpDef := PlatformFunction fromArray: #('C' 'TF_GraphGetOpDef' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer ) #void ).
	TF_GraphVersions := PlatformFunction fromArray: #('C' 'TF_GraphVersions' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer ) #void ).
	TF_NewImportGraphDefOptions := PlatformFunction fromArray: #('C' 'TF_NewImportGraphDefOptions' nil 'TENSORFLOW_LIB' #() #pointer ).
	TF_DeleteImportGraphDefOptions := PlatformFunction fromArray: #('C' 'TF_DeleteImportGraphDefOptions' nil 'TENSORFLOW_LIB' #(#pointer ) #void ).
	TF_ImportGraphDefOptionsSetPrefix := PlatformFunction fromArray: #('C' 'TF_ImportGraphDefOptionsSetPrefix' nil 'TENSORFLOW_LIB' #(#pointer #pointer ) #void ).
	TF_ImportGraphDefOptionsSetDefaultDevice := PlatformFunction fromArray: #('C' 'TF_ImportGraphDefOptionsSetDefaultDevice' nil 'TENSORFLOW_LIB' #(#pointer #pointer ) #void ).
	TF_ImportGraphDefOptionsSetUniquifyNames := PlatformFunction fromArray: #('C' 'TF_ImportGraphDefOptionsSetUniquifyNames' nil 'TENSORFLOW_LIB' #(#pointer #uint8 ) #void ).
	TF_ImportGraphDefOptionsSetUniquifyPrefix := PlatformFunction fromArray: #('C' 'TF_ImportGraphDefOptionsSetUniquifyPrefix' nil 'TENSORFLOW_LIB' #(#pointer #uint8 ) #void ).
	TF_ImportGraphDefOptionsAddInputMapping := PlatformFunction fromArray: #('C' 'TF_ImportGraphDefOptionsAddInputMapping' nil 'TENSORFLOW_LIB' #(#pointer #pointer #int32 #bytes ) #void ).
	TF_ImportGraphDefOptionsRemapControlDependency := PlatformFunction fromArray: #('C' 'TF_ImportGraphDefOptionsRemapControlDependency' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer ) #void ).
	TF_ImportGraphDefOptionsAddControlDependency := PlatformFunction fromArray: #('C' 'TF_ImportGraphDefOptionsAddControlDependency' nil 'TENSORFLOW_LIB' #(#pointer #pointer ) #void ).
	TF_ImportGraphDefOptionsAddReturnOutput := PlatformFunction fromArray: #('C' 'TF_ImportGraphDefOptionsAddReturnOutput' nil 'TENSORFLOW_LIB' #(#pointer #pointer #int32 ) #void ).
	TF_ImportGraphDefOptionsNumReturnOutputs := PlatformFunction fromArray: #('C' 'TF_ImportGraphDefOptionsNumReturnOutputs' nil 'TENSORFLOW_LIB' #(#pointer ) #int32 ).
	TF_ImportGraphDefOptionsAddReturnOperation := PlatformFunction fromArray: #('C' 'TF_ImportGraphDefOptionsAddReturnOperation' nil 'TENSORFLOW_LIB' #(#pointer #pointer ) #void ).
	TF_ImportGraphDefOptionsNumReturnOperations := PlatformFunction fromArray: #('C' 'TF_ImportGraphDefOptionsNumReturnOperations' nil 'TENSORFLOW_LIB' #(#pointer ) #int32 ).
	TF_ImportGraphDefResultsReturnOutputs := PlatformFunction fromArray: #('C' 'TF_ImportGraphDefResultsReturnOutputs' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer ) #void ).
	TF_ImportGraphDefResultsReturnOperations := PlatformFunction fromArray: #('C' 'TF_ImportGraphDefResultsReturnOperations' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer ) #void ).
	TF_ImportGraphDefResultsMissingUnusedInputMappings := PlatformFunction fromArray: #('C' 'TF_ImportGraphDefResultsMissingUnusedInputMappings' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer ) #void ).
	TF_DeleteImportGraphDefResults := PlatformFunction fromArray: #('C' 'TF_DeleteImportGraphDefResults' nil 'TENSORFLOW_LIB' #(#pointer ) #void ).
	TF_GraphImportGraphDefWithResults := PlatformFunction fromArray: #('C' 'TF_GraphImportGraphDefWithResults' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer ) #pointer ).
	TF_GraphImportGraphDefWithReturnOutputs := PlatformFunction fromArray: #('C' 'TF_GraphImportGraphDefWithReturnOutputs' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer #int32 #pointer ) #void ).
	TF_GraphImportGraphDef := PlatformFunction fromArray: #('C' 'TF_GraphImportGraphDef' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer ) #void ).
	TF_GraphCopyFunction := PlatformFunction fromArray: #('C' 'TF_GraphCopyFunction' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer ) #void ).
	TF_GraphNumFunctions := PlatformFunction fromArray: #('C' 'TF_GraphNumFunctions' nil 'TENSORFLOW_LIB' #(#pointer ) #int32 ).
	TF_GraphGetFunctions := PlatformFunction fromArray: #('C' 'TF_GraphGetFunctions' nil 'TENSORFLOW_LIB' #(#pointer #pointer #int32 #pointer ) #int32 ).
	TF_OperationToNodeDef := PlatformFunction fromArray: #('C' 'TF_OperationToNodeDef' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer ) #void ).
	TF_NewWhile := PlatformFunction fromArray: #('C' 'TF_NewWhile' nil 'TENSORFLOW_LIB' #(#pointer #pointer #int32 #pointer ) #struct ).
	TF_FinishWhile := PlatformFunction fromArray: #('C' 'TF_FinishWhile' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer ) #void ).
	TF_AbortWhile := PlatformFunction fromArray: #('C' 'TF_AbortWhile' nil 'TENSORFLOW_LIB' #(#pointer ) #void ).
	TF_AddGradients := PlatformFunction fromArray: #('C' 'TF_AddGradients' nil 'TENSORFLOW_LIB' #(#pointer #pointer #int32 #pointer #int32 #pointer #pointer #pointer ) #void ).
	TF_AddGradientsWithPrefix := PlatformFunction fromArray: #('C' 'TF_AddGradientsWithPrefix' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #int32 #pointer #int32 #pointer #pointer #pointer ) #void ).
	TF_GraphToFunction := PlatformFunction fromArray: #('C' 'TF_GraphToFunction' nil 'TENSORFLOW_LIB' #(#pointer #pointer #uint8 #int32 #pointer #int32 #pointer #int32 #pointer #pointer #pointer #pointer #pointer ) #pointer ).
	TF_GraphToFunctionWithControlOutputs := PlatformFunction fromArray: #('C' 'TF_GraphToFunctionWithControlOutputs' nil 'TENSORFLOW_LIB' #(#pointer #pointer #uint8 #int32 #pointer #int32 #pointer #int32 #pointer #pointer #int32 #pointer #pointer #pointer #pointer #pointer) #pointer ).
	TF_FunctionName := PlatformFunction fromArray: #('C' 'TF_FunctionName' nil 'TENSORFLOW_LIB' #(#pointer ) #pointer ).
	TF_FunctionToFunctionDef := PlatformFunction fromArray: #('C' 'TF_FunctionToFunctionDef' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer ) #void ).
	TF_FunctionImportFunctionDef := PlatformFunction fromArray: #('C' 'TF_FunctionImportFunctionDef' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer ) #pointer ).
	TF_FunctionSetAttrValueProto := PlatformFunction fromArray: #('C' 'TF_FunctionSetAttrValueProto' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer #pointer ) #void ).
	TF_FunctionGetAttrValueProto := PlatformFunction fromArray: #('C' 'TF_FunctionGetAttrValueProto' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer ) #void ).
	TF_DeleteFunction := PlatformFunction fromArray: #('C' 'TF_DeleteFunction' nil 'TENSORFLOW_LIB' #(#pointer ) #void ).
	TF_TryEvaluateConstant := PlatformFunction fromArray: #('C' 'TF_TryEvaluateConstant' nil 'TENSORFLOW_LIB' #(#pointer #bytes #pointer #pointer ) #uint8 ).
	TF_NewSession := PlatformFunction fromArray: #('C' 'TF_NewSession' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer ) #pointer ).
	TF_LoadSessionFromSavedModel := PlatformFunction fromArray: #('C' 'TF_LoadSessionFromSavedModel' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer #int32 #pointer #pointer #pointer ) #pointer ).
	TF_CloseSession := PlatformFunction fromArray: #('C' 'TF_CloseSession' nil 'TENSORFLOW_LIB' #(#pointer #pointer ) #void ).
	TF_DeleteSession := PlatformFunction fromArray: #('C' 'TF_DeleteSession' nil 'TENSORFLOW_LIB' #(#pointer #pointer ) #void ).
	TF_SessionRun := PlatformFunction fromArray: #('C' 'TF_SessionRun' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer #int32 #pointer #pointer #int32 #pointer #int32 #pointer #pointer ) #void ).
	TF_SessionPRunSetup := PlatformFunction fromArray: #('C' 'TF_SessionPRunSetup' nil 'TENSORFLOW_LIB' #(#pointer #pointer #int32 #pointer #int32 #pointer #int32 #pointer #pointer ) #void ).
	TF_SessionPRun := PlatformFunction fromArray: #('C' 'TF_SessionPRun' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer #int32 #pointer #pointer #int32 #pointer #int32 #pointer ) #void ).
	TF_DeletePRunHandle := PlatformFunction fromArray: #('C' 'TF_DeletePRunHandle' nil 'TENSORFLOW_LIB' #(#pointer ) #void ).
	TF_NewDeprecatedSession := PlatformFunction fromArray: #('C' 'TF_NewDeprecatedSession' nil 'TENSORFLOW_LIB' #(#pointer #pointer ) #pointer ).
	TF_CloseDeprecatedSession := PlatformFunction fromArray: #('C' 'TF_CloseDeprecatedSession' nil 'TENSORFLOW_LIB' #(#pointer #pointer ) #void ).
	TF_DeleteDeprecatedSession := PlatformFunction fromArray: #('C' 'TF_DeleteDeprecatedSession' nil 'TENSORFLOW_LIB' #(#pointer #pointer ) #void ).
	TF_Reset := PlatformFunction fromArray: #('C' 'TF_Reset' nil 'TENSORFLOW_LIB' #(#pointer #pointer #int32 #pointer ) #void ).
	TF_ExtendGraph := PlatformFunction fromArray: #('C' 'TF_ExtendGraph' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer ) #void ).
	TF_Run := PlatformFunction fromArray: #('C' 'TF_Run' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer #int32 #pointer #pointer #int32 #pointer #int32 #pointer #pointer ) #void ).
	TF_PRunSetup := PlatformFunction fromArray: #('C' 'TF_PRunSetup' nil 'TENSORFLOW_LIB' #(#pointer #pointer #int32 #pointer #int32 #pointer #int32 #pointer #pointer ) #void ).
	TF_PRun := PlatformFunction fromArray: #('C' 'TF_PRun' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer #int32 #pointer #pointer #int32 #pointer #int32 #pointer ) #void ).
	TF_SessionListDevices := PlatformFunction fromArray: #('C' 'TF_SessionListDevices' nil 'TENSORFLOW_LIB' #(#pointer #pointer ) #pointer ).
	TF_DeprecatedSessionListDevices := PlatformFunction fromArray: #('C' 'TF_DeprecatedSessionListDevices' nil 'TENSORFLOW_LIB' #(#pointer #pointer ) #pointer ).
	TF_DeleteDeviceList := PlatformFunction fromArray: #('C' 'TF_DeleteDeviceList' nil 'TENSORFLOW_LIB' #(#pointer ) #void ).
	TF_DeviceListCount := PlatformFunction fromArray: #('C' 'TF_DeviceListCount' nil 'TENSORFLOW_LIB' #(#pointer ) #int32 ).
	TF_DeviceListName := PlatformFunction fromArray: #('C' 'TF_DeviceListName' nil 'TENSORFLOW_LIB' #(#pointer #int32 #pointer ) #pointer ).
	TF_DeviceListType := PlatformFunction fromArray: #('C' 'TF_DeviceListType' nil 'TENSORFLOW_LIB' #(#pointer #int32 #pointer ) #pointer ).
	TF_DeviceListMemoryBytes := PlatformFunction fromArray: #('C' 'TF_DeviceListMemoryBytes' nil 'TENSORFLOW_LIB' #(#pointer #int32 #pointer ) #int32 ).
	TF_DeviceListIncarnation := PlatformFunction fromArray: #('C' 'TF_DeviceListIncarnation' nil 'TENSORFLOW_LIB' #(#pointer #int32 #pointer ) #uint64 ).
	TF_GetOpList := PlatformFunction fromArray: #('C' 'TF_GetOpList' nil 'TENSORFLOW_LIB' #(#pointer ) #struct ).
	TF_LoadLibrary := PlatformFunction fromArray: #('C' 'TF_LoadLibrary' nil 'TENSORFLOW_LIB' #(#pointer #pointer ) #pointer ).
	TF_DeleteLibraryHandle := PlatformFunction fromArray: #('C' 'TF_DeleteLibraryHandle' nil 'TENSORFLOW_LIB' #(#pointer ) #void ).
	TF_GetAllOpList := PlatformFunction fromArray: #('C' 'TF_GetAllOpList' nil 'TENSORFLOW_LIB' #() #pointer ).
	TF_NewApiDefMap := PlatformFunction fromArray: #('C' 'TF_NewApiDefMap' nil 'TENSORFLOW_LIB' #(#pointer #pointer ) #pointer ).
	TF_DeleteApiDefMap := PlatformFunction fromArray: #('C' 'TF_DeleteApiDefMap' nil 'TENSORFLOW_LIB' #(#pointer ) #void ).
	TF_ApiDefMapPut := PlatformFunction fromArray: #('C' 'TF_ApiDefMapPut' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer ) #void ).
	TF_ApiDefMapGet := PlatformFunction fromArray: #('C' 'TF_ApiDefMapGet' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer #pointer ) #pointer ).
	TF_GetAllRegisteredKernels := PlatformFunction fromArray: #('C' 'TF_GetAllRegisteredKernels' nil 'TENSORFLOW_LIB' #(#pointer ) #pointer ).
	TF_GetRegisteredKernelsForOp := PlatformFunction fromArray: #('C' 'TF_GetRegisteredKernelsForOp' nil 'TENSORFLOW_LIB' #(#pointer #pointer ) #pointer ).
	TF_NewServer := PlatformFunction fromArray: #('C' 'TF_NewServer' nil 'TENSORFLOW_LIB' #(#pointer #pointer #pointer ) #pointer ).
	TF_ServerStart := PlatformFunction fromArray: #('C' 'TF_ServerStart' nil 'TENSORFLOW_LIB' #(#pointer #pointer ) #void ).
	TF_ServerStop := PlatformFunction fromArray: #('C' 'TF_ServerStop' nil 'TENSORFLOW_LIB' #(#pointer #pointer ) #void ).
	TF_ServerJoin := PlatformFunction fromArray: #('C' 'TF_ServerJoin' nil 'TENSORFLOW_LIB' #(#pointer #pointer ) #void ).
	TF_ServerTarget := PlatformFunction fromArray: #('C' 'TF_ServerTarget' nil 'TENSORFLOW_LIB' #(#pointer ) #pointer ).
	TF_DeleteServer := PlatformFunction fromArray: #('C' 'TF_DeleteServer' nil 'TENSORFLOW_LIB' #(#pointer ) #void ).

]
