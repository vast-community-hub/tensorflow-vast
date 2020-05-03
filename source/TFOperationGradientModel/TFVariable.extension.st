Extension {
	#name : 'TFVariable'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Accessing'] }
TFVariable >> inputsDo: aBlock [

	
	
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFVariable >> partialDerivativeWithRespectTo: aVariable [

	| filledValue |

	filledValue := (aVariable = self) ifTrue: [1] ifFalse: [0].
	^TFConstant like: value filledWith: filledValue
]
