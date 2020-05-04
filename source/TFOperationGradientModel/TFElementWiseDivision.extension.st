Extension {
	#name : 'TFElementWiseDivision'
}

{ #category : '*TFOperationGradientModel',
 #vaCategories : ['Gradients'] }
TFElementWiseDivision >> derivativeWithRespectTo: aVariable [

	aVariable = numerator ifTrue: [^denominator reciprocal].
	aVariable = denominator ifTrue: [^(numerator / (denominator squared)) negated].

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

	a := (numerator partialDerivativeWithRespectTo: aVariable) * denominator.
	b := numerator * (denominator partialDerivativeWithRespectTo: aVariable).

	^(a - b) / (denominator squared)
]
