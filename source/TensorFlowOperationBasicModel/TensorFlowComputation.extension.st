Extension {
	#name : 'TensorFlowComputation'
}

{ #category : 'Creating - Constants' }
TensorFlowComputation >> constantWith: aNumberOrArray [

	^ConstantTensor on: self with: aNumberOrArray asTensor
]

{ #category : 'Creating - Variables' }
TensorFlowComputation >> createVariableNamed: aName of: aType shaped: aShape initializedWith: aVariableInitializer [

	
	| variable | 
	variable := 
		self
			newOperationOf: 'Variable'
			namePrefixed: aName
			withAll: #()
			describedBy: [:description |
				description
					atDataTypePut: aType;
					atShapePut: aShape].
	" If I dont't force the shape with the following collaboration, 
	TF_GraphGetTensorNumDims of a 'Variable' operation returns -1, meaning unknown, although 
	the rank is well knwown. See https://github.com/tensorflow/tensorflow/issues/5106 "
	graph shapeOf: variable firstOutput set: aShape.
	^ variable 
]

{ #category : 'Creating - Constants' }
TensorFlowComputation >> floatConstantWith: aNumberOrArray [

	^self constantWith: aNumberOrArray asFloatTensor
]

{ #category : 'Creating - Constants' }
TensorFlowComputation >> floatConstantWith: aNumberOrMatrix named: aName [

	^ConstantTensor on: self named: aName with: aNumberOrMatrix asFloatTensor
]

{ #category : 'Creating - Inputs' }
TensorFlowComputation >> floatInputNamed: anInputName [

	^InputTensor on: self named: anInputName of: FloatDataType new
]

{ #category : 'Creating - Constants' }
TensorFlowComputation >> integerConstantWith: aNumberOrArray [

	^self constantWith: aNumberOrArray asInt32Tensor
]

{ #category : 'Creating - Inputs' }
TensorFlowComputation >> integerInputNamed: anInputName [

	^InputTensor on: self named: anInputName of: Int32DataType new
]

{ #category : 'Creating - Variables' }
TensorFlowComputation >> variableNamed: aVariableName with: aTensor [

	^VariableTensor on: self named: aVariableName with: aTensor
]
