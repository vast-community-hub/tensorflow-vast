Extension {
	#name : 'TFConstant'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Instance Creation'] }
TFConstant class >> like: anOperation filledWith: aValue [

	^self
		on: anOperation currentComputation
		shaped: anOperation value outputShape
		filledWith: aValue
		castedTo: anOperation value outputType
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Instance Creation'] }
TFConstant class >> on: aComputation shaped: aShape filledWith: aValue castedTo: aType [

	^self
		on: aComputation
		named: 'Const'
		shaped: aShape
		filledWith: (TFTensor fromNumbers: aValue type: aType)
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFConstant >> inputsDo: aBlock [

	
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFConstant >> partialDerivativeWithRespectTo: aVariable [

	| filledValue |

	filledValue := aVariable = self ifTrue: [1] ifFalse: [0].
	^TFConstant like: self filledWith: filledValue
]
