Extension {
	#name : 'TensorFlowCAPI'
}

{ #category : 'functions' }
TensorFlowCAPI >> allTheFunctionsIn: aTFGraph [

	
	^ platformLibrary allTheFunctionsIn: aTFGraph 
]

{ #category : 'functions' }
TensorFlowCAPI >> newFunctionNamed: aFunctionName appended: aHashToAppend with: aTFGraph containingAll: anOperationsArray consideringInputs: anInputArray consideringOutputs: anOutputArray consideringNames: anOutputNames withOptions: anOptionsArray description: aDescription [

	^platformLibrary checkStatusAfter: [:status |
		platformLibrary
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
