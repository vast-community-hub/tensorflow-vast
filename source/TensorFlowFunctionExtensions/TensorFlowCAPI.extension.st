Extension {
	#name : 'TensorFlowCAPI'
}

{ #category : '*TensorFlowFunctionExtensions',
 #vaCategories : ['functions'] }
TensorFlowCAPI >> allTheFunctionsIn: aTFGraph [

	
	^ library allTheFunctionsIn: aTFGraph 
]

{ #category : '*TensorFlowFunctionExtensions',
 #vaCategories : ['functions'] }
TensorFlowCAPI >> newFunctionNamed: aFunctionName appended: aHashToAppend with: aTFGraph containingAll: anOperationsArray consideringInputs: anInputArray consideringOutputs: anOutputArray consideringNames: anOutputNames withOptions: anOptionsArray description: aDescription [

	^library checkStatusAfter: [:status |
		library
			newFunctionNamed: aFunctionName
			appended: aHashToAppend
			with: aTFGraph
			containingAll: anOperationsArray
			consideringInputs: anInputArray
			consideringOutputs: anOutputArray
			consideringNames: anOutputNames
			withOptions: anOptionsArray
			description: aDescription
			status: status]
]
