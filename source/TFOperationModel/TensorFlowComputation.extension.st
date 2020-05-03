Extension {
	#name : 'TensorFlowComputation'
}

{ #category : '*TFOperationModel',
 #vaCategories : ['Creating - Constants'] }
TensorFlowComputation >> constantWith: aNumberOrArray [

	^TFConstant on: self with: aNumberOrArray asTensor
]

{ #category : '*TFOperationModel',
 #vaCategories : ['Creating - Constants'] }
TensorFlowComputation >> floatConstantWith: aNumberOrArray [

	^self constantWith: aNumberOrArray asFloatTensor
]

{ #category : '*TFOperationModel',
 #vaCategories : ['Creating - Constants'] }
TensorFlowComputation >> floatConstantWith: aNumberOrMatrix named: aName [

	^TFConstant on: self named: aName with: aNumberOrMatrix asFloatTensor
]

{ #category : '*TFOperationModel',
 #vaCategories : ['Creating - Variables'] }
TensorFlowComputation >> floatVariableNamed: aVariableName shaped: aShape initializedWith: aVariableInitializer [

	^TFVariable
		on: self
		named: aVariableName
		forFloatsShaped: aShape
		initializedWith: aVariableInitializer
]

{ #category : '*TFOperationModel',
 #vaCategories : ['Creating - Constants'] }
TensorFlowComputation >> integerConstantWith: aNumberOrArray [

	^self constantWith: aNumberOrArray asInt32Tensor
]

{ #category : '*TFOperationModel',
 #vaCategories : ['Creating - Variables'] }
TensorFlowComputation >> variableNamed: aVariableName with: aTensor [

	^TFVariable on: self named: aVariableName with: aTensor
]
