Extension {
	#name : 'TensorFlowComputation'
}

{ #category : '*TFOperationModel',
 #vaCategories : ['Creating - Constants'] }
TensorFlowComputation >> defineFloatTensorWith: aNumberOrArray [

	^TFConstant on: self with: aNumberOrArray asFloatTensor
]

{ #category : '*TFOperationModel',
 #vaCategories : ['Creating - Constants'] }
TensorFlowComputation >> defineFloatTensorWith: aNumberOrMatrix named: aName [

	^TFConstant on: self named: aName with: aNumberOrMatrix asFloatTensor
]

{ #category : '*TFOperationModel',
 #vaCategories : ['Creating - Constants'] }
TensorFlowComputation >> defineIntegerTensorWith: aNumberOrArray [

	^TFConstant on: self with: aNumberOrArray asInt32Tensor
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
 #vaCategories : ['Creating - Variables'] }
TensorFlowComputation >> variableNamed: aVariableName with: aTensor [

	^TFVariable on: self named: aVariableName with: aTensor
]

{ #category : '*TFOperationModel',
 #vaCategories : ['Creating - Constants'] }
TensorFlowComputation >> zerosShapedFor: aVariable [

	^TFConstant on: self shaped: aVariable outputShape filledWith: 0.0 asTensor
]
