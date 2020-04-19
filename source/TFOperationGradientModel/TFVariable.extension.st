Extension {
	#name : 'TFVariable'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFVariable >> partialDerivativeWithRespectTo: aVariable [

	| filledValue |

	filledValue := (aVariable = self) ifTrue: [1] ifFalse: [0].
	^TFConstant
		on: self currentComputation
		shaped: value outputShape
		filledWith: (TFTensor fromNumbers: filledValue type: value outputType)
]
