Extension {
	#name : 'TFSum'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFSum >> derivativeWithRespectTo: aVariable [

	(operands includes: aVariable) ifTrue: [^TFConstant like: self filledWith: 1].

	self raiseIsNotDifferentiableRespectTo: aVariable
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFSum >> inputsDo: aBlock [

	operands do: aBlock
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFSum >> partialDerivativeWithRespectTo: aVariable [

	^TFSum ofAll: (operands collect: [:operand | operand partialDerivativeWithRespectTo: aVariable])
]
