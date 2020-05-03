Extension {
	#name : 'TFReciprocal'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFReciprocal >> derivativeWithRespectTo: aVariable [

	aVariable = operation
		ifTrue: [
			^TFReciprocalGradient
				considering: self
				andGradientsOfInputs: (TFConstant like: self filledWith: 1)].

	self raiseIsNotDifferentiableRespectTo: aVariable
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Accessing'] }
TFReciprocal >> inputsDo: aBlock [

	aBlock value: operation
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFReciprocal >> partialDerivativeWithRespectTo: aVariable [

	^TFReciprocalGradient
		considering: self
		andGradientsOfInputs: (operation partialDerivativeWithRespectTo: aVariable)
]
