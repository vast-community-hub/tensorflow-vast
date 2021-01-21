Extension {
	#name : 'TensorFlowCAPI'
}

{ #category : '*TensorFlowFunctionExtensions',
 #vaCategories : ['operation description'] }
TensorFlowCAPI >> description: aTFOperationDescription set: aString toFunction: aFunction [

	^self dispatcher
		callTF_SetAttrFuncNameWith: aTFOperationDescription
		with: aString
		with: aFunction
		with: nil
]

{ #category : '*TensorFlowFunctionExtensions',
 #vaCategories : ['operation'] }
TensorFlowCAPI >> newFunctionNamed: aFunctionName appended: aHashToAppend with: aTFGraph containingAll: anOperationsArray consideringInputs: anInputArray consideringOutputs: anOutputArray consideringNames: anOutputNames withOptions: anOptionsArray description: aDescription status: aStatus [

	^self dispatcher
		callTF_GraphToFunctionWith: aTFGraph
		with: aFunctionName
		with: aHashToAppend
		with: anOperationsArray size
		with: (TFOperationPtrArray externalFromArray: anOperationsArray)
		with: anInputArray size
		with: (TFInputArray externalFromArray: anInputArray)
		with: anOutputArray size
		with: (TFOutputArray externalFromArray: anOutputArray)
		with: anOutputNames
		with: anOptionsArray
		with: aDescription
		with: aStatus
]
