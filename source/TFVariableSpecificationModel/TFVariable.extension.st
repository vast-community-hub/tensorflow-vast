Extension {
	#name : 'TFVariable'
}

{ #category : '*TFVariableSpecificationModel',
 #vaCategories : ['Instance Creation'] }
TFVariable class >> on: aComputation named: aName with: aTensor [

	^self
		on: aComputation
		named: aName
		of: aTensor type
		shaped: aTensor shape
		initializedWith: (TFConstantInitializer with: aTensor)
]
