Extension {
	#name : 'TFGraph'
}

{ #category : '*TensorFlowFunctionExtensions',
 #vaCategories : ['accessing'] }
TFGraph >> allTheFunctions [

	^self library allTheFunctionsIn: self
]

{ #category : '*TensorFlowFunctionExtensions',
 #vaCategories : ['operations'] }
TFGraph >> storeAsFunctionNamed: aString outputing: anOutputsArray [

	^self library
		newFunctionNamed: aString
		appended: 0
		with: self
		containingAll: self allOperations
		consideringInputs: self allInputs
		consideringOutputs: anOutputsArray
		consideringNames: nil
		withOptions: TFStructure externalNew
		description: 'my_description'
]
