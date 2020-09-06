Extension {
	#name : 'TensorFlowComputation'
}

{ #category : '*TFOperationModel',
 #vaCategories : ['Creating - Constants'] }
TensorFlowComputation >> constantWith: aNumberOrArray [

	^ConstantNode on: self with: aNumberOrArray asTensor
]

{ #category : '*TFOperationModel',
 #vaCategories : ['Creating - Constants'] }
TensorFlowComputation >> floatConstantWith: aNumberOrArray [

	^self constantWith: aNumberOrArray asFloatTensor
]

{ #category : '*TFOperationModel',
 #vaCategories : ['Creating - Constants'] }
TensorFlowComputation >> floatConstantWith: aNumberOrMatrix named: aName [

	^ConstantNode on: self named: aName with: aNumberOrMatrix asFloatTensor
]

{ #category : '*TFOperationModel',
 #vaCategories : ['Creating - Inputs'] }
TensorFlowComputation >> floatInputNamed: anInputName [

	^InputNode on: self named: anInputName of: TFTensor typeFloat
]

{ #category : '*TFOperationModel',
 #vaCategories : ['Creating - Constants'] }
TensorFlowComputation >> integerConstantWith: aNumberOrArray [

	^self constantWith: aNumberOrArray asInt32Tensor
]

{ #category : '*TFOperationModel',
 #vaCategories : ['Creating - Inputs'] }
TensorFlowComputation >> integerInputNamed: anInputName [

	^InputNode on: self named: anInputName of: TFTensor typeInt32
]

{ #category : '*TFOperationModel',
 #vaCategories : ['Creating - Variables'] }
TensorFlowComputation >> variableNamed: aVariableName with: aTensor [

	^VariableNode on: self named: aVariableName with: aTensor
]
