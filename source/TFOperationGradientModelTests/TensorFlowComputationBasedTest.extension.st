Extension {
	#name : 'TensorFlowComputationBasedTest'
}

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test Support'],
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assertPartialDerivativeOf: anOperation withRespectTo: anInput isCloseTo: anExpectedValue [

	| derivativeUsingForward derivativeUsingReverse |

	derivativeUsingForward :=
		(AutoDiffForwardMode startingWith: anOperation withRespectTo: anInput) partialDerivativeValue.
	derivativeUsingReverse :=
		(AutoDiffReverseMode startingWith: anOperation) partialDerivativeOf: anInput.

	self
		assertOutputOf: (anOperation partialDerivativeWithRespectTo: anInput)
			isFloatScalarCloseTo: anExpectedValue;
		assertOutputOf: derivativeUsingForward isFloatScalarCloseTo: anExpectedValue;
		assertOutputOf: derivativeUsingReverse isFloatScalarCloseTo: anExpectedValue
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test Support'],
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assertPartialDerivativeOf: anOperation withRespectTo: anInput isMatrixCloseTo: anExpectedValue [

	| derivativeUsingForward derivativeUsingReverse |

	derivativeUsingForward :=
		(AutoDiffForwardMode startingWith: anOperation withRespectTo: anInput) partialDerivativeValue.
	derivativeUsingReverse :=
		(AutoDiffReverseMode startingWith: anOperation) partialDerivativeOf: anInput.

	self
		assertOutputOf: (anOperation partialDerivativeWithRespectTo: anInput)
			isMatrixCloseTo: anExpectedValue;
		assertOutputOf: derivativeUsingForward isMatrixCloseTo: anExpectedValue;
		assertOutputOf: derivativeUsingReverse isMatrixCloseTo: anExpectedValue
]

{ #category : '*TFOperationGradientModelTests',
 #vaCategories : ['Test Support'],
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assertPartialDerivativeOf: anOperation withRespectTo: anInput isVectorCloseTo: anExpectedValue [

	| derivativeUsingForward derivativeUsingReverse |

	derivativeUsingForward :=
		(AutoDiffForwardMode startingWith: anOperation withRespectTo: anInput) partialDerivativeValue.
	derivativeUsingReverse :=
		(AutoDiffReverseMode startingWith: anOperation) partialDerivativeOf: anInput.

	self
		assertOutputOf: (anOperation partialDerivativeWithRespectTo: anInput)
			isFloatVectorCloseTo: anExpectedValue;
		assertOutputOf: derivativeUsingForward isFloatVectorCloseTo: anExpectedValue;
		assertOutputOf: derivativeUsingReverse isFloatVectorCloseTo: anExpectedValue
]
