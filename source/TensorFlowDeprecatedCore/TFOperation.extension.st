Extension {
	#name : 'TFOperation'
}

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops binary'] }
TFOperation >> * aTFOperation [
	^ self binaryOp: 'MatMul' with: aTFOperation
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops binary'] }
TFOperation >> *\ aTFOperation [
	^ self
		binaryOp: 'MatMul'
		with: aTFOperation
		described: [ :description | description at: 'transpose_b' putBoolean: true ]
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops binary'] }
TFOperation >> + aTFOperation [
	^ self binaryOp: 'Add' with: aTFOperation
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops binary'] }
TFOperation >> - aTFOperation [
	^ self binaryOp: 'Sub' with: aTFOperation
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops binary'] }
TFOperation >> -= aTFOperation [
	^ self binaryOp: 'AssignSub' with: aTFOperation
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops binary'] }
TFOperation >> > aTFOperation [
	^ self binaryOp: 'Greater' with: aTFOperation
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops binary'] }
TFOperation >> @* aTFOperation [
	^ self binaryOp: 'Mul' with: aTFOperation
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops binary'] }
TFOperation >> @/ aTFOperation [
	^ self binaryOp: 'Div' with: aTFOperation
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops binary'] }
TFOperation >> \* aTFOperation [
	^ self
		binaryOp: 'MatMul'
		with: aTFOperation
		described: [ :description | description at: 'transpose_a' putBoolean: true ]
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops binary'] }
TFOperation >> \\ aTFOperation [
	^ self binaryOp: 'Mod' with: aTFOperation
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops unary'] }
TFOperation >> abs [
	^ self unaryOp: 'Abs'
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops unary'] }
TFOperation >> alias: nameString [
	^ self unaryOp: 'Identity' named: nameString
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops unary'] }
TFOperation >> arcCos [
	^ self unaryOp: 'Acos'
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops unary'] }
TFOperation >> arcSin [
	^ self unaryOp: 'Asin'
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops unary'] }
TFOperation >> arcTan [
	^ self unaryOp: 'Atan'
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops binary'] }
TFOperation >> assign: aTFOperation [
	^ self
		binaryOp: 'Assign'
		with: aTFOperation
		named: self name , '_initializer'
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops binary'] }
TFOperation >> binaryOp: aString with: aTFOperation [
	^ self
		binaryOp: aString
		with: aTFOperation
		described: [ :nothing |  ]
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops binary'] }
TFOperation >> binaryOp: aString with: aTFOperation described: oneArgBlock [
	| name |
	name := self nameFor: aString.
	^ self
		binaryOp: aString
		with: aTFOperation
		named: name
		described: oneArgBlock
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops binary'] }
TFOperation >> binaryOp: aString with: aTFOperation named: name [
	^ self
		binaryOp: aString
		with: aTFOperation
		named: name
		described: [ :nothing |  ]
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops binary'] }
TFOperation >> binaryOp: aString with: aTFOperation named: name described: oneArgBlock [
	^ self
		op: aString
		withAll:
			((Array new: 1)
				at: 1 put: aTFOperation;
				yourself)
		named: name
		described: oneArgBlock
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops binary'] }
TFOperation >> castTo: typeInteger [
	^ self
		unaryOp: 'Cast'
		described: [ :description | description at: 'DstT' putType: typeInteger ]
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops unary'] }
TFOperation >> cos [
	^ self unaryOp: 'Cos'
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops other'] }
TFOperation >> descent: delta rate: learningRate [
	^ self
		op: 'ApplyGradientDescent'
		withAll:
			((Array new: 2)
				at: 1 put: learningRate;
				at: 2 put: delta;
				yourself)
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops unary'] }
TFOperation >> exp [
	^ self unaryOp: 'Exp'
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops binary'] }
TFOperation >> findMaxOn: aTFOperation [
	^ self binaryOp: 'ArgMax' with: aTFOperation
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops binary'] }
TFOperation >> findMinOn: aTFOperation [
	^ self binaryOp: 'ArgMin' with: aTFOperation
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops unary'] }
TFOperation >> identity [
	^ self unaryOp: 'Identity'
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops unary'] }
TFOperation >> inverse [
	^ self unaryOp: 'MatrixInverse'
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops binary'] }
TFOperation >> meanOn: shapeTensorOrOperation [
	^ self binaryOp: 'Mean' with: shapeTensorOrOperation
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops other'] }
TFOperation >> nameFor: namePrefix [
	^ graph nameFor: namePrefix
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops unary'] }
TFOperation >> negated [
	^ self unaryOp: 'Neg'
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops other'] }
TFOperation >> op: aString withAll: aTFOperationArray [
	^ self
		op: aString
		withAll: aTFOperationArray
		described: [ :nothing |  ]
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops other'] }
TFOperation >> op: aString withAll: aTFOperationArray described: oneArgBlock [
	| name |
	name := self nameFor: aString.
	^ self
		op: aString
		withAll: aTFOperationArray
		named: name
		described: oneArgBlock
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops other'] }
TFOperation >> op: aString withAll: aTFOperationArray named: name [
	^ self
		op: aString
		withAll: aTFOperationArray
		named: name
		described: [ :nothing |  ]
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops other'] }
TFOperation >> op: aString withAll: aTFOperationArray named: name described: oneArgBlock [
	^ graph
		newOperation: aString
		named: name
		described: [ :description | 
			description addInput: self firstOutput.
			aTFOperationArray
				do: [ :each | 
					| input |
					input := (each asOperationOn: graph) firstOutput.
					description addInput: input ].
			oneArgBlock value: description ]
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops unary'] }
TFOperation >> rectified [
	^ self unaryOp: 'Relu'
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops unary'] }
TFOperation >> shape [
	^ self unaryOp: 'Shape'
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops unary'] }
TFOperation >> sigmoid [
	^ self unaryOp: 'Sigmoid'
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops unary'] }
TFOperation >> sin [
	^ self unaryOp: 'Sin'
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops binary'] }
TFOperation >> sizeOn: dimensionInteger [
	^ self shape
		sliceFrom:
			((Array new: 1)
				at: 1 put: dimensionInteger;
				yourself) asInt32Tensor
		size: #(1) asInt32Tensor
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops other'] }
TFOperation >> sliceFrom: begin size: size [
	^ self
		op: 'Slice'
		withAll:
			((Array new: 2)
				at: 1 put: begin;
				at: 2 put: size;
				yourself)
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops unary'] }
TFOperation >> softmax [
	^ self unaryOp: 'Softmax'
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops binary'] }
TFOperation >> sparseSoftmaxCrossEntropyWithLogits: aTFOperation [
	^ self
		binaryOp: 'SparseSoftmaxCrossEntropyWithLogits'
		with: aTFOperation
		named: (self nameFor: 'SparseSoftmaxCrossEntropyWithLogits')
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops unary'] }
TFOperation >> squared [
	^ self @* self
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops binary'] }
TFOperation >> sumOn: aTFOperation [
	^ self binaryOp: 'Sum' with: aTFOperation
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops unary'] }
TFOperation >> tan [
	^ self unaryOp: 'Tan'
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops binary'] }
TFOperation >> timesRectifiedGradOf: aTFOperation [
	^ self binaryOp: 'ReluGrad' with: aTFOperation
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops unary'] }
TFOperation >> unaryOp: aString [
	| name |
	name := self nameFor: aString.
	^ self unaryOp: aString named: name
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops unary'] }
TFOperation >> unaryOp: aString described: oneArgBlock [
	| name |
	name := self nameFor: aString.
	^ self unaryOp: aString named: name described: oneArgBlock
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops unary'] }
TFOperation >> unaryOp: aString named: name [
	^ self unaryOp: aString named: name described: [ :description |  ]
]

{ #category : '*TensorFlowDeprecatedCore',
 #vaCategories : ['ops unary'] }
TFOperation >> unaryOp: aString named: name described: oneArgBlock [
	^ self
		op: aString
		withAll:
			((Array new: 0)
				yourself)
		named: name
		described: oneArgBlock
]
