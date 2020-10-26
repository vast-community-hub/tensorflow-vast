Extension {
	#name : 'VariableNode'
}

{ #category : '*TFVariableSpecificationModel',
 #vaCategories : ['Instance Creation'] }
VariableNode class >> on: aComputation named: aName filledWithZerosLike: anOperation [

	^self
		on: aComputation
		named: aName
		of: anOperation value outputType
		shaped: anOperation value outputShape
		initializedWith: ConstantInitializer withZeros
]

{ #category : '*TFVariableSpecificationModel',
 #vaCategories : ['Instance Creation'] }
VariableNode class >> on: aComputation named: aName with: aTensor [

	^self
		on: aComputation
		named: aName
		of: aTensor type
		shaped: aTensor shape
		initializedWith: (ConstantInitializer with: aTensor)
]
