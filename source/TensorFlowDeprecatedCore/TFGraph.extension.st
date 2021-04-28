Extension {
	#name : 'TFGraph'
}

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['operations'] }
TFGraph >> add: nameString described: aBlock [
	^ self newOperation: 'Add' named: nameString described: aBlock
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['operations'] }
TFGraph >> asString: nameString described: aBlock [
	^ self newOperation: 'AsString' named: nameString described: aBlock
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['operations'] }
TFGraph >> concat: nameString described: aBlock [
	^ self newOperation: 'Concat' named: nameString described: aBlock
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['root operations'] }
TFGraph >> const: aTFTensor [
	| name |
	name := self nameFor: 'constant'.
	^ self const: name value: aTFTensor
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['root operations'] }
TFGraph >> const: nameString value: aTFTensor [
	^ self
		newOperation: 'Const'
		named: nameString
		described: [ :description | 
			description at: 'dtype' putType: aTFTensor type.
			description at: 'value' putTensor: aTFTensor ]
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['root operations'] }
TFGraph >> constShaped: aShape filledWith: aTensor [

	| shape |

	shape := self const: aShape asInt32Tensor.
	^shape binaryOp: 'Fill' with: aTensor
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['initialize-release'] }
TFGraph >> fromBlock: aBlockClosure [
	| types |
	types := Array new: aBlockClosure argumentCount.
	types atAllPut: TFTensor typeFloat.
	^ self fromBlock: aBlockClosure inputTypes: types
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['initialize-release'] }
TFGraph >> fromBlock: aBlockClosure inputTypes: anArray [
	| inputs index |
	index := 0.
	inputs := (1 to: aBlockClosure argumentCount)
		collect: [ :each | 
			index := index + 1.
			self inputType: (anArray at: index) ].
	^ aBlockClosure valueWithArguments: inputs
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['initialize-release'] }
TFGraph >> fromBlock: aBlockClosure inputTypes: anArray named: nameString [

	| answer |

	self
		inScopeNamed: nameString
		do: [answer := self fromBlock: aBlockClosure inputTypes: anArray].
	^answer
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['initialize-release'] }
TFGraph >> fromBlock: aBlockClosure named: nameString [
	| types |
	types := Array new: aBlockClosure argumentCount.
	types atAllPut: TFTensor typeFloat.
	^ self fromBlock: aBlockClosure inputTypes: types named: nameString
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['root operations'] }
TFGraph >> inputType: typeInteger [
	^ self
		newOperation: 'Placeholder'
		named: (self nameFor: 'input')
		described: [ :description | description at: 'dtype' putType: typeInteger ]
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['operations'] }
TFGraph >> mul: nameString described: aBlock [
	^ self newOperation: 'Mul' named: nameString described: aBlock
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['root operations'] }
TFGraph >> onesShaped: aShape [

	^self constShaped: aShape filledWith: 1.0 asTensor
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['root operations'] }
TFGraph >> placeholder: nameString type: typeInteger [
	^ self
		newOperation: 'Placeholder'
		named: nameString
		described: [ :description | description at: 'dtype' putType: typeInteger ]
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['running'] }
TFGraph >> runInputs: inArrayOfTFOutputs values: inArrayOfTFTensor outputs: outArrayOfTFOutputs [
	| session |
	session := TFSession on: self.
	self initializeOn: session.
	^ session
		runInputs: inArrayOfTFOutputs
		values: inArrayOfTFTensor
		outputs: outArrayOfTFOutputs
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['outputs'] }
TFGraph >> shapeOf: aTFOutputOrInput set: shape [

	self library graph: self setShapeOf: aTFOutputOrInput to: shape
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['root operations'] }
TFGraph >> truncatedNormalRandomShaped: shapeArray [
	| shape |
	shape := self const: shapeArray asInt32Tensor.
	^ shape
		unaryOp: 'TruncatedNormal'
		described: [ :description | description at: 'dtype' putType: TFTensor typeFloat ]
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['root operations'] }
TFGraph >> truncatedNormalRandomShaped: shapeArray stddev: aNumber [
	| random |
	random := self truncatedNormalRandomShaped: shapeArray.
	^ random @* (self const: aNumber asTensor)
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['root operations'] }
TFGraph >> variable: nameString forTensor: aTFTensor [
	^ self
		variable: nameString
		type: aTFTensor type
		shape: aTFTensor shape
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['root operations'] }
TFGraph >> variable: nameString initialValue: aTFTensor [
	| const var |
	var := self variable: nameString forTensor: aTFTensor.
	const := self const: nameString , '_initialValue' value: aTFTensor.
	var assign: const.
	^ var
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['root operations'] }
TFGraph >> variable: nameString initialValueFrom: aTFOperation [
	| output var shape |
	output := aTFOperation output: 0.
	shape := self shapeOf: output.
	var := self variable: nameString type: output type shape: shape.
	var assign: aTFOperation.
	^ var
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['root operations'] }
TFGraph >> variable: nameString type: typeInteger shape: anArray [
	^ self
		newOperation: 'Variable'
		named: nameString
		described: [ :description | 
			description
				at: 'dtype' putType: typeInteger;
				at: 'shape' putShape: anArray asTensorShape ]
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['root operations'] }
TFGraph >> zerosShaped: aShape [

	^self constShaped: aShape filledWith: 0.0 asTensor
]
