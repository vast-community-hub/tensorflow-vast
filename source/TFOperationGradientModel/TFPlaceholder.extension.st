Extension {
	#name : 'TFPlaceholder'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Not categorized'] }
TFPlaceholder >> partialDerivativeWithRespectTo: aVariable [

	| filledValue |

	filledValue := aVariable = self ifTrue: [1] ifFalse: [0].
	^TFConstant like: self filledWith: filledValue
]
