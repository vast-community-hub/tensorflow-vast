Extension {
	#name : 'TFElementWiseDivision'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFElementWiseDivision >> derivativeWithRespectTo: aVariable [

	aVariable = numerator ifTrue: [^TFReciprocal of: denominator].
	aVariable = denominator
		ifTrue: [
			^(TFElementWiseDivision of: numerator and: (TFElementWiseSquare of: denominator)) negated].

	self raiseIsNotDifferentiableRespectTo: aVariable
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Accessing'] }
TFElementWiseDivision >> inputsDo: aBlock [

	aBlock value: numerator.
	aBlock value: denominator
]

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFElementWiseDivision >> partialDerivativeWithRespectTo: aVariable [

	| a b |

	a :=
		TFElementWiseMultiplication
			of: (numerator partialDerivativeWithRespectTo: aVariable)
			and: denominator.
	b :=
		TFElementWiseMultiplication
			of: numerator
			and: (denominator partialDerivativeWithRespectTo: aVariable).

	^TFElementWiseDivision
		of: (TFSubstraction of: a minus: b)
		and: (TFElementWiseSquare of: denominator)
]
